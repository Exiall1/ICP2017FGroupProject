load('..\..\data\cells.mat')
tdata = [0 10 12 14 16 18 20 22];
%cellsdata is the experimental data
cellsdata = [100000 sum(sum(sum(cells(:,:,:,1)))), sum(sum(sum(cells(:,:,:,2)))), sum(sum(sum(cells(:,:,:,3)))), sum(sum(sum(cells(:,:,:,4)))), sum(sum(sum(cells(:,:,:,5)))), sum(sum(sum(cells(:,:,:,6)))), sum(sum(sum(cells(:,:,:,7))))];
%find best parameters
bestv = fminsearch(@(v)objfun(v,tdata,cellsdata),[10 0.1 1]);
plot(tdata,cellsdata,'-o','linewidth',4,'markersize',7)
hold on
%plot the physModel using the best parameters for times 0 to 24
plot(0:24,arrayfun(@(x)physModel(x,100000,bestv(1),bestv(2)),0:24),'linewidth',3,'color','red');
legend('Experimental Data','Gompertzian Fit','Location','northwest')
title("Gompertzian Fit to Rat's Brain Tumor Growth")
xlabel('Time [days]') % x-axis label
ylabel('Tumor Cell Count') % y-axis label
saveas(gcf,'..\..\results\GompFit.png');
%print the best fit parameters to a file called bestfitparams.txt
fprintf(fopen('..\..\results\bestparams.txt','w'),'lambda: %f \nc: %f \nsigma: %f \n',bestv);
fclose('all');