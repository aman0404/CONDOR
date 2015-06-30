#########################################################
#                                                       #
#  Author: Andres Florez, Universidad de los Andes, CO  #
#                                                       #
#########################################################

/////////// PLEASE READ CAREFULLY THE COMMENTS IN THE SCRIPTS TO BE ABLE TO 
/////////// MODIFY THEM CORRECTLY FOR YOUR NEEDS

////// DESCRIPTION OF THE SCRIPTS

1. Ntuples_DYtoLL_Spring15.txt: Example list of ntuple files for inclusive DY-->ll+jets sample, from the Spring.
 
2. SAMPLES_LIST.txt: List with the names of the processes you want to run over (e.g  DY-->ll+jets, W+jets, ttbar etc.). 
The name of the processes should match the name of each list of files you want to run over.

3. run_samples_list.sh: script to iterate over the SAMPLES_LIST.txt. The script passes the process name to the run_code.sh script.

4. run_code.sh: script to iterat over the files in a give list. The script passes input parameters to the submit_condor_jobs.cmd script.

5. submit_condor_jobs.cmd: script that contains the CONDOR flags required for the bash jobs. The script also has an input the tntAnalyze.sh script which sets the enviroment and runs the code.

6. tntAnalyze.sh: besides setting the condor enviroment, the script copies the code <br>
(BSM3G_TNT_Analyzer) from a given area where the .cc, .h, Makefile, and PU files are <br>
located and run the code. The BSM3G_TNT_Analyzer is now been modified such that it <br>
takes the file it will run over and the name of the output file as input parameters. <br>
