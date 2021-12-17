clear
clc

%load data
data = load("vfc0.txt");
x = data(:,1);
y = data(:,2:5);

y_mean = ones(length(y), 1);
for i = 1:length(y_mean)
    y_mean(i) = mean(y(i,:)); 
end

%error counting
x_error = 0.005 * ones(length(x), 1); 
y_error = ones(length(y_mean), 1);


for i = 1:length(y_mean)
    s = 0;
    for j = 1:4
        s = s + (y(i, j) - y_mean(i))^2;
    end
    y_error(i) = sqrt(s) / length(y(1,:));  
end
disp(y_error);


%plot
c_0 = 465.1;
n = 0.4116;
phi = -2.458;
fu = @(x) c_0 * (phi / (phi + x)).^n;

fplot(fu);

hold on
errorbar(x, y_mean, y_error, y_error, x_error, x_error,  '.k', 'capsize', 3);

ylim([320, 460]);
xlim([-4, 0]);


title("C(U)");
xlabel("\it U, V");
ylabel("\it C, pF");
legend("fu = 465.1 * (-2.458 / {(-2.458 + x))}^0.4116");

grid on;



