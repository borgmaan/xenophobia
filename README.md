# Xenophobia

### Reading List
* [I actually found this paper last, but you should read it first.](http://www.scfbm.org/content/pdf/1751-0473-8-7.pdf)
* [I am a really big Karl Broman fan.](http://kbroman.wordpress.com/2013/08/20/electronic-lab-notebook/)
* [I also like C Titus Brown.](http://ivory.idyll.org/blog/proselytizing-version-control.html)
* [Continued.](http://ivory.idyll.org/blog/research-software-reuse.html)

### Name Description
Naming this demo 'Xenophobia' because it is about xenograft model analysis, and because we are irrationally afraid of version control systems.

### Project Description
Urgent **grant related** analysis request from MacKeigan Lab for a bunch of xenograft experiments. Experiments performed in 5 mouse models with 6 treatment tracks in each model. I figured this would be a good example of a project to begin leveraging git for my own research work.

### Goals
Deliver quality analysis and illustrate ease of use and usefulness of git for code/project management.   

### Data Description
Xenograft growth data files can be found in the ./data/ directory. Each treatment X Model group has it's own file -- giving 30 data files in total. I ripped these out of a multi-sheet Excel file that was output from GraphPad :/

### GitHub/Git Integration

#### What do I propose?
**We should totally use git for project management**

#### Why we should do it
* Gives us the chance to do **reproducible** research
	* Physically documents project lifecycle
		* Commit @ logical stopping points to show project development
	* Ensures accountability to clients
		* Can create the project report/results with just code and data 
		* No more (I swear this was significant when I got the p-value on my machine...)
	* Can follow my structure
		* Use R to create all images and tables (TeX) directly from your data 
		* Use LyX for a MS Word substitute for report creation
		* Export LaTeX source from LyX file
		* Create Makefile that runs your R code, creates your figures, then compiles your report using pdflatex or something like that 
		* http://kbroman.github.io/minimal_make/ :: Like this!
* Encourage good coding habits
	* There a reason software development projects use version control
	* Would totally eliminate multiple file versions
	* The dreaded analysis_1.2012.2.3.1415926535.R
	* I realized I needed to do this for my tumorgraft analyses
		* For both the power analyses and the XenoCat analyses
		* Would love to hear feedback on these things from people who know more than me (active coding community)
* Allows us to collaborate without pulling our hair
	* It is really the only sane way to work on software simultaneously
	* Could become more important as we get larger, more multi-analyst projects like HF
* It's not hard
	* A few simple commands and concepts are all you need
	* Got our team of 3 coders from my former lab up and running in less than a day
* We could make some really great graphs
	* https://github.com/chrishunt/git-pissed
* Git is a distributed version control system
	* No need for a centralized server (like SVN)
	* Could just keep a master repo on cluster (maybe w/ share mounted?)
	* Clone down code when you work on a project
		* I would also advocate for formally separting our data and our code 
	* Easily adaptable to our current directory structure
		* Each project is a repo
	* Could keep data in repos 
		* This allows for audit-like tracking of an experiments data over the course of the analysis
* For time tracking, why not merge our timesheets and our notebooks. 
	* Work entries would just get a special markdown flag and look like this:
	* ##### 8/28/2013	12:00-2:48 AM	2.75	GitHub Party
	* Parsing this is just as easy as the system we have set up right now
		* I'll write it ;)
	* Markdown has all the formatting options we could ever want and they are super easy to pick up
	* You can even embed images:
	![](CRC02_AZD8055_alone_vs_Vechicle.pdf?raw=true)
	* Tables too!
| First Header  | Second Header |
| ------------- | ------------- |
| Row1 Cell1    | Row1 Cell2    |
| Row2 Cell1    | Row2 Cell2    |
	* Well, if we used [pandoc](http://johnmacfarlane.net/pandoc/) they would be there :)

##### PLUS, IT GIVES US THE SHARED CODE REPOSITORY!!!
* Share code with each other and everyone around VARI
* I would just point you @ a repo you could use
	* Then you could fork it, yo :)
	* Allows us to identify which pieces of code we use most.
	* Optimize these? I'm reaching here... 
***Could also just make everything public**
	* Use GitHub
	* Give back to the research community
	* Could pay for a GitHub plan that allows us to have some private repos (for special [secret] projects)
	* Make almost all our code freely available
		* All the cool kids are doing it
		* VARI probably won't like this
	* We're standing on the shoulders of giants
		* Would be nowhere without Bioconductor
		* Should try to give back
	* Shouldn't everyone benefit from what we're doing?

### Analysis approach
* All analyses were performed using the methods described in [Laajala et. al.](http://clincancerres.aacrjournals.org/content/early/2012/07/19/1078-0432.CCR-11-3215.full.pdf).
* Per Treatment X Model MCMC p-values were reported for fixed effect of treatment
* Graphs of the individual treatment comparisons are reported to examine what kinds of experimental outcomes are considered significant by XenoCat.

### Results
Jeff was happy:
> Andrew,
> This is great. I thank you for the fast turnaround and also the p-values and additional insights. Very helpful for sure. Certainly the PD alone was impressive in all but one or two models. 
> Jeff

### Case Study Notebook

##### 8/28/2013	8:00-11:00 PM	GitHub Party (2.0)
0. Made LyX report structure more portable by moving table and image directories into report subdir
	* Updated TeX files and R code to support conversion. 
1. Re-ran to make sure everything worked... it did!
2. Updated README.md for public viewing.
3. Emailed everyone about this project.
**Next steps: Get some slides together for presentation on Thursday.**

##### 8/28/2013	12:00-2:48 AM	2.75	GitHub Party
0. Created GitHub repo for JM_10 project.
1. Modified files for portability.
2. Should probably get even fancier.
**Next steps: Get some slides together for presentation on Thursday.**

##### 8/28/2013	10:00-11:00 AM	1	Results reporting
0. Drafted email with observations for my XenoCat analysis.
1. Emailed back and forth with Anita and Dani to address their responses.
2. Set up cloned version of project directory on the cluster that Anita would be able to access/use. If I had more time I’d make this git-enabled. 
3. Talked to Dani about what was casing some of the comparisons to be insignificant. 
4. Discussed with her as to what might be the best graphical representation of the data. 
**Next steps: Wait to hear if they want to you do anything else. Wait to hear from Jeff.**

####	8/27/2013	6:00-10:30 PM	Analysis of the XenoCats
0. Got data tumor growth data from Dani.
1. Ripped it out of Excel and put it in model X treatment specific files
2. Wrote R code to read in data and merge it all together. 
3. Wrote R code to automate all comparisons of interest. 
4. Wrote R code to make nice plots to visualize what is going on at each comparison. 
5. Wrote R code to create summary tables with p-values. 
6. Debugged all that written code – almost no bugs, nice!
7. Took output and jammed it into a LyX report. 
8. Took a look at the results and make some notes on how 
**Next steps: Send them the results tomorrow and get their feedback.**



