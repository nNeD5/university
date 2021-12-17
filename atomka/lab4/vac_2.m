clear
clc

%load data
data = load("vac2.txt");
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


%counting m 
m = ones(4,1);
for i=1:length(y(1, :))
    [xData, yData] = prepareCurveData( x, y(:, i));

    % Set up fittype and options.
    ft = fittype( 'Is * (exp(x / (24.6 * 10^(-3) * m)) - 1)', 'independent', 'x', 'dependent', 'y' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.StartPoint = [0.957506835434298 1];

    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );

    fprintf("m_%i = %f\n", i, fitresult.m);
    m(i) = fitresult.m;
end

%couning error m
m_mean = mean(m);
m_error = sqrt(sum((m - m_mean).^2)) / length(m);
fprintf("m = %f +- %f\n", m_mean, m_error);

%plot
Is = 0.01321;
m = 1.984;
fplot( @(x) Is*(exp(x/(24.6 * 10^(-3) * m))-1) );
hold on;
errorbar(x, y_mean, y_error, y_error, x_error, x_error,  '.k', 'capsize', 3);
ylim([-200, 1000]);
xlim([-0.1, 0.5]);

title("I(U)");
ylabel("\it I, mkA");
xlabel("\it U, V");
grid on;