cp -rf scripts/validate-check-completeness/scriptinglicensekey.txt  bin/oxygen/scriptinglicensekey.txt

rm -rf bin/tmp-vcc/
mkdir -p bin/tmp-vcc/

echo "Validate and check for completeness"

sh bin/oxygen/scripts/validateCheckDITA.sh -i source/markdown-dita/garage.ditamap -s scripts/validate-check-completeness/validate-check-completeness.xml -r bin/tmp-vcc/vcc-result.xml

echo "--RESULT--"
cat bin/tmp-vcc/vcc-result.xml

echo "Convert to Sonar"
java -cp bin/saxon9.jar net.sf.saxon.Transform -s:bin/tmp-vcc/vcc-result.xml -xsl:scripts/validate-check-completeness/validatation-results-to-sonar.xsl > bin/tmp-vcc/vcc-result-sonar.json


echo "--CONVERTED--"
cat bin/tmp-vcc/vcc-result-sonar.json
