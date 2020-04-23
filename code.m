clc,clear

f = @(t,y) exp(t-y); % the ode
yExact = log( exp(1) + exp(1) - 1); % at t = 1

% 0<=t<=1
t0 = 0;
tf = 1;
% N list
N_values = [5,10,20,40,80,160,320,640,1280,2560];
%
for j =1:length(N_values)
  
N = N_values(j);
h = (tf-t0)/N;
y = 1; % y(0) = 1

% RK4
for t = t0:h:tf % 0<=t<=1
% compute the K's
K1 = h*f(t,y);
K2 = h*f(t,y + K1/2);
K3 = h*f(t,y + K2/2);
K4 = h*f(t,y + K3);
% compute y
y = y + K1/6 + K2/3 + K3/3 + K4/6;
end

err = abs(yExact - y) ; % at final step t=1
errors(j) = err; % store error for each N to compute ratios

if j>1
ratios_of_errors(j-1) = errors(j-1)/errors(j); % compute ratio EN/E2N
end

end
% display results
disp('N: ');disp(N_values)
disp('errors (EN): ');disp(errors)
disp('ratios of errors (EN/E2N): ');disp(ratios_of_errors)
