%% Class notes

readData='HenryHubPrice.xls';
sheetName= 'Data 1';
[NUM WORD COMBINED] = xlsread(readData, sheetName);

%d=annual_profile(NUM);
[rows, columns]=size(NUM); 

ExDates=NUM(:,1); 
MATLABDate=x2mdate(ExDates,1)

%trying to figure out how to find the index of the starting date??
%STRDate=x2mdate(ExDates,1,'datetime')
%first=datefind(STRDate,'16-Jan-2008')

prices=NUM(:,2);
datePrices=zeros(rows,columns);
datePrices(:,2)=MATLABDate;
datePrices(:,1)=prices; 

%starting at 2008
datePrices08=datePrices(133:rows,:)

%Statistics

monthly_stats(datePrices08)




