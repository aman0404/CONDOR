#########################################################
#                                                       #
#  Author: Andres Florez, Unviersidad de los Andes, CO  #
#                                                       #
#########################################################

#!/bin/bash
# SAMPLE_LIST.txt has a list of names of the 
# processes you want to run over: DYJetsToLL, WJets, QCD etc.
# You need to create the lists by yourself at first, but once 
# we have stable ntuples I will provide lists for eveyone.
# you can create the list by doing e.g.: 
# ls /eos/uscms/store/user/florez/Ntuples_WJetsToLNu_HT-400To600/WJetsToLNu_HT-400To600_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/crab_NTuples_Wjets_HT-400To600/150608_204140/0000/ > WJets_HT400To600.txt
# Then, you can open the WJets_HT400To600.txt file and with a replace command 
# from your text editor you can change the "/eos/uscms" by "root\://cmseos.fnal.gov/"
# You have to create a separete list for each process you want to run over.
# In the SAMPLES_LIST.txt you only need to put the names of the lists in one coloum:
#
# WJets_HT100To600
# WJets_HT200To400
# WJets_HT400To600
#
  
for file in `cat SAMPLES_LIST.txt`; do
  echo $file
  sh run_code.sh $file
done
