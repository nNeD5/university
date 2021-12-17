clear
data ='data.txt';
xy = load(data);
x=xy(:,1);
y=xy(:,2);
n=length(x);
fprintf('Number of experimental points n=%d\n',n); 
q=0.05; 
kmax=5; 
T=max(x);
X=ones(n,1)/n^0.5;
for k=1:kmax 
      X=[X [cos(2*pi*k*x/T) sin(2*pi*k*x/T)]*(2/n)^0.5]; 
end 
k=[0 reshape(repmat([1:kmax],2,1),2*kmax,1)'];
[b,bint]=regress(y,X,q);
disp('Confidence intervals for parameters in the model');  
fprintf('%2.0f  %12.7f  %12.7f\n',[k;bint']); 
np=find(prod(bint,2)>0);

  
mmax=max(k(np));
a0=b(1)/(n/4)^0.5;
ak=b(2:2:2*mmax)'/(n/2)^0.5; 
bk=b(3:2:2*mmax+1)'/(n/2)^0.5; 
fprintf('???????????????? ??????? %d-?? ???????:\n',mmax) 
fprintf('y(x)=%f12',a0/2); % ???????? ?????? 
w=[1:mmax;ones(1,mmax)*T]; % ?????????? ????? 
fprintf('%+f12*cos(2*pi*%d*x/%d)%+f12*sin(2*pi*%d*x/%d)',[ak;w;bk;w]); 
yt=a0*ones(size(x))/2; 
for k=1:mmax 
       yt=yt+ak(k)*cos(2*pi*x*k/T)+bk(k)*sin(2*pi*x*k/T); 
end


plot(x,y,'.k',[0;x],[yt(end);yt],'-b') 
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman Cyr','FontSize',10); 
title('\bfTrigonometric approximation') 
xlabel('\itx')
ylabel('\ity') 
fprintf('\n');