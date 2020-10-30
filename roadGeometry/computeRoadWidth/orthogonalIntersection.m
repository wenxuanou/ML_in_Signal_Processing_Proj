function [Dx, Dy] = orthogonalIntersection(Ax, Ay, Bx, By, Cx, Cy)
A = [Ax; Ay]; B = [Bx; By]; C = [Cx; Cy];
AB = B - A; AC = C - A;
AD = (dot(AB, AC) * AB) / (norm(AB) ^ 2);
D = A + AD;
Dx = D(1); Dy = D(2);
end