clear
data ='data2.txt';
xy = load(data);
x=xy(:,1);
y=xy(:,2);
n=length(x);
fprintf('Number of experimental points n=%d\n',n); 
fprintf('Minized Polynom:\n')
fprintf('%+f14*x^%d',[p1;[2:-1:0]]);
fprintf('\n');
p=polyfit(x,y,2); 
fprintf('MNK Polynom:\n')
fprintf('%+f14*x^%d',[p;[2:-1:0]]);
fprintf('\n');

p1=fminsearch(@fun1,p,[],x,y);

yt=polyval(p,x); 
yt1=polyval(p1,x);

hold on
plot(x,y,'.k');
plot (x, yt);
plot (x, yt1);
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman Cyr','FontSize',10); 
title('\bfPlot');
legend('data', 'MNK', 'Minized');   
xlabel('\itx')
ylabel('\ity') 
fprintf('\n');


function ff=fun1(b,x,y) 
ff=max(abs(y-b(1)*x.^2-b(2)*x-b(3))); 
end 