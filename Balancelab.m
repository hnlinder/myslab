clear all
close all

cols = [1 6:7]; 
rows=202:1404;
ranges=[202 6 1404 7];
m=zeros(4,length(rows),length(cols)+2);
r=zeros(4,length(rows),length(cols)+2);

m(1,:,2:end-2)=readmatrix("fp1-m1-20220930-085151.csv","Range",ranges);
m(2,:,2:end-2)=readmatrix("fp1-m2-20220930-085309.csv","Range",ranges);
m(3,:,2:end-2)=readmatrix("fp1-m3-20220930-085419.csv","Range",ranges);
m(4,:,2:end-2)=readmatrix("fp1-m4-20220930-085528.csv","Range",ranges);

for i=1:4
    m(i,:,1)=transpose(readmatrix("fp1-m1-20220930-085151.csv","Range",[202 1 1404 1]));
end

r(1,:,2:end-2)=readmatrix("fp2-r1-20220930-085700.csv","Range",ranges);
r(2,:,2:end-2)=readmatrix("fp2-r2-20220930-084612.csv","Range",ranges);
r(3,:,2:end-2)=readmatrix("fp2-r3-20220930-084735.csv","Range",ranges);
r(4,:,2:end-2)=readmatrix("fp2-r4-20220930-084906.csv","Range",ranges);

for i=1:4
    r(i,:,1)=transpose(readmatrix("fp2-r1-20220930-085700.csv","Range",[202 1 1404 1]));
end

%% rad/s -> grader m
mm=m;

for j=1:4
    for k=2:length(mm(j,:,1))
       dt=mm(j,k,1)-mm(j,k-1,1);
       mm(j,k,end-1:end)=(dt*squeeze(mm(j,k,2:3))*(180/pi)+squeeze(mm(j,k-1,end-1:end)));
    end
    mm(j,:,1)=squeeze(mm(j,:,1)-mm(j,1,1));
    meanm(j,:)=mean(squeeze(mm(j,:,end-1:end)),1);
    stdm(j,:)=std(squeeze(mm(j,:,end-1:end)),1);
    mm(j,:,end-1:end)=squeeze(mm(j,:,end-1:end))-meanm(j,:);

    yLimm(j,:)=[min(mm(j,:,end-1)) max(mm(j,:,end-1))];
    zLimm(j,:)=[min(mm(j,:,end)) max(mm(j,:,end))];

    for n=1:length(mm(j,:,1))
        distm(j,n)=norm(squeeze(mm(j,n,end-1:end)));
    end

end


titles=({'Feet tog, eyes open','Feet tog, eyes closed',...
        'Left foot contact, eyes open', ...
        'Right foot contact, eyes open'});

figure
axism=[min(yLimm(:,1)) max(yLimm(:,2)) min(zLimm(:,1)) max(zLimm(:,2))];
for meas=1:4 
    subplot(2,2,meas)
    plot(squeeze(mm(meas,:,end-1)),squeeze(mm(meas,:,end)))
    xlabel('\alpha (Gyro_y) [degrees]');ylabel('\theta (Gyro_z) [degrees]')
    title(titles(meas))
    axis(axism);
    grid ON
end
sgtitle('Individual 1')

meas=2;
figure
subplot(1,2,1)
plot(squeeze(mm(meas,:,1)),squeeze(mm(meas,:,end-1)))
xlabel('time [s]');ylabel('\alpha (Gyro_y) [degrees]');
title('Feet tog, eyes open, m')
grid ON

subplot(1,2,2)
plot(squeeze(mm(meas,:,1)),squeeze(mm(meas,:,end)))
xlabel('time [s]');ylabel('\theta (Gyro_z) [degrees]')
title('Feet tog, eyes open, m')
grid ON
sgtitle('Individual 1')

%% rad/s -> grader r
rr=r;

for j=1:4
    for k=2:length(rr(j,:,1))
       dt=rr(j,k,1)-rr(j,k-1,1);
       rr(j,k,end-1:end)=(dt*squeeze(rr(j,k,2:3))*(180/pi)+squeeze(rr(j,k-1,end-1:end)));
    end
    rr(j,:,1)=squeeze(rr(j,:,1)-rr(j,1,1));
    meanr(j,:)=mean(squeeze(rr(j,:,end-1:end)),1);
    stdr(j,:)=std(squeeze(rr(j,:,end-1:end)),1);
    rr(j,:,end-1:end)=squeeze(rr(j,:,end-1:end))-meanr(j,:);

    yLimr(j,:)=[min(rr(j,:,end-1)) max(rr(j,:,end-1))];
    zLimr(j,:)=[min(rr(j,:,end)) max(rr(j,:,end))];

    for n=1:length(rr(j,:,1))
        distr(j,n)=norm(squeeze(rr(j,n,end-1:end)));
    end
end

titles=({'Feet tog, eyes open','Feet tog, eyes closed',...
        'Left foot contact, eyes open', ...
        'Right foot contact, eyes open'});

figure
axisr=[min(yLimr(:,1)) max(yLimr(:,2)) min(zLimr(:,1)) max(zLimr(:,2))];
for meas=1:4 
    subplot(2,2,meas)
    plot(squeeze(rr(meas,:,end-1)),squeeze(rr(meas,:,end)))
    xlabel('\alpha (Gyro_y) [degrees]');ylabel('\theta (Gyro_z) [degrees]')
    title(titles(meas))
    axis(axisr);
    grid ON
end
sgtitle('Individual 2')

meas=4;
figure
subplot(1,2,1)
plot(squeeze(rr(meas,:,1)),squeeze(rr(meas,:,end-1)))
xlabel('time [s]');ylabel('\alpha (Gyro_y) [degrees]');
title(titles(meas))
grid ON

subplot(1,2,2)
plot(squeeze(rr(meas,:,1)),squeeze(rr(meas,:,end)))
xlabel('time [s]');ylabel('\theta (Gyro_z) [degrees]')
title(titles(meas))
grid ON
sgtitle('Individual 2')


