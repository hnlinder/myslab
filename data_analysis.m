data = load("test.xlsx");
T = data(:,2);

ln = length(data);
dtime = ln
dV = max(T) - min(T);


t = linspace(0,length(T),length(T))
P = polyfit(t,log(T),1)
y = polyval(P,t)

plot(t,y)




