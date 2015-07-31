function [binX,binY] = binningPP( j,tspan,run )
%Binning function for the Predator-Prey scripts.
%Used for guaranteeing all data sets are same size for estimation.
%tspan = ceil(max(run(j).storet));
meanY=zeros(1,tspan);
meanX = zeros(1,tspan);
for day=1:tspan
    clear Yvect Xvect;
    Yvect=[];
    Xvect = [];
    %This indexes the time values between day-1 and day
    %(could refine to less than a day for small time steps).
    index_j = find(day-1 <= run(j).storet & run(j).storet < day);
    if ~isempty(index_j)
        %This concatenates the data values into one vector
        Yvect = [Yvect run(j).storeY(index_j)];
        Xvect = [Xvect run(j).storeX(index_j)];
    end
    if ~isempty(Yvect)
        %If bin is not empty, then make the value for that day the
        %mean of all values in bin day-1 and day.
        meanY(day)=mean(Yvect);
    else
        if day~=1
            %If there are no data values in the time step, make it the value
            %of the last bin (no change in population).
            meanY(day) = meanY(day-1);
        else
            %Sets initial condition if no data values in first bin empty.
            meanY(day) = 0.25*pop;
        end
    end
    if isempty(Yvect)
        %This makes sure that even if the 'data' stops before tspan
        %that it will fill the rest in with zeros to guarantee that
        %the data sets are all size tspan. The additional zeros will
        %not affect the estimation.
        meanY(day)=0;
    end
    if ~isempty(Xvect)
        %If bin is not empty, then make the value for that day the
        %mean of all values in bin day-1 and day.
        meanX(day)=mean(Xvect);
    else
        if day~=1
            %If there are no data values in the time step, make it the value
            %of the last bin (no change in population).
            meanX(day) = meanX(day-1);
        else
            %Sets initial condition if no data values in first bin empty.
            meanX(day) = 0.75*pop;
        end
    end
    if isempty(Xvect)
        %This makes sure that even if the 'data' stops before tspan
        %that it will fill the rest in with zeros to guarantee that
        %the data sets are all size tspan. The additional zeros will
        %not affect the estimation.
        meanX(day)=0;
    end
    
end
%Output data values as a tspan x 2 matrix. [ timevalues binneddata ]
binY = [meanY'];
binX = [meanX'];
end

