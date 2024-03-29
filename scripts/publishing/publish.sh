DITA_OT=bin/oxygen-publishing-engine-3.x

echo "Downloading Oxygen Pusblishing Engine"
if [[ ! -e bin/oxygen-publishing-engine-3.x.zip ]];
then
  mkdir bin
  
  curl -q -L https://www.oxygenxml.com/InstData/PublishingEngine/oxygen-publishing-engine-3.x.zip --output oxygen-publishing-engine-3.x.zip
  
  ls -l oxygen-publishing-engine-3.x.zip
  
  unzip -q oxygen-publishing-engine-3.x.zip -d bin/
  
  echo "===LOG Pub engine==="
  ls bin/oxygen-publishing-engine-3.x
fi


pwd

echo "===Copy webhelp license key====="
cp scripts/publishing/licensekey.txt $DITA_OT/plugins/com.oxygenxml.webhelp.responsive/licensekey.txt

echo "====================================="
echo "Add Edit Link to DITA-OT"
echo "====================================="

echo "Using REPOSITORY_URL $REPOSITORY_URL" 
SLUG=`echo $REPOSITORY_URL | sed 's/git@github.com://' | sed 's/https:\/\/.*github.com\///'`
echo "Slug: $SLUG"
USERNAME=`echo $SLUG | cut -d '/' -f 1`
REPONAME=`echo $SLUG | cut -d '/' -f 2`

mkdir bin/plugins
# Add the editlink plugin
git clone https://github.com/oxygenxml/dita-reviewer-links bin/plugins/
cp -R bin/plugins/com.oxygenxml.editlink $DITA_OT/plugins/

export WELCOME="<div>Welcome</div>"
# Send some parameters to the "editlink" plugin as system properties
export ANT_OPTS="$ANT_OPTS -Deditlink.remote.ditamap.url=github://getFileContent/$USERNAME/$REPONAME/$BRANCH/source/markdown-dita/garage.ditamap -Deditlink.web.author.url=https://www.oxygenxml.com/oxygen-xml-web-author/"
# Send parameters for the Webhelp styling.
export ANT_OPTS="$ANT_OPTS -Dwebhelp.fragment.welcome='$WELCOME'"



echo "====================================="
echo "integrate plugins"
echo "====================================="
cd $DITA_OT
bin/ant -f integrator.xml
cd ../..

export FEEDBACK_FILE=`realpath scripts/publishing/feedback-install.xml`
echo $FEEDBACK_FILE
cat $FEEDBACK_FILE

pwd

sh $DITA_OT/bin/dita \
    --format=webhelp-responsive \
    --input=source/markdown-dita/garage.ditamap \
    --output=bin/out/webhelp \
    -Dwebhelp.fragment.feedback=$FEEDBACK_FILE
	
