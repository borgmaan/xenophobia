# Xenophobia

### Project Description
Urgent *grant related* analysis request from MacKeigan Lab for a bunch of xenograft experiments. Experiments performed in 5 mouse models with 6 treatment tracks in each model. I figured this would be a good example of a project to begin implementing the *SCM related practices* I've been talking so much about.

### Goals
Deliver quality analysis and illustrate ease of use and overall usefulness of git SCM for code/project management.   

### Data Description
Mouse data files can be found in the data/ directory. Treatment X Model group has it's own file -- giving 30 data files in total. 

### GitHub/Git Integration

#### My Thoughts

* We could totally use git for project management 
* Encourage good coding habits
	* Would totally eliminate multiple file versions
	* The dreaded analysis_1.2012.2.3.1415926535.R
	* I realized I needed to do this for my tumorgraft analyses
		* For both the power analyses and the XenoCat analyses
		* Would love to hear feedback on these things from people who know more than me (active coding community)
* If we host our own git server we could store all of our data there too.
	* This allows for audit-like tracking of an experiments data over the course of the analysis
* Easily adaptable to our current directory structure
```
/Base directory
	GVW/			<- These are the repos
		GVW_01/ 
	JM/
		JM_01
	BN/
```
* Check an investigator repo out 
	* Only grabbing code and report files
	* Just point @ where the data really is on the share

* For time tracking, why not merge our timesheets and our notebooks. 
* Work entries would just get a special markdown flag and look like this:
##### 8/28/2013	12:00-2:48 AM	2.75	GitHub Party
* That is just 5 hashtag markups on a tab-delimeted text line
* Parsing this is just as easy as the system we have set up right now
	* I'll write it


### Analysis approach
* All analyses were performed using the methods described in [Laajala et. al.](http://clincancerres.aacrjournals.org/content/early/2012/07/19/1078-0432.CCR-11-3215.full.pdf).
* Graphs of the individual treatment comparisons are reported along with significance measures. 
