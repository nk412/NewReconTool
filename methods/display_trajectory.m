function [ ] = display_trajectory(params, prob_array, err, timeperframe )
%DISPLAY_TRAJECTORY Summary of this function goes here
%   Detailed explanation goes here

if(nargin<3)
    error('Please input parameter model, probability distribution per timestep, and reconstruction error.');
elseif(nargin<4)
    timeperframe=0.001;
end

int1=prob_array{1};
if(iscell(int1)==0)
    int1=prob_array;
end

if(iscell(err))
    interval_one=err{1};
else 
    interval_one=err;
end


figure;
w=waitbar(0,'Initializing');
spatial_occ=params{3};
gridmax_x=params{1}(2);
gridmax_y=params{1}(3);
for x=1:numel(int1)
	map=int1{x};
	for xx=1:gridmax_x
		for yy=1:gridmax_y
			if(spatial_occ(xx,yy)==0)
				map(xx,yy)=-.5;
			end
		end
	end

	truex=interval_one(x,2);
	truey=interval_one(x,3);
	if(truex==0) 
		truex=1;
	end
	if(truey==0)
		truey=1;
	end
	map(truex,truey)=2;
	map=rot90(map);
	map=flipud(map);
	waitbar(x/numel(int1),w,sprintf('%d/%d',x,numel(int1)));
	pcolor(map);
	if(x==1)
		waitforbuttonpress;
	end
	pause(timeperframe);
end


end

