%% Initialise

clear
close all
clc

%% Objective function and its gradients

% Store coefficients (all Qa_i are symmetric)
Qa(:, :,  1) = [ ...
    1.610e+00, 6.334e-01, 1.027e+00; ...
    6.334e-01, 1.989e+00, 3.588e+00; ...
    1.027e+00, 3.588e+00, 6.119e-01];
Qa(:, :,  2) = [ ...
    1.326e+00, 1.426e+00, 1.722e+00; ...
    1.426e+00, 8.150e-01, 3.847e+00; ...
    1.722e+00, 3.847e+00, 1.572e-01];
Qa(:, :,  3) = [ ...
    1.944e+00, 2.213e+00, 9.709e-01; ...
    2.213e+00, 8.345e+00, 2.251e+00; ...
    9.709e-01, 2.251e+00, 2.143e+00];
Qa(:, :,  4) = [ ...
    4.476e+00, 1.311e+00, 1.070e+00; ...
    1.311e+00, 1.005e+00, 2.457e+00; ...
    1.070e+00, 2.457e+00, 1.288e+00];
Qa(:, :,  5) = [ ...
    4.817e+00, 8.572e-01, 3.927e+00; ...
    8.572e-01, 1.317e+00, 1.326e+00; ...
    3.927e+00, 1.326e+00, 1.518e+00];
Qa(:, :,  6) = [ ...
    5.076e-01, 2.797e+00, 5.638e-01; ...
    2.797e+00, 6.397e+00, 2.024e+00; ...
    5.638e-01, 2.024e+00, 2.789e+00];
Qa(:, :,  7) = [ ...
    3.269e-01, 2.386e-01, 3.345e+00; ...
    2.386e-01, 2.251e+00, 4.631e+00; ...
    3.345e+00, 4.631e+00, 2.869e+00];
Qa(:, :,  8) = [ ...
    3.377e-01, 1.830e+00, 1.292e+00; ...
    1.830e+00, 3.729e-01, 2.225e+00; ...
    1.292e+00, 2.225e+00, 2.145e+00];
Qa(:, :,  9) = [ ...
    7.065e-01, 4.301e+00, 1.533e+00; ...
    4.301e+00, 2.973e-01, 1.655e+00; ...
    1.533e+00, 1.655e+00, 4.824e+00];
Qa(:, :, 10) = [ ...
    6.107e+00, 3.592e-01, 9.282e-01; ...
    3.592e-01, 2.499e+00, 1.400e+00; ...
    9.282e-01, 1.400e+00, 1.414e+00];
Qa(:, :, 11) = [ ...
    1.174e+00, 1.761e+00, 1.028e+00; ...
    1.761e+00, 3.724e+00, 1.430e+00; ...
    1.028e+00, 1.430e+00, 9.004e-02];
Qa(:, :, 12) = [ ...
    5.300e+00, 6.501e-01, 2.003e+00; ...
    6.501e-01, 2.022e+00, 3.085e+00; ...
    2.003e+00, 3.085e+00, 5.210e-01];
Qa(:, :, 13) = [ ...
    3.421e+00, 1.030e+00, 2.393e-01; ...
    1.030e+00, 3.872e+00, 1.806e+00; ...
    2.393e-01, 1.806e+00, 2.305e-01];
Qa(:, :, 14) = [ ...
    9.676e-01, 1.394e+00, 6.407e-01; ...
    1.394e+00, 6.058e-01, 1.159e+00; ...
    6.407e-01, 1.159e+00, 4.025e+00];
Qa(:, :, 15) = [ ...
    3.178e+00, 4.478e+00, 1.695e+00; ...
    4.478e+00, 3.416e+00, 1.484e+00; ...
    1.695e+00, 1.484e+00, 1.688e-01];
Qa(:, :, 16) = [ ...
    2.482e+00, 3.579e+00, 8.461e-01; ...
    3.579e+00, 5.098e-01, 1.880e+00; ...
    8.461e-01, 1.880e+00, 1.194e+00];
Qa(:, :, 17) = [ ...
    8.783e-01, 9.422e-01, 1.467e-01; ...
    9.422e-01, 3.140e-01, 4.093e+00; ...
    1.467e-01, 4.093e+00, 9.792e-01];
Qa(:, :, 18) = [ ...
    3.957e+00, 1.058e+00, 1.099e+00; ...
    1.058e+00, 5.548e+00, 3.787e+00; ...
    1.099e+00, 3.787e+00, 1.741e-01];
Qa(:, :, 19) = [ ...
    1.187e+00, 1.090e+00, 4.036e+00; ...
    1.090e+00, 1.794e-01, 9.418e-01; ...
    4.036e+00, 9.418e-01, 4.685e-01];
Qa(:, :, 20) = [ ...
    3.290e+00, 1.562e+00, 5.638e-01; ...
    1.562e+00, 2.019e+00, 3.075e+00; ...
    5.638e-01, 3.075e+00, 7.198e-01];

% Store the number of addends in the stochastic objective
nQa = size(Qa, 3);

% Define the objective function
objFun = @(x) 0.5*([x', 1]*sum(Qa, 3)*[x; 1])./nQa;

% Define the full gradient and the stochastic gradient functions
grad = @(x) ([x; 1]'*sum(Qa, 3)*eye(3, 2))'./nQa;
gradStoch = @(i, x) ([x; 1]'*Qa(:, :, i)*eye(3, 2))';

%% Compute the objective function values (for plotting)

rangeX = linspace(-2, +4, 100);
rangeY = linspace(-6, +2, 100);

[X, Y] = meshgrid(rangeX, rangeY);

Z = zeros(size(X));

for i = 1 : 1 : length(rangeX)
    for j = 1 : 1 : length(rangeY)
        Z(j, i) = objFun([rangeX(i); rangeY(j)]);
    end
end

%% Perform optimisation

x0 = [3; -4];
nIter = 500;
idxSG = randi(nQa, 1, nIter);

solvers = { ...
    'VanillaSGD', ...
    'AdaGrad', ...
    'AdaGradDecay', ...
    'Adadelta', ...
    'Adam', ...
    'Adamax', ...
    };

xMat.VanillaSGD = VanillaSGD(gradStoch, x0, nIter, idxSG, 0.01);
xMat.AdaGrad = AdaGrad(gradStoch, x0, nIter, idxSG, 0.1);
xMat.AdaGradDecay = AdaGradDecay(gradStoch, x0, nIter, idxSG, 0.1, 0.9);
xMat.Adadelta = Adadelta(gradStoch, x0, nIter, idxSG, 0.95);
xMat.Adam = Adam(gradStoch, x0, nIter, idxSG, 0.1, 0.8, 0.999);
xMat.Adamax = Adamax(gradStoch, x0, nIter, idxSG, 0.1, 0.9, 0.999);


for i = 1 : 1 : length(solvers)
    objFunMat.(solvers{i}) = ...
        cellfun(objFun, num2cell(xMat.(solvers{i}), 1));
end

%% Plot results -- Convergence plot

figConvergence = figure( ...
    'Name', 'Convergence behaviour of different solvers');
for i = 1 : 1 : length(solvers)
    plot(objFunMat.(solvers{i}),'color', rand(1,3));
    hold on
end
hold off
legend(solvers);
xlim([1, nIter + 1]);

%% Plot results -- Contour plot of the objective function

figContour = figure('Name', 'Contour plot of the objective function');

surf(X, Y, Z, 'EdgeAlpha', 0.1);
colormap bone
xlabel('x');
ylabel('y');
xlim(rangeX([1, end]));
ylim(rangeY([1, end]));

hold on
for i = 1 : 1 : length(solvers)
    plot3(xMat.(solvers{i})(1, :), xMat.(solvers{i})(2, :), ...
        objFunMat.(solvers{i}), ...
        'LineWidth', 1.4,'color', rand(1,3));
end
hold off
legend([{'Obj fun'}, solvers]);
