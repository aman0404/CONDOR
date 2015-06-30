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

# "cd" to the are where you have installed your CMSSW release, e.g:
# cd /uscms_data/d2/florez/TagAndProbe_BSM3G_TNT_Analyzer/CMSSW_7_4_1/src

cd CHANGE_THIS_FOR_PATH_TO_YOUR_CMSSW_SRC_AREA
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scram runtime -sh`
echo $_CONDOR_SCRATCH_DIR
cd ${_CONDOR_SCRATCH_DIR}

# Copy the directory where you have the compiled code, e.g.:
# cp -r /uscms_data/d2/florez/TagAndProbe_BSM3G_TNT_Analyzer/CMSSW_7_4_1/src/Fermilab_TauHAT2015/muonToTauFakeRate . 
cp -r CHANGE_THIS_FOR_PATH_TO_YOUR_ANALYSIS_CODE .

# "cd" in to the analysos code directory, e.g:
# cd muonToTauFakeRate
cd CHANGE_THIS_FOR_ANALYSIS_DIRECTORY
./BSM_Analysis $fname $outputfile

echo "LIST BEFORE MOVING"
ls ${_CONDOR_SCRATCH_DIR}

# Also, and very important: You need to create directories in eos
# with matching names to those is the lists (Ntuples_DYtoLL_Spring15)
# The reason why I am sending the output to EOS is because someone told me at fermilab 
# that when submmiting a large number of jobs we can saturate the EOS system by 
# copying files directly and no with the xrdcp convention, which I think 
# it allows the system handle jobs according to how busy it is....
# if you can to copy the files directly, you can modify the line below
# but you get yell at, I warned you :) 

#Copy the output to your EOS area, e.g:
#xrdcp $_CONDOR_SCRATCH_DIR/muonToTauFakeRate/$outputfile  root://cmseos.fnal.gov//store/user/florez/TNT_Analyzer_Condor/$outputdir

xrdcp $_CONDOR_SCRATCH_DIR/CHANGE_THIS_FOR_ANALYSIS_DIRECTORY/$outputfile root://cmseos.fnal.gov//store/user/florez/YOUR_OUTPUT_DIRECTORY/$outputdir

cd ${_CONDOR_SCRATCH_DIR}
rm -rf CHANGE_THIS_FOR_ANALYSIS_DIRECTORY

echo "List after moving/removing everything"
ls ${_CONDOR_SCRATCH_DIR}

date
