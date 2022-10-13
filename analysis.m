% plot(test)
close all 

ind = 80;
nr_data_points = length(test)-ind;
data = test(ind:end);
dT = data(end)-data(1);
% dtime = length(test(ind:end));


t = linspace(1,nr_data_points, nr_data_points+1);
P = polyfit(t,log(data), 1);

coeff = P(1)
y = polyval(P,t);


plot(t,y)