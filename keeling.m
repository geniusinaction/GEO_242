% keeling.m - attempts to load in and plot the Keeling curve
% (CO2 at Mauna Loa) and then fit stuff to it

% gjf, 15-nov-2022

infile='monthly_in_situ_co2_mlo.csv';

% load in yer data
% filled data starts in March 1953 (line 60)
indata = csvread(infile,60,0);

% last two lines have no data, might as well get rid
indata(end-1:end,:)=[];

% and plot it!
close all    % start with fresh figures
figure
plot(indata(:,4),indata(:,9),'k')
xlabel('year')
ylabel('pCO2 (ppm)')
hold on

% fit some straight lines dere
earlydata=indata(indata(:,4)<1974,:);
A_early=[earlydata(:,4),ones(size(earlydata(:,4)))];
d_early=earlydata(:,9);
m_early=A_early\d_early;

A_early_line=[1950 1; 1990 1];
d_early_line=A_early_line*m_early;

plot(A_early(:,1),d_early,'m')
plot(A_early_line(:,1),d_early_line,'r--')

latedata=indata(indata(:,4)>2006,:);
A_late=[latedata(:,4),ones(size(latedata(:,4)))];
d_late=latedata(:,9);
m_late=A_late\d_late;

A_late_line=[1990 1; 2040 1];
d_late_line=A_late_line*m_late;

plot(A_late(:,1),d_late,'c')
plot(A_late_line(:,1),d_late_line,'b--')

% next, try to fit a parabola to this!

A_para=[indata(:,4).^2 indata(:,4) ones(size(indata(:,4)))];
d_para=indata(:,9);
m_para=A_para\d_para;

x_para_line=(1950:2040)';
A_para_line=[x_para_line.^2 x_para_line ones(size(x_para_line))];
d_para_line=A_para_line*m_para;

figure
plot(indata(:,4),indata(:,9),'k')
xlabel('year')
ylabel('pCO2 (ppm)')
hold on

plot(x_para_line(:,1),d_para_line,'g--')


% super, now let's go nuts with polynomials
meandate=mean(indata(:,4));        % this should be the middle of the time series
x_poly=indata(:,4)-meandate;       % polyfit will complain if you don't do this
x_poly_line=(1950:2040)';          % this is for plotting purposes
x_poly_calc=x_poly_line-meandate;  % this is for calculation purposes

d_poly=indata(:,9);

figure
% The DisplayName property helps with plotting a legend
plot(indata(:,4),indata(:,9),'k','DisplayName','data')
xlabel('year')
ylabel('pCO2 (ppm)')
hold on

for i=2:6    % loop through polynomial orders 2 to 6

    % calculate best-fitting polynomial coefficients 
    % for the ith order polynomial
    p=polyfit(x_poly,d_poly,i);
    % use them to evaluate the polynomial function
    d_poly_line=polyval(p,x_poly_calc);
    % plot, and assign a name based on the order of the polynomial
    plot(x_poly_line,d_poly_line,'DisplayName',sprintf('order %d',i))
    
end

% and plot a legend to see what's what
legend('Location','northwest')





