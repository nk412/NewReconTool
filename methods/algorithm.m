function [ prob_dist, first_spike, last_spike ] = algorithm( time, gridmax_x,gridmax_y,neurons,spikes,firingrates, vel1, spatial_occ, timestep, time_window, compression_factor, count, per_out, first_spike, last_spike)
%function algorithm(time,gridmax_x, gridmax_y, neurons, spikes, firingrates, spatial_occ, window)
% Function not meant to be called independently. Contains the core
% reconstruction alogrithm. Takes all required data such as firing
% rates and spiking data, along with other algorithm specific
% information such as time window and grid size, and uses them to
% calculate a probability distribution of position.
%
% Output - prob_dist
%
% A matrix of size MxN, containing the probability distribution of expected position.
% MxN is the grid size as specified during training.



%------------------------------2 step Bayesian Reconstruction implementation----------------------------%

%End points of specified time window
p1=round(time- time_window/2);
p2=round(time+ time_window/2);

%Preallocate memory  for probability distribution            
prob_dist=zeros(gridmax_x,gridmax_y);


prob_dist=spatial_occ;

for y=1:gridmax_y
    for x=1:gridmax_x

        %CONTINUE if animal never visits this grid box; improves execution time 4X.
        if(spatial_occ(x,y)==0)
            continue;
        end
        % else
        %     prob_dist(x,y)=spatial_occ(x,y);
        % end


        %-----Bayes' Theorem implementation (PREDICTION STEP)-----%
        temp=1;    
        temp2=0;
        for tt=1:neurons
            number_of_spikes=0;


            while(spikes{tt}(first_spike(tt)+1)<p1)
                first_spike(tt)=first_spike(tt)+1;
            end

            while(spikes{tt}(last_spike(tt))<p2)
                last_spike(tt)=last_spike(tt)+1;
            end



            number_of_spikes=last_spike(tt)-first_spike(tt)-1;

            fr=firingrates{tt}(x,y);
            temp=temp*power(fr,number_of_spikes);
            % temp=temp*power(firingrates{tt}(x,y),number_of_spikes);

            % xp=ones(number_of_spikes,1);
            % fr=firingrates{tt}(x,y);
            % xp=xp.*fr;
            % temp=prod(xp);


            % for yp=1:number_of_spikes
            %     xp=xp*firingrates{tt}(x,y);
            % end
            % temp=temp*xp;

            %temp=temp*timestep*power(firingrates{tt}(x,y),number_of_spikes);
            %temp=temp/factorial(number_of_spikes);
            temp2=temp2+fr;

        end

        temp2=temp2*-time_window;
        temp2=exp(temp2);
        prob_dist(x,y)=spatial_occ(x,y)*temp*temp2;
        %---------------------------------------------------------%




    %----------CORRECTION STEP---------%
        %velocity_constant=50+(    (900/vel1(x,y)) /10);%/50;  % resolve this.
        velocity_constant=300/vel1(x,y);        
        if(count~=1)
            estx_prev=per_out(count-1,2);
            esty_prev=per_out(count-1,3);
            correction_prob=sqrt(power(estx_prev-x,2)+power(esty_prev-y,2));
            correction_prob=-power(correction_prob,2);
            correction_prob=correction_prob/velocity_constant;
            correction_prob=exp(correction_prob);
            prob_dist(x,y)=prob_dist(x,y)*correction_prob;
        end
    %----------------------------------%

    end 
end

%---Normalize distribution to sum up to 1
total_sum=sum(sum(prob_dist));
if(total_sum~=0)
    normalization_constant=1/total_sum;
    if(normalization_constant==Inf)
        normalization_constant=1;
    end
    prob_dist=prob_dist.*normalization_constant;
end

end

