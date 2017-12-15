This is the folder for all the code that we have for this project.

 # Part 1 (Cindy Y.):

x=[10,12,14,16,18,20,22]

clear all;
close all;
load('cells.mat'); 

for i = 1:7
    
main = 10+2*(i-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE SPECIFICATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrow = 4; % number of subplots to be created in the y direction
ncol = nrow;                             % number of subplots to be created in the x direction

% main plot specifications
mainPlotMarginTop = 0.06;       % top margin of the main axes in figure
mainPlotMarginBottom = 0.12;    % bottom margin of the main axes in figure
mainPlotMarginLeft = 0.08;      % bottom margin of the main axes in figure
mainPlotMarginRight = 0.1;      % right margin of the main axes in figure
mainPlotPositionX = 0.05;       % the x coordinate of the bottom left corner of the main axes in figure
mainPlotPositionY = 0.08;       % the y coordinate of the bottom left corner of the main axes in figure
mainPlotWidth = 1 - mainPlotMarginRight - mainPlotPositionX; % the width of the main axes in figure
mainPlotHeight = 1 - mainPlotMarginTop - mainPlotPositionY; % the height of the main axes in figure
mainPlotTitleFontSize = 12;     % The font size for the main plot labels and title
mainPlotAxisFontSize = 12;      % The font size for the main plot labels and title

% subplot properties
subPlotFontSize = 10;     % the font size for subplots
subplotInterspace = 0.03; % space between subplots
subplotWidth = (1-mainPlotMarginLeft-mainPlotMarginRight-nrow*subplotInterspace)/ncol;   % The width of subplots
subplotHeight = (1-mainPlotMarginTop-mainPlotMarginBottom-ncol*subplotInterspace)/nrow ; % The height of subplots

% specifications of the color bar to the figure
colorbarFontSize = 13;                                           % the font size of the color bar
colorbarWidth = 0.03;                                            % the width of the color bar
colorbarPositionY = mainPlotMarginBottom;                        % the y-position of the color bar
colorbarPositionX = 1 - mainPlotMarginRight;                     % the x-position of the color bar
colorbarHeight = nrow*subplotHeight+(nrow-1)*subplotInterspace;  % the height of the color bar
colorLimits = [0,max(max(max(cells(:,:,:))))];                    % the color bar limits, the dataset contains numbers between 0 and some large number.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIRST CREATE A FIGURE HANDLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figHandle = figure();                           % create a new figure
figHandle.Visible = 'on';                       % set the visibility of figure in MATLAB
figHandle.Position = [0, 0, 900, 1350];         % set the position and size of the figure
figHandle.Color = [0.9400 0.9400 0.9400];       % set the background color of the figure to MATLAB default. You could try other options, such as 'none' or color names 'red',...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD THE MAIN AXES TO THE FIGURE: 
% The main axes is needed in order to add
% the x and y labels and the color bar
% for the entire figure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mainPlot = axes();              % create a set of axes in this figure. This main axes is needed in order to add the x and y labels and the color bar for the entire figure.
mainPlot.Color = 'none';        % set color to none
mainPlot.FontSize = 11;         % set the main plot font size
mainPlot.Position = [ mainPlotPositionX mainPlotPositionY mainPlotWidth mainPlotHeight ]; % set position of the axes
mainPlot.XLim = [0 1];          % set X axis limits
mainPlot.YLim = [0 1];          % set Y axis limits
mainPlot.XLabel.String = 'Voxel Number in X Direction'; % set X axis label
mainPlot.YLabel.String = 'Voxel Number in Y Direction'; % set Y axis label
mainPlot.XTick = [];            % remove the x-axis tick marks
mainPlot.YTick = [];            % remove the y-axis tick marks
mainPlot.XAxis.Visible = 'off'; % hide the x-axis line, because we only want to keep the x-axis label
mainPlot.YAxis.Visible = 'off'; % hide the y-axis line, because we only want to keep the y-axis label
mainPlot.XLabel.Visible = 'on'; % make the x-axis label visible, while the x-axis line itself, has been turned off;
mainPlot.YLabel.Visible = 'on'; % make the y-axis label visible, while the y-axis line itself, has been turned off;
mainPlot.Title.String = ['Time = ',num2str(main),' days. Brain MRI slices along Z-direction, Rat W09. No Radiation Treatment.']; % set the title of the figure
mainPlot.XLabel.FontSize = mainPlotAxisFontSize; % set the font size for the x-axis in mainPlot
mainPlot.YLabel.FontSize = mainPlotAxisFontSize; % set the font size for the y-axis in mainPlot
mainPlot.Title.FontSize = mainPlotTitleFontSize; % set the font size for the title in mainPlot

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD COLORBAR TO THE FIGURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% now add the color bar to the figure
axes(mainPlot);                       % focus on the mainPlot axes, because this is where we want to add the colorbar
caxis(colorLimits);                   % set the colorbar limits
cbar = colorbar;                      % create the color bar!
ylabel(cbar,'Number of Tumor Cells'); % now add the color bar label to it
cbar.Position = [ colorbarPositionX ... Now reset the position for the colorbar, to bring it to the rightmost part of the plot
                  colorbarPositionY ...
                  colorbarWidth ...
                  colorbarHeight ...
                ];
cbar.FontSize = colorbarFontSize;     % set the fontsize of the colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD THE SUBPLOTS TO THE FIGURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sliceNumber = 0 ;
for irow = nrow:-1:1
    for icol = 1:ncol
        sliceNumber = sliceNumber + 1;
        subPlot = axes( 'position', [ ... set the position of the axes for each subplot
                                      (icol-1)*(subplotInterspace+subplotWidth) + mainPlotMarginLeft ...
                                      (irow-1)*(subplotInterspace+subplotHeight) + mainPlotMarginBottom ...
                                      subplotWidth ...
                                      subplotHeight ...
                                    ] ...
                      );
% % % % % % % % % % % % % ADD-ONS   
        imagesc(cells(:,:,sliceNumber,i))%,sliceNumber),colorLimits);
        caxis([0 3.5*10^4])
        hold on
        subPlot.FontSize = subPlotFontSize;
        if icol ~= 1
            subPlot.YTickLabels = [];
        end
        if irow ~= 1
            subPlot.XTickLabels = [];
        end
    
        subPlot.Title.String = ['z = ',num2str(sliceNumber)];
 
    end
    if sliceNumber == 16 
        sliceNumber = sliceNumber - 16
    end
end
saveas(gcf,['brainplot.png',num2str(i),'.png']);        % save the figure
end


# Part 2 (Dilip D.):

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

# Part 3 (Ethan M.):

```Matlab
load('..\data\cells.mat')
tdata = [0 10 12 14 16 18 20 22];
%cellsdata is the experimental data
cellsdata = [100000 sum(sum(sum(cells(:,:,:,1)))), sum(sum(sum(cells(:,:,:,2)))), sum(sum(sum(cells(:,:,:,3)))), sum(sum(sum(cells(:,:,:,4)))), sum(sum(sum(cells(:,:,:,5)))), sum(sum(sum(cells(:,:,:,6)))), sum(sum(sum(cells(:,:,:,7))))];
%my partner did not want me to change their code so I am editing their code
%here instead of directly on their script
tumorArr = zeros(8, 1);
errorArr = zeros(8, 1);
for a = 1:length(tdata)-1 
    tumorArr(a+1) = sum(sum(sum(cells(:,:,:,a)))); 
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
errorbar(tdata, tumorArr, errorArr,'linewidth',5,'marker','o','markersize',8,'color',[0 0 1],'markerfacecolor',[0 0 1])
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
```