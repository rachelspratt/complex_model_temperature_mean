%% This function finds the latitude indices in each month matrix and sends the resulting smaller array to the 'flux' function to calculate the smaller area value
%output=Datan
%output= load('Model_1_lgm_Feb_precip.m') %these are test variables
%%output=load('Model_2_evap_lgm_Jan.m');
%area corrected
%load('Model_4_MOD_temp.csv');
%output=load('mod_temp_test.xlsx');

%% function takes the whole earth values average from read_nc_vars function
%% and splits the data into latitude bands
function [lat_bands]=lat_bands_t(output);
%[hae,zt,tt,tth,tf,ff,fn]=lat_strd
format long

%% 90S-0 Southern hemisphere
nS_0_output=output;
for z=1:length(nS_0_output(2:end,1)); %this counts the row index, eg latitude
    if  nS_0_output(z,1) >= -90 && nS_0_output(z,1)<=0;%finds the indeces greater than or equal to -90 and less than zero
        shoutput(z,:)=nS_0_output(z,:); %southern-hemisphere flux values
    end
end
restricted_flux=shoutput; % smaller array with indeces
area_90S_0=flux(shoutput(:,:));% send the flux array to the 'flux' function to get corresponding area
sum_area_90S_0=(sum(sum(area_90S_0))); % sum the area array for the cell array, below
%c_sum_area_90S_0=sum_area_90S_0*(hae/sum_area_90S_0);
flux_90S_0=area_90S_0.*restricted_flux(2:end,2:end);% multiply area by flux to get volumetric flux
%flux_90S_0=flux_90S_0*(hae/sum_area_90S_0);
half_flux=(sum(sum(flux_90S_0))*.001*0.25)/10^6; % convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band

%% Model 1 latitude band--0-10
z_t_output=output; %band zero-ten
for n=1:length(z_t_output(2:end,1)) ;
    if z_t_output(n,1)>=0 && z_t_output(n,1)<=10;%finds the latitude indeces greater than or equal to 0 and less than ten
        ztoutput(n,:)=z_t_output(n,:);%holding array
    end
end
z_t_N_area=[ ztoutput];%Yields total array from 0 to upper index 10, with zeroes for non-relrvant latitudes
z_t_N_area( ~any(z_t_N_area,2), : ) = [];  %rows-get rid of the zreos
ztoutput( ~any(ztoutput,2), : ) = [];  %rows-get rid of the zreos
area_z_t_N=flux( z_t_N_area)% send the flux array to the 'flux' function to get corresponding area
sum_area_z_t_N=sum(sum(area_z_t_N));% sum the area array for the cell array, below
%c_sum_area_z_t_N=sum_area_z_t_N*(zt/sum_area_z_t_N);
zt_flux=sum(sum(area_z_t_N.*ztoutput(2:end,2:end)));%multiplies area array by flux array
%zt_flux=zt_flux*(zt/sum_area_z_t_N);
zero_ten=(zt_flux*.001*.25)/10^6;% convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band

%% 10-20
t_t_output=output;%band 10-20
for m=1:length(t_t_output(2:end,1)) ;
    if t_t_output(m,1)>=15 && t_t_output(m,1)<=20;%finds the latitude indeces greater than or equal to 10 and less than twenty
        ttoutput(m,:)=t_t_output(m,:);%holding array
    end
end
t_t_N_area=[t_t_output(1,:); ttoutput(:,:)];%Yields total array from 90 S to upper index, with zeroes
t_t_N_area( ~any(t_t_N_area,2), : )=[];   %rows-get rid of the zreos
ttoutput( ~any(ttoutput,2), : ) = [];  %rows-get rid of the zreos
area_t_t_N = flux(t_t_N_area);%send the flux array to the 'flux' function to get corresponding area
sum_area_t_t_N=sum(sum(area_t_t_N));% sum the area array for the cell array, below
%c_sum_area_t_t_N=sum_area_t_t_N*(tt/sum_area_t_t_N);
tt_flux=sum(sum(area_t_t_N.*t_t_N_area(2:end,2:end)));%multiplies area array by flux array
%tt_flux=tt_flux*(tt/sum_area_t_t_N);
ten_twenty=(tt_flux*.001*.25)/10^6;% convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band

%% 20-30

tw_th_output=output;%band 20-30

for i=1:length(tw_th_output(1,:));
 temp_tw(1,i)=tw_th_output(1,i)>=280 & tw_th_output(1,i)<312;
 patch_tw(:,i)= temp_tw(1,i)'.*tw_th_output(:,i);
 temp_patch_tw(:,i)=patch_tw(:,i)'
end

tw_th_output=[tw_th_output(:,1), temp_patch_tw(:,2:end)]
for o=1:length(tw_th_output(2:end,1)) ;
    if tw_th_output(o,1)>=20 && tw_th_output(o,1)<=30;%finds the latitude indeces greater than or equal to 20 and less than thirty
     twthoutput(o,:)=tw_th_output(o,:);%holding array
         %ztoutput(n,:)=z_t_output(n,:);
    end
end

tw_th_N_area=[output(1,1:end);twthoutput(:,:)];%Yields total array from 90 S to upper index, with zeroes
tw_th_N_area( ~any(tw_th_N_area,2), : ) = [];  %rows-get rid of the zreos
twthoutput( ~any(twthoutput,2), : ) = [];  %rows-get rid of the zreo
area_tw_th_N=flux(tw_th_N_area);%send the flux array to the 'flux' function to get corresponding area
sum_area_tw_th_N=sum(sum(area_tw_th_N(:,1:end-1)));% sum the area array for the cell array, below

test=(tw_th_N_area(2:end,2:end))>0

tester=(sum(sum((area_tw_th_N.*test).*(tw_th_N_area(2:end,2:end))/sum(sum(area_tw_th_N.*test)))))-273.1

twth_flux=(sum(sum(area_tw_th_N.*tw_th_N_area(2:end,2:end)))/sum_area_tw_th_N);%multiplies area array by flux array
lat_twenty_thirty=twth_flux;% convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band

%% 30-40

th_f_output=output;%band 20-30

for i=1:length(th_f_output(1,:));
 temp_th(1,i)=th_f_output(1,i)>=284 & th_f_output(1,i)<350;%312
 patch_th(:,i)= temp_th(1,i)'.*th_f_output(:,i);
 temp_patch_th(:,i)=patch_th(:,i)'
end

th_f_output=[th_f_output(:,1), temp_patch_th(:,2:end)]
    for p=1:length(th_f_output(2:end,1)) ;
        if th_f_output(p,1)>=30 && th_f_output(p,1)<=40;%finds the latitude indeces greater than or equal to 30 and less than forty
             thfoutput(p,:)=th_f_output(p,:);%holding array
        end
    end
     th_f_N_area=[th_f_output(1,1:end); thfoutput(:,:)];%Yields total array from 90 S to upper index, with zeroes
  th_f_N_area( ~any(th_f_N_area,2), : ) = [];  %rows-get rid of the zreos
 thfoutput( ~any(thfoutput,2), : ) = [];  %rows-get rid of the zreos
  area_th_f_N=flux(th_f_N_area);%send the flux array to the 'flux' function to get corresponding area
  sum_area_th_f_N=sum(sum(area_th_f_N(:,1:end-1)));% sum the area array for the cell array, below
  %c_sum_area_th_f_N=sum_area_th_f_N*(tf/sum_area_th_f_N);
  test_th=(th_f_N_area(2:end,2:end))>0

tester_th=sum(sum((area_th_f_N.*test_th).*th_f_N_area(2:end,2:end)))/sum(sum(area_th_f_N.*test_th))-273.1
  thf_flux=(sum(sum(area_th_f_N.*th_f_N_area(2:end,2:end)))/sum_area_th_f_N);%multiplies area array by flux array
  lat_thirty_forty=thf_flux-273.14;% convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band
  
  
    
%% 40-50
f_f_output=output;%band 20-30

for i=1:length(f_f_output(1,:));
 temp_f(1,i)=f_f_output(1,i)>=296 & f_f_output(1,i)<350;%312
 patch_f(:,i)= temp_f(1,i)'.*f_f_output(:,i);
 temp_patch_f(:,i)=patch_f(:,i)'
end

f_f_output=[f_f_output(:,1), temp_patch_f(:,2:end)]%band 40-50
    for q=1:length(f_f_output(2:end,1)); 
        if f_f_output(q,1)>=40 && th_f_output(q,1)<=50;%finds the latitude indeces greater than or equal to 40 and less than fifty
             ffoutput(q,:)=f_f_output(q,:);%holding array
        end
    end
     f_f_N_area=[f_f_output(1,1:end);ffoutput(:,:)];%Yields total array from 90 S to upper index, with zeroes
  f_f_N_area( ~any(f_f_N_area,2), : ) = [];  %rows-get rid of the zreos
 ffoutput( ~any(ffoutput,2), : ) = [];  %rows-get rid of the zreos
  area_f_f_N=flux(f_f_N_area);%send the flux array to the 'flux' function to get corresponding area
  sum_area_f_f_N=sum(sum(area_f_f_N(:,1:end-1)));% sum the area array for the cell array, below
  %c_sum_area_f_f_N=sum_area_f_f_N*(ff/sum_area_f_f_N);
  test_f=(f_f_N_area(2:end,2:end))>0

tester_f=(sum(sum((area_f_f_N.*test_f).*(f_f_N_area(2:end,2:end))/sum(sum(area_f_f_N.*test_f)))))-273.1
  ff_flux=(sum(sum(area_f_f_N.*f_f_N_area(2:end,2:end)))/sum_area_f_f_N);%multiplies area array by flux array
  %ff_flux=ff_flux*(ff/sum_area_f_f_N);
  lat_forty_fifty=ff_flux-273.14;% convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band

%% 50-90
f_n_output=output;%band 40-50
    for r=1:length(f_n_output(2:end,1)); 
        if f_n_output(r,1)>=50 && f_n_output(r,1)<=90;%finds the latitude indeces greater than or equal to 50 and less than or equal to 90
             fnoutput(r,:)=f_f_output(r,:);%holding array
        end
    end
     f_n_N_area=[f_n_output(1,:); fnoutput(:,:)];%Yields total array from 90 S to upper index, with zeroes
  f_n_N_area( ~any(f_n_N_area,2), : ) = [];  %rows-get rid of the zreos
 fnoutput( ~any(fnoutput,2), : ) = [];  %rows-get rid of the zreos
  area_f_n_N=flux(f_n_N_area);%send the flux array to the 'flux' function to get corresponding area
  sum_area_f_n_N=sum(sum(area_f_n_N));% sum the area array for the cell array, below
 % c_sum_area_f_n_N=sum_area_f_n_N*(fn/sum_area_f_n_N);
  fn_flux=sum(sum(area_f_n_N.*f_n_N_area(2:end,2:end)));%multiplies area array by flux array
  %fn_flux=fn_flux*(fn/sum_area_f_n_N);
  fifty_ninety=(fn_flux*.001*.25)/10^6;% convert kg*(m-2*s-2) to Sv(m3*s-1), 1/4 of band


  lat_bands=struct('lat_90S_0',{half_flux},'area_90S_0',{sum_area_90S_0},'lat_zero_ten',{zero_ten},'area_zero_ten',{sum_area_z_t_N},'lat_ten_twenty',{ten_twenty},'area_ten_twenty',{sum_area_t_t_N},'lat_twenty_thirty',{lat_twenty_thirty},'area_twenty_thirty',{tester},'lat_thirty_forty',{lat_thirty_forty},'area_thirty_forty',{tester_th},'lat_forty_fifty',{lat_forty_fifty},'area_forty_fifty',{tester_f},'lat_fifty_ninety',{fifty_ninety},'area_fifty_ninety',{sum_area_f_n_N},'total',{sum_area_90S_0+sum_area_z_t_N+sum_area_t_t_N+sum_area_tw_th_N+sum_area_th_f_N+sum_area_f_f_N+sum_area_f_n_N});%,'tot',{half_flux+zero_ten+ten_twenty+twenty_thirty+thirty_forty+forty_fifty+fifty_ninety});
  snapnow;