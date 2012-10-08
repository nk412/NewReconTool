function [ pos, spikes ] = convert_to_seconds( pos, spikes, n )
% [position, spikes] = convert_to_seconds( position, spikes, units_in_a_second )
%   This function returns the provided position and spike trains in proper units of seconds.
%
%  n indicates that the units for the data provided are recorded in 1/n seconds.
%  Eg. To convert data recorded in miliseconds (1/1000th of a second), n=1000.
%  By default, n=1000.

if(nargin<2)
	error('Please provide position data and spike trains');
end
if(nargin<3)
	n=1000;
end


pos(:,1)=pos(:,1)/n;
for x=1:numel(spikes)
    spikes{x}(:)=spikes{x}(:)/n;
end


end

