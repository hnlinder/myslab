clear all
close all
lambda = log(0.87)/9;
function at_tum = tumourf(AB)
  lambda = log(0.87)/9;
  at_tum = AB* exp(lambda *61);
end

%function  = bieff()



%tumour = @(AB) AB* exp(lambda *20);
AB = 30:1:90
tum = zeros(length(AB),1)
for i = 1:length(AB)
  tum(i) = tumourf(AB(i))
end


plot(AB,tum)

%tumour()




