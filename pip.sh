#!/bin/bash
##script to pip VCF HG38 dans ANNOVAR avec conversion et annotation multiple
##Christophe Desterke_21 fev 2018
## sh pip.sh input.vcf (entrer le nom du VCF input en parametre de commande)

nom_fichier=$(echo $1 | sed -re 's/(.*).vcf/\1/')


UPTIME1=`uptime`

##conversion du VCF en AVinput ANNOVAR
perl convert2annovar.pl -format vcf4  $1 -outfile outav 

UPTIME2=`uptime`

perl table_annovar.pl outav humandb/ -buildver hg38 -out output -remove -protocol cytoBand,refGene,avsnp147,exac03,dbnsfp30a,clinvar_20170905,cosmic70 -operation r,gx,f,f,f,f,f -nastring . -csvout -polish -xref example/gene_xref.txt

UPTIME3=`uptime`

mv output.hg38_multianno.csv $(echo output.hg38_multianno.csv | sed "s/\./".$nom_fichier"\./")

rm outav



##log

echo "---------------------------------"
echo "log of the pipeline in ANNOVAR"
echo "analyse du ficher = $nom_fichier"
echo "--------------------"
cal
echo "--------------------"
echo "START"
echo "Uptime = $UPTIME1"
echo "-------------"
echo "convertion ok"
echo "Uptime = $UPTIME2"
echo "------------"
echo "annotation ok"
echo "Uptime = $UPTIME3"
echo "------------"

exit 0

