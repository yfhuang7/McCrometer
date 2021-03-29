# McCrometer

### Description
In this project, I am doing auto-download data from McCrometer, auto-update the near real-time data, and then visualize data on the gitpage, [tsangstreamlab](https://tsangstreamlab.github.io/).

[McCrometer](https://www.mccrometer.com/) provides flow instrument, and here, we use their data logger with [Iridium](https://www.iridium.com/company/mccrometer-inc/) satellite communication for the remote stream and rain gages in Hawaii for [TsangLab](https://yinphantsang.org/).


### System or software
These script works on **Linux system** with its *crontab*

For the "auto" part, you will need:
* To install *expect* tool along with *bash shell* to passthrough the requirement of username and password. (you might able to skip this if you know how to passthrough.)
    ```
    apt-get install expect
    ```
* Use *crontab -e* to set the time interval you want for executing your scripts. [crontab guru](https://crontab.guru/) is a quick and simple editor for cron schedule expressions by [Cronitor](https://cronitor.io/?utm_source=crontabguru&utm_campaign=cronitor_top)

For the visualization/R part, you will need:
* R with packages:
  * RCurl
  * XML
  * methods
  * bitops
  * reshape
  * lubridate
  * rmarkdown
  * leaflet
  * ggplot2
  * gridExtra


### Content
##### Directory:
**Result/**  The downloaded data

##### Shells:
**upload_McCrometer.sh**  The shell for executing visualization/R scripts, and upload to git.  
**Git_McCrometer**  The script file for answering the username and password while uploading git.  
**run_McCrometer.sh**  The shell that execute data download and upload. This shell is the one you want to schedule in the crontab.

##### Visualization/R:
**McCrometer_Download.R**  Download nearly real-time xml file from McCrometer, also calculate the rainfall intensity from the accumulated rainfall.  
**McCrometer_Visualization.Rmd**  Visualize nearly real-time gage data, and convert it into .html file.  
**Site_Info.csv**  Site information, especially location for the mapping in *McCrometer_Visualization.Rmd*  

### Example website
[TsangStreamLab Data](https://tsangstreamlab.github.io/)

### Note (pros and cons)
Pros:
* easy and fast
* doesn't need your own server
* free (not including the field part though)
* automatic download and upload
* good for a quick view or check gage's condition

cons:
* it's a static webpage rather than interaction webpage
* doesn't allow people to download data
* might have security issue for more important/confidential data
* depends on github
