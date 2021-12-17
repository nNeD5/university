x = [25.2 26.4 26.0 25.8 24.0 25.7 25.7 25.7 26.1 25.8 25.9 26.2 25.6 25.4 26.6 26.2 26.0 22.1 25.9 25.8 25.9 26.3 26.1 26.0 26.4];
y = [30.8 29.4 30.2 30.5 31.4 30.3 30.4 30.5 29.9 30.4 30.3 30.5 30.6 31.0 29.6 30.4 30.7 31.6 30.5 30.6 30.7 30.1 30.6 30.5 30.7];

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