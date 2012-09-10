
pos = shift_origin(pos);   % Shift origin
params = training (pos, hpc, 32);  % Train the entire set on a 32x32 bin resolution

[traj,prob]= reconstruction(hpc, params, [7.2e9, 7.3e9], 1, 2, 1000000, 2400);  %interval [3.53 e7 to 3.63 e7], time_window=1, compression_factor=2, 100000 units/second, K=2400;

reconstruction_error = recon_error( pos, traj, params);  % calculate the reconstruction error
r2 = model_R2( params, reconstruction_error)  % calculate the R2 value for the model

display_plots(reconstruction_error);  % display plot for X-coordinate


