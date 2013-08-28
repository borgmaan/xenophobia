# Xenophobia

### Name Description
Naming this demo 'Xenophobia' because it is about xenograft model analysis and because we are irrationally afraid of SCM.

### Project Description
Urgent **grant related** analysis request from MacKeigan Lab for a bunch of xenograft experiments. Experiments performed in 5 mouse models with 6 treatment tracks in each model. I figured this would be a good example of a project to begin implementing the *SCM related practices* I've been talking so much about.

### Goals
Deliver quality analysis and illustrate ease of use and overall usefulness of git SCM for code/project management.   

### Data Description
Mouse data files can be found in the data/ directory. Treatment X Model group has it's own file -- giving 30 data files in total. 

### GitHub/Git Integration

#### What do I propose?
##### We should totally use git for project management

#### Why we should do it
* http://kbroman.wordpress.com/2013/08/20/electronic-lab-notebook/
	* This one really applies for our day-to-day work
* http://www.scfbm.org/content/pdf/1751-0473-8-7.pdf
* http://ivory.idyll.org/blog/proselytizing-version-control.html
* http://ivory.idyll.org/blog/research-software-reuse.html
* Encourage good coding habits
	* There a reason software development projects use version control
	* Would totally eliminate multiple file versions
	* The dreaded analysis_1.2012.2.3.1415926535.R
	* I realized I needed to do this for my tumorgraft analyses
		* For both the power analyses and the XenoCat analyses
		* Would love to hear feedback on these things from people who know more than me (active coding community)
* It's not hard
	* A few simple commands and concepts are all you need
	* Got our team of 3 coders from my former lab up and running in less than a day
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
* Gives us the chance to do **reproducible** research
	* Can follow my structure
		* Use R to create all images and tables (TeX) directly from your data 
		* Use LyX for a MS Word substitute for report creation
		* Export LaTeX source from LyX file
		* Create Makefile that runs your R code, creates your figures, then compiles your report using pdflatex or something like that 
		* http://kbroman.github.io/minimal_make/ :: Like this!

##### PLUS, IT GIVES US THE SHARED CODE REPOSITORY!!!
* Share code with each other and everyone around VARI
* I would just point you @ a repo you could use
* Could also just make everything public
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
* Graphs of the individual treatment comparisons are reported along with significance measures. 
