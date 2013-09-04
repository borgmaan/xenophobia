#!/usr/bin/env Rscript
# Andrew Borgman
# 8/27/2013
# VARI BBC
# Analysis of a bunch of xenograft experiments carried out by JM lab
library(reshape2)
library(ggplot2)
library(stringr)
library(grid)
library(XenoCat)
library(xtable)

#==================================================================#
#                           Config                                 #  
#==================================================================#

# DIRS
.home_dir = "~/Dropbox/bioinfo_core_work/xenophobia/"
.data_dir = str_c(.home_dir, "data/")
.report_dir = str_c(.home_dir, "report/")
.image_dir = str_c(.report_dir, "images/")
.table_dir = str_c(.report_dir, "tables/")
setwd(.home_dir)


#==================================================================#
#                       Data prep                                  #
#==================================================================#

# Helper helper function to parse files out and make them kind of long
stretch_file = function(infile_name){
  
  # Read 'er in
  dd = read.table(infile_name, header=T, stringsAsFactors=F, strip.white=T, sep="\t")
  
  # Stretch 'er out
  melted = melt(dd, id.vars=c('Day', 'Model', 'Treatment'))
  
  # Assign random ID number to go with letter ID 
  melted$variable = as.character(melted$variable)
  all_ids = unique(melted$variable)
  for (id in all_ids){
    new_id = str_c(id, sample(1:100000000, 1)) # pray for no collisions
    melted$variable[melted$variable == id] = new_id
  }
  
  # Name 'er -- do it!
  names(melted) = c('Day', 'Model', 'Treatment', 'ID', 'Size')  
  return(melted)  
}

# Helper function to agg files into long data format
df_from_files = function(file_list, source_dir=""){
  
  # Store all these in a list for safe keeping
  datas = vector('list', length=length(file_list))
  
  # Loop through all these and store 'em
  for (i in 1:length(file_list)){
    datas[[i]] = stretch_file(infile_name=str_c(source_dir, file_list[i]))
  }
  
  # Combine these into a df
  big_data = do.call('rbind', datas)
  
}


# Mouse models being studied
models = c('CRC02', 'CRC18', 'JPM09', 'JPM12', 'JPM16')
mouse_data = vector('list', length=length(models))
names(mouse_data) = models

# Loop though the models, grab their files, get them in the 
# format you want them, and store them in a file
for (mod in models){
  
  # Grab all files related to that mouse model 
  mod_files = dir(path=.data_dir, pattern=str_c(mod, "-*"))
  
  # Parse out those files
  mod_data = df_from_files(file_list=mod_files, source_dir=.data_dir)
  
  # Store in the right slot
  mouse_data[[mod]] = mod_data  
  
}


#==================================================================#
#                     Magic Stats                                  #
#==================================================================#

# Runs a XenoCat analysis and returns a MCMC p-value 
run_xeno = function(xeno_frame, treatment_name="", mn=""){
  
  # Create comparison name
  comparison_name = str_c(treatment_name, " vs Vechicle")
  print(comparison_name)
  
  # Name it how XenoCat likes it  (and get rid of model column)
  xeno_frame = xeno_frame[,-2]
  names(xeno_frame) = c('Timepoint', 'Treatment', 'Tumor_id', 'Response')
  xeno_frame$Treatment = factor(xeno_frame$Treatment, levels=c('Vehicle', treatment_name))
  xeno_frame$Treatment = as.numeric(xeno_frame$Treatment) - 1
  
  # Only looking @ positive growth data here
  xeno_frame = xeno_frame[which(xeno_frame$Timepoint >= 0), ]
  
  # Non-categorizing fit b/c all of our tumors grew
  nocat_fit = lmer(Response ~ 1 + Treatment + Timepoint + Timepoint:Treatment + (1|Tumor_id) + (0 + Timepoint|Tumor_id), data=xeno_frame)
  
  # Grab MCMC p-vals
  p_vals = xeno.fixef.pvals(nocat_fit, digits=3, MCMCsim=10000)
  p_val = p_vals['Treatment', 'MCMCpvals']
    
  # Make a pic of the tumor curves so you can see what is significant
  outfile_name = str_c(.image_dir, mn, "_", str_replace_all(string=comparison_name, pattern=" ", replacement="_"), ".pdf")
  pdf(file=outfile_name, height=5, width=5)
  xeno.draw.data(xeno_frame, maintitle=comparison_name)
  dev.off()
  
  # Return results
  ret_vec = c(mn, comparison_name, p_val)
  return(ret_vec)
}

# Runs all the Vehicle-Treatment XenoCat analyses for a mouse model
analyze_model = function(model_frame){
  
  # :)
  model_name = model_frame[1, 2]
  
  # Split up treted and untreated
  vehicle_sel = which(model_frame$Treatment == 'Vehicle')
  vehicle_dat = model_frame[vehicle_sel, ]
  treated_dat = model_frame[-vehicle_sel, ]
  
  # Figure out all the treatments we have and create results df
  treatments = unique(treated_dat$Treatment)
  model_results = data.frame(matrix(NA, ncol=3, nrow=length(treatments)))
  names(model_results) = c("Model", "Comparison", "MCMC P-Value")
  
  # Loop through treatments and run XenoCat analysis
  ctr = 1
  for (treatment in treatments){
    
    # Create data frame to feed to XenoCat
    tmp = treated_dat[which(treated_dat$Treatment == treatment), ]
    for_xeno = rbind(vehicle_dat, tmp)
    
    # Run XenoCat on comparison, return result, and store
    model_results[ctr, ] = run_xeno(xeno_frame=for_xeno, treatment_name=treatment, mn=model_name)
    
    # Increment counter 
    ctr = ctr + 1
  }  
  
  # Bring it back!
  return(model_results)  
}


# Store results here
mod_results = vector('list', length=length(models))
names(mod_results) = models

# Loop through mouse models, analyze each model's treatment effect
# and store results in list 
for (mouse_model in models){  
  print(mouse_model)
  mod_results[[mouse_model]] =  analyze_model(mouse_data[[mouse_model]]) # wow.
}

for (mouse_model in models){  
  print(xtable(mod_results[[mouse_model]]), include.rownames=FALSE, file=str_c(.table_dir, mouse_model, ".tex"))  
}

sessionInfo()

# Notes on what you see:
# > JPM09/PD0325901 alone vs Vechicle 0.024 is an example of what happens when you have enough samples. (4 by 6) and has the one control outlier
#     > JPM09 AZD8055 + PD0325901 vs Vechicle        0.263 is where you get screwed (4 by 5)
#     > JPM09  BEZ235 + PD0325901 vs Vechicle        0.314 same as this ^
# > JPM12/BEZ235  PD0325901 vs Vechicle 0.047 is an example of what happens when you have enough samples. (6 by 6)
# > JPM12        BEZ235 alone vs Vechicle            0 its all about the power (6 by 6)
# > JPM16 AZD8055 + PD0325901 vs Vechicle        0.141 hmm, not enough timepoints... too toxic short timeframe (6 by 7)
# > 

