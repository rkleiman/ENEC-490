%% Class notes

readData='HenryHubPrice.xls';
sheetName= 'Data 1';
[NUM WORD COMBINED] = xlsread(readData, sheetName);

%d=annual_profile(NUM);
[rows, columns]=size(NUM); 

ExDates=NUM(:,1); 
MATLABDate=x2mdate(ExDates,1);

%trying to figure out how to find the index of the starting date??
%STRDate=x2mdate(ExDates,1,'datetime')
%first=datefind(STRDate,'16-Jan-2008')

prices=NUM(:,2);
datePrices=zeros(rows,columns);
datePrices(:,2)=MATLABDate;
datePrices(:,1)=prices; 
%starting at 2008
datePrices08=datePrices(133:rows,:);

%Statistics
m= monthly_stats(datePrices08);

%synthetic random sample

%figure out how to get the STD and means from the function file

months=12;
years=8; 

StdApril=m(4,2);
meanApril=m(4,1);

StdJune=m(6,2);
meanJune=m(6,1);

StdJanuary=m(1,2);
meanJanuary=m(1,1);

%April 
newDataset = randn(years*months,1);
for x = 1:years
    for y = 1:months
        newDataset(y + (x-1)*months) = newDataset(y + (x-1)*months)*StdApril + meanApril;
    end
end

%January
newDataset2 = randn(years*months,1);
for x = 1:years
    for y = 1:months
        newDataset(y + (x-1)*months) = newDataset(y + (x-1)*months)*StdJanuary + meanJanuary;
    end
end

%June
newDataset3 = randn(years*months,1);
for x = 1:years
    for y = 1:months
        newDataset(y + (x-1)*months) = newDataset(y + (x-1)*months)*StdJune + meanJune;
    end
end
figure; 
subplot (1,2,1);
histogram(newDataset)
title('April')
subplot (1,2,2);
histogram(newDataset2)
title('January');








