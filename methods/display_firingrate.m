function [ ] = display_firingrate( model_params,neuron,checker )
%display_firingrate(model_params, neuron, checker)
%   Displays a graphical representation of the firing rate of a neuron.
%
% 	Input -
% model_params  - Cell array containing parameters such as firing rates and
%                 occupancy matrices. This object is generated by the training
%                 method, given the spiking and positinal data.
% neuron 		- Neuron number to be displayed.
%
% Optional inputs
%   checker		- If set to 1, will display the result in a checkered grid.
% 				  By defualt, it is set to 0.

if(nargin<2)
    error('Call function with parameter model and neuron number.');
end

if(nargin==2)
    checker=1;
end

maxneurons=model_params{1}(1);
if(neuron<1 || neuron>maxneurons)
    error('Neuron number exceeds that of model');
end
firing_rates=model_params{4};
map=rot90(firing_rates{neuron});
if(checker==1)
    pcolor(flipud(map));
else
    imagesc(map);
end
colorbar;

end

