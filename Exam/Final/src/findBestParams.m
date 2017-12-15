load('..\data\cells.mat')
tdata = [0 10 12 14 16 18 20 22];
%cellsdata is the experimental data
cellsdata = [100000 sum(sum(sum(cells(:,:,:,1)))), sum(sum(sum(cells(:,:,:,2)))), sum(sum(sum(cells(:,:,:,3)))), sum(sum(sum(cells(:,:,:,4)))), sum(sum(sum(cells(:,:,:,5)))), sum(sum(sum(cells(:,:,:,6)))), sum(sum(sum(cells(:,:,:,7))))];
%my partner did not want me to change their code so I am editing their code
%here instead of directly on their script
errorArr = zeros(8, 1);
for a = 1:length(tdata)-1 
    numErrors = 0;
    for b = 1:size(cells, 3)
        zSlice = cells(:, :, b, a);
        BW = imbinarize(zSlice);
        bound = bwboundaries(BW);
        for c = 1:length(bound)
            boundary = bound{c};
            for d = 1:size(boundary, 1)
                numErrors = numErrors + zSlice(boundary(d,1), boundary(d,2));
            end                
        end
    end
    errorArr(a+1) = (numErrors);
end
%find best parameters
bestv = fminsearch(@(v)objfun(v,tdata,cellsdata),[10 0.1 1]);
%plot errorbar plot
errorbar(tdata, cellsdata, errorArr,'linewidth',4,'marker','o','markersize',8,'color',[0 0 1],'markerfacecolor',[0 0 1])
hold on
%plot the physModel using the best parameters for times 0 to 24
plot(0:24,arrayfun(@(x)physModel(x,100000,bestv(1),bestv(2)),0:24),'linewidth',3,'color','red');
legend('Experimental Data','Gompertzian Fit','Location','northwest')
title("Gompertzian Fit to Rat's Brain Tumor Growth")
xlabel('Time [days]') % x-axis label
ylabel('Tumor Cell Count') % y-axis label
saveas(gcf,'..\results\GompFit.png');
%print the best fit parameters to a file called bestfitparams.txt
fprintf(fopen('..\results\bestparams.txt','w'),'lambda: %f \nc: %f \nsigma: %f \n',bestv);
fclose('all');