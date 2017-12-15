This is the folder for all the code that we have for this project.

Part 1:

Part 2:

clear all
load('../data/cells.mat')
z = zeros(8, 1);
tumorArr = z;
errorArr = z;
time=[0,10,12,14,16,18,20,22];
for a = 1:length(time)-1 
    tumorArr(a+1) = sum(sum(sum(cells(:,:,:,a)))).*10.^(-7); 
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
    errorArr(a+1) = ((numErrors*10.^(-7))./(2));
end
xy = axes(); 
lineProp = plot(time, tumorArr);
lineProp.Color = [0 0 1];
lineProp.LineWidth = 4;
lineProp.Marker = ('o');
lineProp.MarkerFaceColor = [0 0 1];
lineProp.MarkerSize = 5;
hold on;
errProp = errorbar(time, tumorArr, errorArr);
errProp.Color = [0 0 1];
errProp.LineWidth = 4;
errProp.Marker = ('o');
errProp.MarkerFaceColor = [0 0 1];
errProp.MarkerSize = 8;
xy.XLabel.String = 'Time [days]';
xy.XLabel.FontSize = 13;
xy.YLabel.String = 'Tumor Cell Count';
xy.YLabel.FontSize = 13;
xy.Title.String = "Gompertzian Fit to Rat's Brain Tumor Growth";
xy.Title.FontSize = 12.5;
lgd = legend(lineProp,{'Experimental Data'});
lgd.Location = 'northwest';
y = annotation('textbox', [.12 .88, .50, .10]);
y.String = '×10^{7}';
y.LineStyle = 'none';
y.FontSize = 10;
saveas(gcf, '../results/ErrorBarGraph.png');

Part 3:
