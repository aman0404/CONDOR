#########################################################
#                                                       #
#  Author: Andres Florez, Unviersidad de los Andes, CO  #
#                                                       #
#########################################################

#!/bin/bash
# These input parameters are going to be passed to the 
# script from the submit_condor_jobs.cmd script, 
# which takes the input from the run_code.sh 
 
fname=$1
outputfile=$2
outputdir=$3

date

# You need to set the enviroment to get ROOT 
# You need to modify the lines below to point to your
# CMSSW area. 
#Also, please read the carefully the comments below.

cd /uscms_data/d2/florez/TagAndProbe_BSM3G_TNT_Analyzer/CMSSW_7_4_1/src
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scram runtime -sh`
echo $_CONDOR_SCRATCH_DIR
cd ${_CONDOR_SCRATCH_DIR}
cp -r /uscms_data/d2/florez/TagAndProbe_BSM3G_TNT_Analyzer/CMSSW_7_4_1/src/Condor .
cd Condor
./BSM_Analysis $fname $outputfile

echo "LIST BEFORE MOVING"
ls ${_CONDOR_SCRATCH_DIR}

# Also, and very important: You need to create directories in eos
# with matching names to those is the lists (WJets_HT100To600, WJets_HT200To400, etc)
# The reason why I am sending the output to EOS is because someone told me at fermilab 
# that when submmiting a large number of jobs we can saturate the EOS system by 
# copying files directly and no with the xrdcp convention, which I think 
# it allows the system handle jobs according to how busy it is....
# if you can to copy the files directly, you can modify the line below
# but you get yell at, I warned you :) 

xrdcp $_CONDOR_SCRATCH_DIR/Condor/$outputfile  root://cmseos.fnal.gov//store/user/florez/TNT_Analyzer_Condor/$outputdir

cd ${_CONDOR_SCRATCH_DIR}
rm -rf Condor

echo "List after moving/removing everything"
ls ${_CONDOR_SCRATCH_DIR}

date
