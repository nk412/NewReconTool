function [ trajectory, probability ] = reconstruction( spikes, model_params, intervals, initial_positions, time_window, compression_factor, velocity_K )
%
% [trajectory, probability] = reconstruction(spikes, model_params, intervals, initial_positions, time_window, compression_factor)
%
% Uses the animal's positional data, spiking activity of the neurons, model
% parameters (firing rates, occupancy matrices...) generated during from
% the training method, to reconstruct the location of the animal.
%
% Inputs -
% spikes        - A cell array containing N vectors, where N is the number of
%                 neurons. Each vector contains timestamps at which the neuron
%                 fired.
% model_params  - Cell array containing parameters such as firing rates and
%                 occupancy matrices. This object is generated by the training
%                 method, given the spiking and positional data.
%
% Optional Inputs-
% intervals     -     A matrix of size Ix2, where I is the number of intervals for
%                     reconstruction. For every interval specified, the first column
%                     indicates the start timestamp of the interval and the second
%                     column represents the end timestamp of the interval. By default,
%                     it takes the entire interval(s) on which the model was trained.
% initial_positions - A matrix of size Ix2, where I is the number of intervals for
%                     reconstruction. The first column and second column denote the
%                     X and Y co-ordinate of the animal at the beginnning of the 
%                     interval respectively. By default, this is an empty matrix, 
%                     indicating equal likelihood for all locations for the animal to 
%                     be present. (Algorithm Dependent)
% time_window       - This is the time window specified in seconds, the window within
%                     which the spiking activity of the neurons will be used for
%                     reconstruction. This parameter is algorithm specific, and may
%                     not be used by all methods. By default, time_window is set to 1 sec.
%                     (Algorithm Dependent)
% compression_factor- The compression_factor allows representations of neural sequences
%                     occurring faster than animal behaviour. By default, this is set
%                     at 1X. (Algorithm Dependent) 
%
%
% Output -
% trajectory    -   This is a cell array containing I matrices, where I is the number
%                   of reconstruction intervals specified. Each matrix is a Tx3 matrix
%                   which contains T timesteps lying between the interval specified.
%                   The first column denotes the timestamp, the second column corresponds
%                   to the estimated X co-ordinate at the timestep, and the third column
%                   consists of the estimated Y co-ordinate at the same timestep.
% probability   -   This is a cell array containing T matrices, where T is the number
%                   of timesteps in the interval specified. Each matrix is of size MxN, 
%                   the grid size, that gives the probability distribution of finding 
%                   the animal on the grid. ( The estimated position is calcualted by 
%                   finding the location with the maximum probability. )




if(nargin<2)
    error('Argumements : Position data, spikes, model parameters, start point in time, end point, (time time_window)');
elseif(nargin<3)
    intervals=model_params{5};
    initial_positions=[];
    time_window=1;
    compression_factor=1;
elseif(nargin<4)
    initial_positions=[];
    time_window=1;
    compression_factor=1;
elseif(nargin<5)
    time_window=1;
    compression_factor=1;
elseif(nargin<6)
    compression_factor=1;    
end


fprintf('Reconstructing between:');
intervals

%------------Discretizing Position_data into bins------------%
% binsize_grid=model_params{2};
% max_x=max(position_data(:,2));  % get max X value
% max_y=max(position_data(:,3));  % get max Y value
% n_grid=binsize_grid(1);       % horizontal divisions, n
% m_grid=binsize_grid(2);       % vertical divisions, m
% m_grid=max_x/m_grid;            % bin width
% n_grid=max_y/n_grid;            % bin height
% for x=1:numel(position_data(:,1))
%     position_data(x,2)=round(position_data(x,2)/m_grid);
%     position_data(x,3)=round(position_data(x,3)/n_grid);
% end
% max_x=max(position_data(:,2));
% max_y=max(position_data(:,3));
%------------------------------------------------------------%


% velocity_K=100;
timefactor=10000;

%----------------variable initialization---------------------%
estpos=[];
time_window=time_window*timefactor; %unit conversion from seconds to 1/10000th of a second
neurons=model_params{1}(1);
gridmax_x=model_params{1}(2);
gridmax_y=model_params{1}(3);
timestep=model_params{1}(4); % Timestep, algorithm specific. will resolve this.
spatial_occ=model_params{3};
firingrates=model_params{4};
no_of_intervals=numel(intervals(:,1));
vel1=model_params{7};

%post_recon={};
per_out=cell(1,no_of_intervals);
prob_out=cell(1,no_of_intervals);
%------------------------------------------------------------%










wbar=waitbar(0,'Initializing...');



for intr=1:no_of_intervals
    startpoint=intervals(intr,1);
    endpoint=intervals(intr,2);
    time=startpoint;
    per_out=[];
    prob_out={};
    count=1;
    estimated=0;
    interval_out={};
    first_spike=zeros(neurons,1);
    last_spike=zeros(neurons,1);
    while(time <= endpoint)  


        if(count==1)
            p1=round(time- time_window/2);
            p2=round(time+ time_window/2);
            for(tt=1:neurons)
                spike1=findnearest(p1,spikes{tt},-1);
                if(spike1==numel(spikes{tt}))
                    spike1=spike1-1;
                end
                spike2=findnearest(p2,spikes{tt},1);
                if(spike2==numel(spikes{tt}))
                    spike2=spike2-1;
                end
                if(numel(spike1)==0)
                    spike1=0;
                end
                if(numel(spike2)==0)
                    spike2=1;
                end
                first_spike(tt)=spike1;
                last_spike(tt)=spike2;
            end
        end






        % ---------------- Algorithm implementation---------------%
        iter_vars={count,per_out,first_spike,last_spike,prob_out};
        [prob_dist, first_spike, last_spike]= algorithm( time, spikes, model_params, time_window, compression_factor,iter_vars,velocity_K);
        %=----------------Algorithm Implementation ends--------------%
        
%------------------------------------------------------------------------------------------------%





        %-----------------------Calculate Estimated X and Y -----------------%
        tempx=findnearest(max(max(prob_dist)),prob_dist);


%--------buggy------------%
        % if(numel(tempx)==0)
        %     tempx=1;
        % end


        [estx,esty]=ind2sub(size(prob_dist),tempx(1));
        %fprintf('Completed: %f %%\n',((time-startpoint)/(endpoint-startpoint))*100);
        
        
        %-----If no prob, take previous position-----%
        if(estx==1 && esty==1 && count~=1)
            estx=per_out(count-1,2);
            esty=per_out(count-1,3);
        end


        waitbar((time-startpoint)/(endpoint-startpoint),wbar,sprintf('Reconstructing....Interval %d, point %d',intr,count));
        per_out=[per_out; time,estx,esty];
        prob_out{count}=prob_dist;
        %-----------------------Calculate Estimated X and Y -----------------%





        time=time+timestep*compression_factor;
        count=count+1;
    end
    %interval_out={per_out prob_out};
    trajectory{intr}=per_out;
    probability{intr}=prob_out;
    %post_recon{intr}=interval_out;
end

close(wbar);
end
            
        
