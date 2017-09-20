%Lecture9

[data text combined]  = xlsread('state_fuel_cf.xlsx');

%conditional 
state = 'NC';
fuel = 'SUN';
cf = .20;

%5
% state probabilities
a = strcmp(state,text(:,1)); %boolean operator
state_prob=sum(a)/length(data)

%state_plants = find(a(:,1)>0); %does the same thing
%state_prob = length(state_plants)/length(data);

b=strcmp(fuel,text(:,2));
solar_prob=sum(b)/length(data)

%6
c=(data)>cf;
cf_prob=sum(c)/length(data)

%7b

%i
sun=strcmp(fuel,text(:,2));
sun_rows=find(sun(:,1)>0);
sun_plant=text(sun_rows,:);

nc_sun=strcmp(state,sun_plant(:,1));
nc__giv_sun_prob=sum(nc_sun)/length(sun_plant)

%ii
nc=strcmp(state,text(:,1));
nc_rows=find(nc(:,1)>0);
nc_plant=text(nc_rows,:);

sun_nc=strcmp(fuel,nc_plant(:,2));
sun__giv_nc_prob=sum(sun_nc)/length(nc_plant)

% iii
c=(data)>cf;
cf_rows=find(c(:,1)>0);
cf_plant=text(cf_rows,:);

d=strcmp(state,cf_plant(:,1));
cf_nc_rows=find(d(:,1)>0);
cf_nc_plant=cf_plant(cf_nc_rows,:);

e=strcmp(fuel,cf_nc_plant(:,2));
cf_nc_sun_rows=find(e(:,1)>0);
cf_nc_sun_plant=cf_nc_plant(cf_nc_sun_rows,:); 

cf_nc_sun_prob=length(cf_nc_sun_plant)/length(data)

%iv
nc = strcmp(state,combined(:,1)); 
nc_rows=find(nc(:,1)>0);
nc_plant=combined(nc_rows,:);
solar=strcmp(fuel, nc_plant(:,2));
solar_rows=find(solar(:,1)>0);
nc_solar_plant=nc_plant(solar_rows,:);
cf_giv_nc__solar_prob=length(cf_nc_sun_plant)/length(nc_solar_plant)


%v the numerator of both probabilities is the same-- what changes is the
%denominator. for iii the denominator is all of the data values, while for
%iv it's solely the nc plants.
