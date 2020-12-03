clear; clc;

N = 10;
a1 = ones(1, N); a2 = -ones(1, N);
t1 = 0:(N - 1); t2 = 0:(N - 1);

v1 = a1 .* t1; v2 = v1(end) + a2 .* t2;
x1 = (0.5 * a1) .* (t1 .^ 2); %x2 = v2 .* t2 + (0.5 * a2) .* (t2 .^ 2);