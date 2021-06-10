#! /bin/bash                                                                         
#                                                                                     
# Another way to download the most recent version of spring boot default starter zip. 
# It's quick, easy and still uses curl. Can be implemented straight from the your     
# command line and customized to your liking. Configure the file to sb.sh and run ./sb 
# - it's that easy. Or, for fun, open start.spring.io in your    
# web browser.                                                                        
#                                                                                     
# Author : Wali Morris                                                                
#                                                                                     
######################################################################################
                                                                                      
XDG=$(which xdg-open)
URL="https://start.spring.io"

printf "Download basic spring boot project? [Y/n] "
read -r DOWNLOAD

if [ "$DOWNLOAD" == 'Y' ] || [ "$DOWNLOAD" == 'y' ]; then

  # Setup project
  printf "Which Build[ maven / gradle ]: "
  read -r BUILDTYPE

  printf "Base Dir: "
  read -r BASEDIR

  printf "Group id: "
  read -r GROUPID

  printf "Artifact id: "
  read -r ARTIFACTID

  printf "Project Name: "
  read -r PROJECTNAME

  printf "Project Description: "
  read -r PROJECTDESCRIPTION

  printf "Package Name: "
  read -r PACKAGENAME

  P1="type=%s-project&language=java&bootVersion=2.5.0.RELEASE&baseDir=%s&groupId" "$BUILDTYPE" "$BASEDIR"
  P2="=%s&artifactId=%s&name=%s&description=%s" "$GROUPID" "$ARTIFACTID" "$PROJECTNAME" "$PROJECTDESCRIPTION"
  P3="&packageName=%s&packaging=jar&ja" "$PACKAGENAME"
  REQ="${P1}${P2}${P3}"

  curl -d "$REQ" https://start.spring.io/starter.zip --output "$PROJECTNAME".zip

  printf "Check your system for %s.zip - run ls\n" "$PROJECTNAME"
  exit 1
fi
                                                                                      
printf "Fine, let's navigate to spring start!\n"                                      
if [ -z "$XDG" ]; then                                                                
   printf "Dependencies not available on this system.\n"                              
   printf "Proceed to install dependencies? [Y/n]? "                                  
   read -r PERMISSION
   if [ "$PERMISSION" == 'Y' ]; then
       sudo apt update                                                                
       sudo apt install xdg-utils                                                     
   else                                                                               
       exit 1                                                                         
   fi                                                                                 
fi                                                                                    
                                                                                    
xdg-open $URL                                                                        
exit 1
