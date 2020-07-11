%[hae,zt,tt,tth,tf,ff,fn]=lat_strd;
%%
load('Model_1_MOD_evspsbl.csv');
load('Model_1_MOD_pr.csv');
load('Model_2_MOD_evspsbl.csv');
load('Model_2_MOD_pr.csv');
load('Model_3_MOD_evspsbl.csv');
load('Model_3_MOD_pr.csv');
load('Model_4_MOD_evspsbl.csv');
load('Model_4_MOD_pr.csv');
load('Model_5_MOD_evspsbl.csv');
load('Model_5_MOD_pr.csv');
load('Model_6_MOD_evspsbl.csv');
load('Model_6_MOD_pr.csv');
load('Model_7_MOD_evspsbl.csv')
load('Model_7_MOD_pr.csv')
load('Model_8_MOD_evspsbl.csv')
load('Model_8_MOD_pr.csv')

load('Model_4_MOD_temp.csv')
load('Model_6_MOD_temp.csv')
load('Model_7_MOD_temp.csv')
%load('Model_4_LGM_temp.csv')
for i=[4,6,7]
evaporation(i)=read_nc_vars_t((['Model_' num2str(i) '_MOD_evspsbl.csv']));
precipitation(i)=read_nc_vars_t((['Model_' num2str(i) '_MOD_pr.csv']));
temperature(i)=read_nc_vars_t((['Model_' num2str(i) '_MOD_temp.csv']));
%colorv(i)=[ .2.*i 1.*i i.*0.1]

end
%colorv(i)

x=[-45,5,15, 25,35,45, 70]; %vector for plotting lat bands
x1=[ 25,35,45]; %vector for plotting lat bands

%% evaporation and precipitation latitude bands//accessing the structure

for n=[4,6,7] 
o(n)=evaporation(n).lat_90S_0;
o_prime(n)=[o(n) ];
t(n)=evaporation(n).lat_zero_ten;
t_prime(n)=[t(n) ];
th(n)=evaporation(n).lat_ten_twenty;
th_prime(n)=[th(n)];
f(n)=evaporation(n).lat_twenty_thirty;
f_prime(n)=[f(n)];
fi(n)=evaporation(n).lat_thirty_forty;
fi_prime(n)=[fi(n) ];
s(n)=evaporation(n).lat_forty_fifty;
s_prime(n)=[s(n) ];
se(n)=evaporation(n).lat_fifty_ninety;
se_prime(n)=[se(n) ];

on(n)=precipitation(n).lat_90S_0; 
on_prime=[on(n) ];
tw(n)=precipitation(n).lat_zero_ten; 
tw_prime=[tw(n) 3.1269];
thr(n)=precipitation(n).lat_ten_twenty; 
thr_prime=[thr(n) 1.3760];
fo(n)=precipitation(n).lat_twenty_thirty;
fo_prime=[fo(n) .9690];
fiv(n)=precipitation(n).lat_thirty_forty;
fiv_prime=[fiv(n) .8297];
si(n)=precipitation(n).lat_forty_fifty;
si_prime=[si(n) 0.9778]
sev(n)=precipitation(n).lat_fifty_ninety;
sev_prime=[sev(n) 1.1764]

%% E-P

E_P_o(n)=o(n)-on(n);
E_P_t(n)=t(n)-tw(n);
E_P_th(n)=th(n)-thr(n);
E_P_f(n)=f(n)-fo(n);
E_P_fi(n)=fi(n)-fiv(n);
E_P_s(n)=s(n)-si(n);
E_P_se(n)=se(n)-sev(n);

%% temp
%on_t(n)=temperature(n).lat_90S_0; 
%on_t_prime=[on_t(n) ];
%tw_t(n)=temperature(n).lat_zero_ten; 
%tw_t_prime=[tw_t(n) 3.1269];
%thr_t(n)=temperature(n).lat_ten_twenty; 
%thr_t_prime=[thr_t(n) 1.3760];
fo_t(n)=temperature(n).area_twenty_thirty;
fo_t_prime=[fo_t(n) ];%.9690]
fiv_t(n)=temperature(n).area_thirty_forty;
fiv_t_prime=[fiv_t(n) ];%.8297]
si_t(n)=temperature(n).area_forty_fifty;
si_t_prime=[si_t(n) ];%0.9778]
%sev_t(n)=temperature(n).lat_fifty_ninety;
%sev_t_prime=[sev_t(n) 1.1764]



end
%% model data
e=cat(2,o',t',th',f',fi',s',se');
p=cat(2,on',tw',thr',fo',fiv',si',sev');
t=cat(2,(fo_t'),(fiv_t'),(si_t'));
E_P=cat(2,E_P_o',E_P_t',E_P_th',E_P_f',E_P_fi',E_P_s',E_P_se');
E_P_cum=cat(2,E_P_o',E_P_t',E_P_th'+E_P_t',E_P_f'+E_P_th'+E_P_t',E_P_fi'+E_P_f'+E_P_th'+E_P_t',E_P_s'+E_P_fi'+E_P_f'+E_P_th'+E_P_t',E_P_se'+E_P_s'+E_P_fi'+E_P_f'+E_P_th'+E_P_t');
add_to_zero=sum(E_P')
%concatenate these vectors along the 2nd dimension

%C = {[0 0 1],[.6 .2 .6],[.9 0.1],[.5 .5 .2],[1 0 1],[.4 .4 .6],[1 0 0],[0 1 1]}

figure (5)

subplot (1,2,1)
%plot(x,e(1,:),'color',[0 0 1],'linewidth',2)
%hold on
%plot(x,e(2,:),'color',[.6 .6 .6],'linewidth',2)
%hold on
%plot(x,e(3,:),'color',[.9 0 0.1],'linewidth',2)
%hold on
plot(x,e(4,:),'color',[.3 .3 .2],'linewidth',2)
%hold on
%plot(x,e(5,:),'color',[1 0 1],'linewidth',2)
hold on
plot(x,e(6,:),'color',[.9 1 .2],'linewidth',2)
hold on
plot(x,e(7,:),'color',[1 0 0],'linewidth',2)
%hold on
%plot(x,e(8,:),'color',[0 1 1],'linewidth',2)
hold on
%legend('MRI-CGCM3','CCSM4','MIROC-ESM','MPI-ESM','GISS-E2','CNRM-CM5','IPSL-CM5A','FGOALS')
legend('MPI-ESM','CNRM-CM5','IPSL-CM5A')
title('evaporation','fontsize',24)
hold off

subplot (1,2,2)
%plot(x,p(1,:),'color',[0 0 1],'linewidth',2)
%hold on
%plot(x,p(2,:),'color',[.6 .6 .6],'linewidth',2)
%hold on
%plot(x,p(3,:),'color',[.9 0 0.1],'linewidth',2)
%hold on
plot(x,p(4,:),'color',[.3 .3 .2],'linewidth',2)
hold on
%plot(x,p(5,:),'color',[1 0 1],'linewidth',2)
%hold on
plot(x,p(6,:),'color',[.9 1 .2],'linewidth',2)
hold on
plot(x,p(7,:),'color',[1 0 0],'linewidth',2)
%hold on
%plot(x,p(8,:),'color',[0 1 1],'linewidth',2)
%hold on
%legend('MRI-CGCM3','CCSM4','MIROC-ESM','MPI-ESM','GISS-E2','CNRM-CM5','IPSL-CM5A','FGOALS')
legend('MPI-ESM','CNRM-CM5','IPSL-CM5A')
title('precipitation','fontsize',24)
hold off

Q=[ (8.7140-8.1228) (2.2060-3.1269) (1.7150-1.3760) (1.7208-0.9690) (.9553-.8297) (.7064-.9778) (.6170-1.1764)]
Q=[ (8.7140-8.1219) (2.2059-3.1269) (1.7149-1.3760) (1.7207-0.9690) (.9552-.8296) (.7063-.9777) (.6173-1.179)]
Qcum=[ (8.7140-8.1228) sum(Q(1:2))      sum(Q(1:3))     sum(Q(1:4))    sum(Q(1:5)) sum(Q(1:6)) sum(Q(1:7))]
Qcum=[ (8.7140-8.1219) sum(Q(1:2))      sum(Q(1:3))     sum(Q(1:4))    sum(Q(1:5)) sum(Q(1:6)) sum(Q(1:7))]
Q_E=cat(1,E_P,Q)
add_2_zero_2=sum(Q_E');
Q_E_cum=cat(1,E_P_cum,Qcum)
figure (7)
subplot (1,2,1)
%plot(x,E_P(1,:),'color',[0 0 1],'linewidth',2)
%hold on
%plot(x,E_P(2,:),'color',[.6 .6 .6],'linewidth',2)
%hold on
%plot(x,E_P(3,:),'color',[.9 0 0.1],'linewidth',2)
%hold on
plot(x,E_P(4,:),'color',[.3 .3 .2],'linewidth',2)
%hold on
%plot(x,E_P(5,:),'color',[1 0 1],'linewidth',2)
hold on
plot(x,E_P(6,:),'color',[.9 1 .2],'linewidth',2)
hold on
plot(x,E_P(7,:),'color',[1 0 0],'linewidth',2)
%hold on
%plot(x,E_P(8,:),'color',[0 1 1],'linewidth',2)
hold on
plot(x,Q_E(8,:),'color','g','linewidth',2)
hold on
legend('MPI-ESM','CNRM-CM5','IPSL-CM5A','AGCM(Battisti et al.)')
hold on
title('Evaporation minus precipitation by latitude')

subplot(1,2,2)
%plot(x,E_P_cum(1,:),'color',[0 0 1],'linewidth',2)
%hold on
%plot(x,E_P_cum(2,:),'color',[.6 .6 .6],'linewidth',2)
%hold on
%plot(x,E_P_cum(3,:),'color',[.9 0 0.1],'linewidth',2)
%hold on
plot(x,E_P_cum(4,:),'color',[.3 .3 .2],'linewidth',2)
hold on
%plot(x,E_P_cum(5,:),'color',[1 0 1],'linewidth',2)
%hold on
plot(x,E_P_cum(6,:),'color',[.9 1 .2],'linewidth',2)
hold on
plot(x,E_P_cum(7,:),'color',[1 0 0],'linewidth',2)
hold on
%plot(x,E_P_cum(8,:),'color',[0 1 1],'linewidth',2)
%hold on
plot(x,Q_E_cum(8,:),'color','g','linewidth',2)
hold on
legend('MPI-ESM','GISS-E2','IPSL-CM5A','AGCM(Battisti et al.)')
hold on
title('Cumulative Evaporation minus precipitation by latitude')

hold off


figure (8)

mod1=t(4,:);
mod2=t(6,:);
mod3=t(7,:);
%plot(x,e(1,:),'color',[0 0 1],'linewidth',2)
%hold on
%plot(x,e(2,:),'color',[.6 .6 .6],'linewidth',2)
%hold on
%plot(x,e(3,:),'color',[.9 0 0.1],'linewidth',2)
%hold on
plot(x1,mod1,'color',[.3 .3 .2],'linewidth',2)
%hold on
%plot(x,e(5,:),'color',[1 0 1],'linewidth',2)
hold on
plot(x1,mod2,'color',[.9 1 .2],'linewidth',2)
hold on
plot(x1,mod3,'color',[1 0 0],'linewidth',2)
%hold on
%plot(x,e(8,:),'color',[0 1 1],'linewidth',2)
hold on
%legend('MRI-CGCM3','CCSM4','MIROC-ESM','MPI-ESM','GISS-E2','CNRM-CM5','IPSL-CM5A','FGOALS')
legend('MPI-ESM','CNRM-CM5','IPSL-CM5A')
title('temp','fontsize',24)
hold off

thfmean3=(mod1(2)+mod2(2)+mod3(2))/3
thfmean4=(mod1(2)+mod2(2)+mod3(2)+18.4892)/4

ffmean3=(mod1(3)+mod2(3)+mod3(3))/3
ffmean4=(mod1(3)+mod2(3)+mod3(3)+11.1270)/4