function [ ] = display_deviations( params, reconstruction_error, minimum_distance )
%DISPLAY_DEVIATIONS Summary of this function goes here
%   Detailed explanation goes here
if(nargin<2)
	error('Please provide parameter model & reconstruction error');
elseif(nargin<3)
	minimum_distance=250;
end

if(iscell(reconstruction_error))
	reconstruction_error=reconstruction_error{1};
end

binsize=params{2};
spatial_occ=params{6};


deviationmap=zeros(binsize(1),binsize(2));
for x=1:binsize(1)
	for y=1:binsize(2)
		if(spatial_occ(x,y)==0)
			deviationmap(x,y)=-.1;
		end
	end
end


for x=1:numel(reconstruction_error(:,1))
	if(reconstruction_error(x,11)>minimum_distance)
		gridx=reconstruction_error(x,2);
		gridy=reconstruction_error(x,3);
		if(gridx==0)
			gridx=1;
		end
		if(gridy==0)
			gridy=1;
		end

		deviationmap(gridx,gridy)=deviationmap(gridx,gridy)+1;
	end
end

deviationmap=deviationmap./params{6};
map=rot90(deviationmap);
pcolor(map);
% waitforbuttonpress;
pause(1);
minimum_distance=minimum_distance+1000;


end

