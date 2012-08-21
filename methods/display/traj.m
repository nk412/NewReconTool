delayval=.05;

int1=prob{1};
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
				map(xx,yy)=-.3;
			end
		end
	end

	map(interval_one(x,4),interval_one(x,5))=2;
	map=rot90(map);
	map=flipud(map);
	waitbar(x/numel(int1),w,sprintf('%d/%d',x,numel(int1)));
	pcolor(map);
	if(x==1)
		waitforbuttonpress;
	end
	pause(delayval);
end

close(w);
clear map;
clear spatial_occ;
clear gridmax_y;
clear gridmax_x;
clear xx;
clear yy;
clear x;
clear w;
clear int1;
clear delayval



	