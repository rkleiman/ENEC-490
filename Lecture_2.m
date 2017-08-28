%BASIC MATLAB OPERATIONS

%Q1
a=cos(0):0.02:log10(100);
[rows, columns] = size(a);
elementCount=rows*columns
element25=a(25)

%% %Q2
randArray=500*rand(50,50);
[rows, columns] = size (randArray);
randArrayLogical=randArray > 400;
count=0;
for i=1:rows
    for j=1:columns
        count=count+randArrayLogical(i,j);
    end
end
countOver400=count

% did it a second way to check my work
% count=0;
% for i=1:rows
%     for j=1:columns
%         if randArray(i,j)>400
%         count=count+1;
%         j=j+1;
%         end
%     end 
%     i=i+1;
%     end 
%  
% count
%% %Q3
m=zeros(100,2);
i=0;
for i=1:100
    x=1000*rand();
    m(i,1)=x;
    y=0.3*x^3-2*x^2+200*x;
    m(i,2)=y;
    i=i+1;
end 
plot(m(:,1),m(:,2))


%% %Q4
binaryMatrix=m>=350;
binaryVector=MatToVec(binaryMatrix);
plot(binaryVector);
% this plot is weird bc binary
%% IMPORTING/EXPORTING DATA

readData='ny_Harbor_ConvGas.xls';
[NUM WORD COMBINED]= xlsread(readData, 'Data 1');
matrix=NUM;
[rows, ~]=size(NUM);

%eliminating 1986 because only partial data
matrix= matrix(11:rows,:);
[rows, ~]=size(matrix);

%creating new array with enough rows for yearly average only
rows=int8(rows/12);
averageArray=zeros(rows,2);

%calculating mean and year and adding these values to new array
[rowsAv, columnsAv]=size(averageArray);
j=1;
for i=1:rowsAv-1
    averageArray(i,1)=1986+i;
    averageArray(i,2)=mean(matrix(j:j+11,2));
    j=j+12;
    i=i+1;
end 

%eliminating partial monthly data for 2017
[rows, columns] = size(averageArray);
rows=int8(rows-1);
averageArray=averageArray(1:rows,:);

%writing to new csv file
csvwrite('monthly_average_price.csv',averageArray);

%% PLOTTING

%Q1
t=0:0.01:5;
s=2*sin(3*t+2)+sqrt(5*t+1);
plot(t,s)
ylabel('Speed(ft/s)')
xlabel('Time(s)')
title('Relationship between Speed and Time')
%% Q2 Sub plot

x=0:0.1:1.5;
y=4*sqrt(6*x+1);
z=5*exp(0.3*x)-2*x;

subplot(1,2,1);
plot(x,y,'m');
xlabel('Distance(m)');
ylabel('Force(N)');
title('Distance vs. Force: Plot 1')
legend('4*sqrt(6x+1)')

subplot (1,2,2);
plot(x,z,'c');
xlabel('Distance(m)');
ylabel('Force(N)');
title('Distance vs. Force: Plot 2')
legend('5*exp(0.3x)-2x')
%% Q2 Same plot
x=0:0.1:1.5;
y=4*sqrt(6*x+1);
z=5*exp(0.3*x)-2*x;

plot(x,y,'m',x,z,'c');
xlabel('Distance(m)');
ylabel('Force(N)');
title('Relationship between Distance and Force')

legend('4*sqrt(6x+1)', '5*exp(0.3x)-2x')
%% Q3
x=1:50;
y=1:50;
[X,Y] = meshgrid(x,y);

%why does it have to be in a for loop?
%z=((-2.5+X)/10).^2+((-2.5+Y)/10).^2

for i=1:50
    for j=1:50
        z(i,j)=((-2.5+X(i,j))/10).^2+((-2.5+Y(i,j))/10).^2;
        j=j+1;
    end
    i=i+1;
end
z;
surf(X,Y,z)
title('Surf Function')
xlabel('X');
ylabel('Y');
zlabel('Z');
%% Q4

speedMax=25; %ft/s
packageWeight=20; %lb
packageWidth= 12; %in
packageHeight= 12; %in
packageLength = 8; %in

packageVolume=packageWidth*packageHeight*packageLength;


g=32.2; %ft/s^2

h=0.5*speedMax.^2/g; %ft

%tMax=speedMax/g %s
%h=0.5*g*tMax.^2 %ft
if h > 4
    disp ('The packaging can protect the package (so long as it is only dropped below '+ string(h)+' feet)')
else 
    disp ('The packaging cannot protect the package')
end 

maxHeight=4; %ft
vMax=sqrt(2*g*maxHeight);
disp('Assuming the maximum height of dropping is 4 feet, the package will hit the ground at a maximum of ' +string(vMax)+ ' ft/sec')
