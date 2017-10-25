%Lecture18


%Define state vector
% 1 - sunny; 2 - rainy

x = [0 1];
P = [.9 .1; .5 .5];

% Probability of weather 10 days from now
x_n = zeros(10,2);
for i = 1:10
    x_n(i,:) = x*P^i;
end

% Steady state probability

% q (P - I) = 0

P_I = P - [1 0;0 1];

% Solve system of equations 
% -.1(q1) + .5(q2) = 0
%  .1(q1) - .5(q2) = 0
%   q1 + q2 = 1

% .1(q1) - .5(1-q1) = 0; -->
% .6(q1)  = .5
q1 = .5/.6;
q2 = 1-q1;
[q1 q2]

sunny = q1*365
rainy = q2*365

%% example
%define states
% 1-pro 2-skilled 3-unskilled
x= [0 0 1];
P=[.8 .1 .1; .6 .2 .2; .5 .25 .25];
%n generations from now
n=2;
x_n= zeros(n,3);
for i = 1:n
    x_n(i,:)=x*P^i;
end

%p (pro granddaught | unskilled grandmather) =
0.6750 


% steady state
P_I=P-[1 0 0; 0 1 0; 0 0 1];

% eqn1= -0.2*x+0.6*y+0.5*z == 0
% eqn2= 0.1*x-0.8*y+0.25*z == 0
% eqn3= 0.1*x+0.2*y-0.75*z == 0
% eqn4= x+y+z == 1 

x=5.5/7.5;
y=(-0.5+0.7*x)/.1;
z=1-x-y;

[x y z]







