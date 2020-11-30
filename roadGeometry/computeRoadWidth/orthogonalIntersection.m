function [Dx, Dy, DClength, validLane] = orthogonalIntersection(Ax, Ay, Bx, By, Cx, Cy)
A = [Ax; Ay]; B = [Bx; By]; C = [Cx; Cy];
AB = B - A; AC = C - A;
AD = (dot(AB, AC) * AB) / (norm(AB) ^ 2);
D = A + AD;
Dx = D(1); Dy = D(2);

DB = B - D; DC = C - D;
ABlength = sqrt(AB' * AB); ADlength = sqrt(AD' * AD); DBlength = sqrt(DB' * DB);
DClength = sqrt(DC' * DC);

validLane = 0;
if (ADlength < ABlength) && (DBlength < ABlength)
    validLane = 1;
end
end