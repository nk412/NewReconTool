int1=prob{1};
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

	map(interval_one(x,4),interval_one(x,5))=2;
	map=rot90(map);
	pcolor(map);
	pause(.01);
end


clear map;
clear spatial_occ;
clear gridmax_y;
clear gridmax_x;
clear xx;
clear yy;


	