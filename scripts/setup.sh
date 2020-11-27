echo "Downloading Saxon 9"
if [[ ! -e bin/saxon9.jar ]];
then
  mkdir bin
  touch bin/saxon9.jar
  curl -L -q https://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/9.9.1-8/Saxon-HE-9.9.1-8.jar > bin/saxon9.jar
fi

echo "Downloading Oxygen"
if [[ ! -e bin/oxygen.tar.gz ]];
then
  mkdir bin
  touch bin/oxygen.tar.gz
  curl -L -q https://mirror.oxygenxml.com/InstData/Editor/All/oxygen.tar.gz > bin/oxygen.tar.gz
  tar xzf bin/oxygen.tar.gz -C bin/
  
  
fi

echo "Copy scripting license key"
cp -rf scripts/validate-check-completeness/scriptinglicensekey.txt  bin/oxygen/scriptinglicensekey.txt

echo "Deploy translation package builder"

curl -L -q https://github.com/oxygenxml/oxygen-dita-translation-package-builder/releases/download/1.0.13/translation-package-builder-1.0.13-plugin.jar > bin/oxygen/scripts/translation-package-builder-1.0.13-plugin.jar

unzip -q bin/oxygen/scripts/translation-package-builder-1.0.13-plugin.jar -d bin/oxygen/plugins

echo "Log"

ls bin/oxygen/plugins/translation-package-builder-1.0.13
