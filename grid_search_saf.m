% grid_search_saf.m - a grid search for the slip rate and locking depth
% of the san andreas fault

% gjf, 29-nov-2022

close all

load gps_data.dat

% x is the distance of each gps station from the fault in km
x = gps_data(:,1);
% v is the fault-parallel velocity in mm/yr
v = gps_data(:,2);

% set up the values of slip rate and locking depth to evaluate
s = 15:40;   % slip rate (mm/yr)
d = 10:30;   % locking depth (km)

penalty=zeros(length(s),length(d));

% loop over slip rate
for i=1:length(s)
    
   % and locking depth
   for j=1:length(d)
    
       % evaluate the arctangent function
       v_prime = -(s(i)/pi)*atan(x/d(j));
       v_shift=mean(v-v_prime);   % the mean residual
       % total squared penalty with the mean residual removed
       penalty(i,j)=(v-v_prime-v_shift)'*(v-v_prime-v_shift);
    
   end
    
end

% plot the results

figure;
imagesc(d,s,penalty);
axis image
axis xy
colorbar
xlabel('locking depth (km)')
ylabel('slip rate (mm/yr)')
hold on

% find the minimum
[min_i,min_j]=find(penalty==min(min(penalty)));
fprintf(1,'best penalty %f, slip rate %5.2f mm/yr, locking depth %5.2f km\n',...
    penalty(min_i,min_j), s(min_i), d(min_j));
plot(d(min_j),s(min_i),'r*')
title(sprintf('slip rate %5.2f mm/yr, locking depth %5.2f km',...
    s(min_i), d(min_j)));


