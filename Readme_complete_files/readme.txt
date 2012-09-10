Using the RECONstruction TOOLbox

There are two main methods, the training method and the reconstruction method.

 

1 Data formats

Trajectory-
The trajectory data is given in the form of a matrix of size Tx3, where T is the number of sampled timestamps. The first column gives the timestamp, and the second and third columns denote the X and Y co-ordinate of the animal at that timestamp respectively. The units for the timestamp is by default taken as 1/10000th of a second, but can be set to any other value in the parameters while calling the training method.



Spike train
Spiking data is provided in the form of a cell array, with N vectors, where N is the number of neurons. Each vector contains ‘n’ spikes, where each spike is denoted by the time at which it occurs.

 

2 Function Descriptions

TRAINING

function [ parameter_model ] = training( trajectory, spikes, grid_size, intervals )

This function takes the trajectory and spikes as inputs, and grid size and training intervals can be optionally specified. By default, the grid size is 32x32, and the training is carried out over the entire given trajectory, if no specific interval is specified. The parameter model is returned, which contains firing rates, velocities, and other information calculated from the training data.

RECONSTRUCTION

function [ trajectory, probability ] = reconstruction( spikes, parameter_model, intervals, time_window, compression_factor, timeunits, velocity_K)

The reconstruction method requires the new spike train to be reconstructed, and the parameter model that was generated as a result of the training phase. Optional parameters are explained below:

·         intervals – Reconstruction is only carried out within these intervals, if specified. It is a matrix of size Ix2, where I is the number of intervals. The first column and the second column indicate the start and the end timestamps for the reconstruction. By default, the reconstruction is carried out on one single interval spanning the whole training set.
·         time_window ­– Specifies the size of the time window, within which the spikes are counted during reconstruction. This parameter is algorithm dependant. By default, it is set to 1 second.
·         compression_factor – This parameter allows for reconstruction of sequences occurring at faster timescales than the behaviour of the animal. By default, it is set to 1X.
·         timeunits – Here the unit of time used is specified. The number of units in one second is specified. By default, the data is assumed to have been sampled at 100 microseconds, and hence set at 10000. (1/10000th of a second).
·         velocity_K – This constant denotes how much of the velocity information of the animal is used to correct the Bayesian reconstruction. Adjusting this value affects the accuracy of the reconstruction by significant amounts. This value varies among animals, and lies anywhere from 50 to 5000. By default, it is set at 400.

The reconstructed output ‘trajectory’ is in the form of a cell array, containing I matrices, depending on the number of reconstruction intervals specified. Each matrix consists of Tx3 entries, where T is the number of timestamps within that interval. The second and third column corresponds to the reconstructed grid X and Y co-ordinate at that timestamp.

The second output ‘probability’ is also a cell array containing I cells, where I is the number of reconstruction intervals specified. Each cell array here contains T matrices of the training grid size (default 32x32), representing the probability distribution of the expected location of the animal at each time step.

 

3 Post-Reconstruction Analysis functions

RECONSTRUCTION ERROR

function [ rec_err ] = recon_error( position_data, reconstructed_trajectory, model_params )

Given the initial trajectory, reconstructed trajectory and the parameter model, the function outputs a cell array, containing I matrices, where I is the number of reconstruction intervals. Each matrix is of size Tx11, where T is the number of time steps within that interval. The eleven columns denote:

1.       Time stamp
2.       Actual grid cell X-coordinate
3.       Actual grid cell Y-coordinate
4.       Reconstructed grid cell X-Coordinate
5.       Reconstructed grid cell Y-Coordinate
6.       Euclidian distance/error between real and estimated location (grid cell units)
7.       Actual X-coordinate (in default units)
8.       Actual Y-coordinate (in default units)
9.       Reconstructed X-Coordinate (in estimated default units)
10.   Reconstructed Y-coordinate (in estimated default units)
11.   Euclidian distance/error between real and estimated location (true units)



 

GOODNESS OF FIT, R2

function [ r2 ] = model_R2( params, rec_err )

This function returns a single value, which denotes the goodness of fit for that specific model, given the parameter model and the reconstruction error data. To calculate the fitness of a model, a base null model is used to compare the actual model with. The null model is a lazy model that simply reconstructs a single constant location for any reconstruction interval, corresponding to the grid cell that the animal is most likely to visit. The sum of square of the Euclidian distance error is calculated and compared for both models using the following formula.



The resulting R2 value gives the goodness of fit of the model for that data, by comparison with the null model. A value of 1 is ideal, and indicates that the model has zero-error and is perfect. A value of zero means that the model performs just as good/bad as the null model. A negative value indicates that the model performs worse than the null model on the given data. This measure of evaluating model quality is superior as it is independent of parameters such as grid size, since it compares with a base model.

 

CROSS VALIDATION

function [ results ] = crossvalidation( hpc, pos, interval,folds,compression_factor,time_window, unitspersecond )

This function automatically performs cross validation tests on the given spiking train and positional data, and returns the results for every fold. The performance of the model on a fold is determined by the model’s goodness of fit R2 value, which is calculated by the model_R2 function. The output results object is a matrix of size Fx3, where F is the number of folds, and the first and second column correspond to the start and the end of the fold. The third column gives the R2 value of the model on that fold. The number of folds can be specified as an optional parameter, but by default a 10 fold CV is used. All the other parameters behave the same way as in the reconstruction method, and have the same defaults. A sample output of a 10-fold cross validation is shown below.



 

4 Visualization Functions

FIRING RATES

function [ ] = display_firingrate( model_params,neuron,checker )

This function gives a graphical display of the firing rates of a neuron, given the model after training.  Optionally, it can be specified if a checkered grid output is preferred.



 

OCCUPANCY

function [ ] = display_occupancy( model_params, checker )

This function provides a graphical display of the probabilistic distribution of where the animal is more likely to be in. This data is generated from the input data, and may be used by the reconstruction algorithm.  The second optional parameter specifies if the output should be in a checkered grid format.



 

NEURON SELECTIVITY

function [ ] = display_neuronselectivity( params, checker)

This function provides a visualization of the map, where every grid cell is given a color depending on which neuron it is most selective to. This is calculated by finding the neuron with the smallest firing rate to total firing rate ratio, for ever grid cell, and denoting every neuron by a color. The resulting map gives a picture of the place fields across the maze.



 

Display_plots

Display_trajectory

Shift-origin

 