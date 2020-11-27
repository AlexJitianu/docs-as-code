echo "====Copy landing page====="
mkdir -p bin/out/translation
mkdir -p bin/out/xslt-docs

cp source/index/index.html bin/out


echo "Create translation package "

ABS=$(readlink -f bin/out/translation)

echo $ABS

sh bin/oxygen/scripts/translationPackageBuilder.sh -gp -i source/markdown-dita/garage.ditamap -p $ABS/package.zip -verbose

echo "==LOG=="
ls bin/out/translation


echo "XSLT docs"
XSLT_ABS=$(readlink -f bin/out/xslt-docs)

echo $XSLT_ABS

sh bin/oxygen/scripts/stylesheetDocumentation.sh source/xslt/personal.xsl -format:html -out:$XSLT_ABS/personal.html

echo "==LOG=="
ls bin/out/translation

