Matlab Toolkit for reconstruction
Readme.txt last updated: 10 Aug, 2012
Work in progress: Not all functions may work correctly.

Summary:
A parametric model is built given i. Neural spiking activity & ii. Location(x,y) at different times of an animal. Given a new set of spiking activity, the algorithm trains on the model and reconstructs the estimated trajectory of the animal, thus reconstructing the location of the animal given just neural activity.
The algorithm is based on the methods used in Zhang et al., 1998 (http://www.ncbi.nlm.nih.gov/pubmed/9463459), but is heavily modified. 


1. training() - train model on spiking data and position data
2. reconstruction() - reconstruct trajectory based on spiking activity
3. algorithm.m - Core reconstruction aglorithm.
4. display_* - Data visualizations (trajectory, neuron selectivity, firing rates etc.)
