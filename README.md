# SimMatrix-Analysis
This repository hold scripts to analyze a similarity matirx. 

extractTop-Match.pl: 
#Given a sample in a Similarity matrix, this script will extract the top "n" matches (Highest similarity scores) to that particular sample. 
extractTop-Match.pl [ -hits <Number_of_hits> -verbose -self -help] -in <infile> -id <sample_name>

sim_matrix_to_pairs.pl: 
#Given a similarity score, this script will extract every pair of samples that have a "given similarity score or higher" in a similarity matrix. 
sim_matrix_to_pairs.pl [ -identity <identity_score> -verbose -help] -in <infile>

blinkPerl_v1.1.pl: 
#This script goes along with sim_matrix_to_pairs.pl. Given a set of samples with a certain similarity score, this script will cluster the samples into groups based on their similarity to one another. 
blinkPerl_v1.1.pl -in <infile> [ -o <output file> -log <logFile> -s <summaryFile> ]

mean_simMatrix.pl: 
#Find the average and minimun score of similarity scores within a matrix. 
mean_simMatrix.pl <similarity_matrix.txt>
