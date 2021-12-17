clear
clc

%load data
data = load("data.txt");
x = data(:, 1);
y = data(:, 2);

%mean value
x_mean = mean(x);
y_mean = mean(y);

%calculating sigma
sigma_x = sqrt( sum( (x - x_mean).^2 ) / length(x) ); 
sigma_y = sqrt( sum( (y - y_mean).^2 ) / length(y) ); 
sigma_xy = sum( (y - y_mean) .* (x - x_mean) ) / length(y);


%answer task1 task2
fprintf("-----task1 task2-----\n");
r_my = sigma_xy / ( sigma_x * sigma_y );
r_native = corrcoef(x, y);
fprintf("Corrcoef:\n my: %f\t native: %f\n", r_my, r_native(1, 2));

c_my = sigma_xy;
c_native = cov(x, y);
    fprintf("Cov:\n my: %f\t native: %f\n", c_my, c_native(1, 2));

%ploting task3 
fprintf("-----task3-----\n");
plot(x, y, '.');
n = length(x);
fprintf("number of point: %i\n", n);

% task 4
fprintf("-----task4-----\n");

%calculating corrcoeff mean error task 5
fprintf("-----task5-----\n");
s_r = (1 - r_my^2) / (sqrt(n - 1));
fprintf("mean error r: %f\n", s_r);
fprintf("|r / s_r| = %f\n", abs(r_my / s_r));
