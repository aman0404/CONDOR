#!/bin/bash

fname=$1
outputfile=$2

date
cd /uscms_data/d2/florez/TagAndProbe_BSM3G_TNT_Analyzer/
tar -cvf CMSSW_7_4_1.tar CMSSW_7_4_1/*
chmod 755 CMSSW_7_4_1.tar
echo $_CONDOR_SCRATCH_DIR
cd ${_CONDOR_SCRATCH_DIR}
mv /uscms_data/d2/florez/TagAndProbe_BSM3G_TNT_Analyzer/CMSSW_7_4_1.tar .
tar -zxvf CMSSW_7_4_1.tar
cd CMSSW_7_4_1/src/
source /cvmfs/cms.cern.ch/cmsset_default.csh
eval `scram runtime -csh`
cd Condor
./BSM_Analysis fname outputfile

echo "LIST BEFORE MOVING"
ls ${_CONDOR_SCRATCH_DIR}
cp $_CONDOR_SCRATCH_DIR/Condor/outputfile  /eos/uscms/store/user/florez/TNT_Analyzer_Condor/EOSDIR

cd ${_CONDOR_SCRATCH_DIR}
rm -rf Condor

echo "List after moving/removing everything"
ls ${_CONDOR_SCRATCH_DIR}

date
