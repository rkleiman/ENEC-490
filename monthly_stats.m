function [ m ] = monthly_stats ( data )
%Creates mean and STD from monthly stats
% copied from session_7.m

[rows,~]=size(data);
years = int8(rows/12);
monthly = zeros(12,years);
for i = 1:years
    monthly(:,i) = data(((1+(i-1)*12):(12+(i-1)*12)));
end

months=12; 
dataMeans = zeros(12,1);
dataSTD = zeros(12,1);
for y = 1:months
    dataMeans(y) = mean(monthly(y,:));
    dataSTD(y) = std(monthly(y,:));
end

meanSTD=zeros(12,2); 
meanSTD(:,1)=dataMeans;
meanSTD(:,2)=dataSTD;

% newDataset = zeros(years*months,1);
% for x = 1:years
%     for y = 1:months
%         newDataset(y + (x-1)*months) = newDataset(y + (x-1)*months)*dataSTD(y) + dataMeans(y);
%     end
% end

m=meanSTD


