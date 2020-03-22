clc;
clear;
data = [-2 1 -3 5 -1 3 -4 4 -2 -2 1 -3 5 -1 3 -4 4 -2 6 -2 1 -3 5 -1 3 -4 4 -2 -2 1 -3 5 -1 3 -4 4 -3 1 -2 3 2 6];
numdata = length(data);
deData = zeros(1, numdata);
deData(1) = data(1);
numde = 1;
%data compression

%delete the nearby data which are equal
for i = 2 : numdata
    if(data(i) == data(i - 1))
        continue;
    else
        numde = numde + 1;
        deData(numde) = data(i);
    end
end

%detect peak&valley in compressed data
pvData = zeros(1, numde);
pvData(1) = deData(1);
numpv = 1;
for i = 2 : numde - 1
    if((deData(i) - deData(i - 1)) * (deData(i) - deData(i + 1)) > 0)
        numpv = numpv + 1;
        pvData(numpv) = deData(i);
        
    else
        continue;
    end
end
numpv = numpv + 1;
pvData(numpv) = deData(numde);
%data compression end

%extract cycle number
loopResult = zeros(5, numpv);
totaLoop = 0;
z = pvData(1);
dataSet = [];
dataSet = [dataSet, z];
index = 2;
now = pvData(index);
dataSet = [dataSet, now];
while(index <= numpv)
    len = length(dataSet);
    if(len < 3)
        index = index + 1;
        if(index <= numpv)
            now = pvData(index);
            dataSet = [dataSet, now];
        else
            break;
        end
    else
        point1 = dataSet(len - 2);
        point2 = dataSet(len - 1);
        point3 = dataSet(len);
        y = abs(point1 - point2);
        x = abs(point2 - point3);
        if(x < y)
            index = index + 1;
            if(index <= numpv)
                now = pvData(index);
                dataSet = [dataSet, now];
            else
                break;
            end
        else
            tempSet = [point1, point2];
            if(ismember(z, tempSet))
                totaLoop = totaLoop + 1;
                loopResult(1, totaLoop) = point1;                       %strat-point of the loop
                loopResult(2, totaLoop) = point2;                       %end-point of the loop
                loopResult(3, totaLoop) = abs(point1 - point2);         %amplitude of the loop
                loopResult(4, totaLoop) = (point1 + point2) / 2;        %mean-value of the loop
                loopResult(5, totaLoop) = 0.5;                          %loop number
                dataSet(len - 2) = [];                                  %delete first data of y
                z = point2;                                             %reset first point in dataSet
            else
                totaLoop = totaLoop + 1;
                loopResult(1, totaLoop) = point1;                       %strat-point of the loop
                loopResult(2, totaLoop) = point2;                       %end-point of the loop
                loopResult(3, totaLoop) = abs(point1 - point2);         %amplitude of the loop
                loopResult(4, totaLoop) = (point1 + point2) / 2;        %mean-value of the loop
                loopResult(5, totaLoop) = 1;                            %loop number
                dataSet(len - 2) = [];                                  %delete first&second data of y
                len = len - 1;
                dataSet(len - 1) = [];
            end
        end
    end
end
while(~isempty(dataSet))
    totaLoop = totaLoop + 1;
    loopResult(1, totaLoop) = dataSet(1);
    loopResult(2, totaLoop) = dataSet(2);
    loopResult(3, totaLoop) = abs(dataSet(1) - dataSet(2));
    loopResult(4, totaLoop) = (dataSet(1) + dataSet(2)) / 2;
    loopResult(5, totaLoop) = 0.5;
    dataSet(1) = [];                                                        %delete used peak&valley
    dataSet(1) = [];
end