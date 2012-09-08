function [ ] = display_plots( interval_one, trueplot, onlyx )
%DISPLAY_PLOTS Summary of this function goes here
%   Detailed explanation goes here

if(nargin<1)
    error('Please provide a reconstructed trajectory');
elseif(nargin<2)
    trueplot=0;
    onlyx=1;
elseif(nargin<3)
    onlyx=1;
end


if(iscell(interval_one))
    interval_one=interval_one{1};
end


if(trueplot==0)
    plot(interval_one(:,1),interval_one(:,2),'color','red','LineWidth',2);
    hold on;
    plot(interval_one(:,1),interval_one(:,4));
    hold off;
    if(onlyx==0)
        waitforbuttonpress;
        plot(interval_one(:,1),interval_one(:,3),'color','red','LineWidth',2);
        hold on;
        plot(interval_one(:,1),interval_one(:,5));
        hold off;
    end
    
else
    plot(interval_one(:,1),interval_one(:,7),'color','red','LineWidth',2);
    hold on;
    plot(interval_one(:,1),interval_one(:,9));
    hold off;
    if(onlyx==0)
        waitforbuttonpress
        plot(interval_one(:,1),interval_one(:,8),'color','red','LineWidth',2);
        hold on;
        plot(interval_one(:,1),interval_one(:,10));
        hold off;
    end
end


% waitforbuttonpress;
% plot(interval_one(:,1),interval_one(:,5),'color','red','LineWidth',2);
% hold on;
% plot(interval_one(:,1),interval_one(:,3));
% hold off;
% waitforbuttonpress;
% hist(interval_one(:,6));

end

