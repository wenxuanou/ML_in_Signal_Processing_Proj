clear; clc;

sigma = 1; mu = 0;
a = normrnd(mu, sigma, 1, 10);

%Nothing, Accelerate: Right, Up, Left, Down, Stop: Right, Up, Left, Bottom
ux = [0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1; 0 0 0 0];
uy = [0 0 0 0; 0 0 0 0; 1 1 1 1; 0 0 0 0; -1 -1 -1 -1; 0 0 0 0; 1 1 -1 -1; 0 0 0 0; -1 -1 1 1];

