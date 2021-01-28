function [Bx, By, Bz, Nx, Ny, Nz] = pn_to_bezier(points, normals)

[Bx, By, Bz] = deal(nan(4, 4));

%% vertex coefficients
Bx(1, 1) = points(1, 1);
By(1, 1) = points(1, 2);
Bz(1, 1) = points(1, 3);

Bx(1, 4) = points(2, 1);
By(1, 4) = points(2, 2);
Bz(1, 4) = points(2, 3);

Bx(4, 1) = points(3, 1);
By(4, 1) = points(3, 2);
Bz(4, 1) = points(3, 3);

%% tangent coefficients
w12 = (points(2, :) - points(1, :)) * normals(1, :)';
w21 = (points(1, :) - points(2, :)) * normals(2, :)';
w23 = (points(3, :) - points(2, :)) * normals(2, :)';
w32 = (points(2, :) - points(3, :)) * normals(3, :)';
w31 = (points(1, :) - points(3, :)) * normals(3, :)';
w13 = (points(3, :) - points(1, :)) * normals(1, :)';

Bx(1, 2) = (2*points(1, 1) + points(2, 1) - w12*normals(1, 1)) / 3;
By(1, 2) = (2*points(1, 2) + points(2, 2) - w12*normals(1, 2)) / 3;
Bz(1, 2) = (2*points(1, 3) + points(2, 3) - w12*normals(1, 3)) / 3;

Bx(1, 3) = (2*points(2, 1) + points(1, 1) - w21*normals(2, 1)) / 3;
By(1, 3) = (2*points(2, 2) + points(1, 2) - w21*normals(2, 2)) / 3;
Bz(1, 3) = (2*points(2, 3) + points(1, 3) - w21*normals(2, 3)) / 3;

Bx(2, 3) = (2*points(2, 1) + points(3, 1) - w23*normals(2, 1)) / 3;
By(2, 3) = (2*points(2, 2) + points(3, 2) - w23*normals(2, 2)) / 3;
Bz(2, 3) = (2*points(2, 3) + points(3, 3) - w23*normals(2, 3)) / 3;

Bx(3, 2) = (2*points(3, 1) + points(2, 1) - w32*normals(3, 1)) / 3;
By(3, 2) = (2*points(3, 2) + points(2, 2) - w32*normals(3, 2)) / 3;
Bz(3, 2) = (2*points(3, 3) + points(2, 3) - w32*normals(3, 3)) / 3;

Bx(3, 1) = (2*points(3, 1) + points(1, 1) - w31*normals(3, 1)) / 3;
By(3, 1) = (2*points(3, 2) + points(1, 2) - w31*normals(3, 2)) / 3;
Bz(3, 1) = (2*points(3, 3) + points(1, 3) - w31*normals(3, 3)) / 3;

Bx(2, 1) = (2*points(1, 1) + points(3, 1) - w13*normals(1, 1)) / 3;
By(2, 1) = (2*points(1, 2) + points(3, 2) - w13*normals(1, 2)) / 3;
Bz(2, 1) = (2*points(1, 3) + points(3, 3) - w13*normals(1, 3)) / 3;

%% center coefficient
Ex = (Bx(1, 2) + Bx(1, 3) + Bx(2, 3) + Bx(3, 2) + Bx(3, 1) + Bx(2, 1)) / 6;
Ey = (By(1, 2) + By(1, 3) + By(2, 3) + By(3, 2) + By(3, 1) + By(2, 1)) / 6;
Ez = (Bz(1, 2) + Bz(1, 3) + Bz(2, 3) + Bz(3, 2) + Bz(3, 1) + Bz(2, 1)) / 6;

V = (points(1, :) + points(2, :) + points(3, :)) / 3;

Bx(2, 2) = (3*Ex - V(1))/2;
By(2, 2) = (3*Ey - V(2))/2;
Bz(2, 2) = (3*Ez - V(3))/2;

%% normals
if nargout > 3
    [Nx, Ny, Nz] = deal(nan(3, 3));
    
    Nx(1, 1) = normals(1, 1);
    Ny(1, 1) = normals(1, 2);
    Nz(1, 1) = normals(1, 3);
    
    Nx(1, 3) = normals(2, 1);
    Ny(1, 3) = normals(2, 2);
    Nz(1, 3) = normals(2, 3);
    
    Nx(3, 1) = normals(3, 1);
    Ny(3, 1) = normals(3, 2);
    Nz(3, 1) = normals(3, 3);
    
    v12 = 2 * ((points(2, :) - points(1, :)) * (normals(1, :) + normals(2, :))') ...
            / ((points(2, :) - points(1, :)) * (points(2, :) - points(1, :))');
    v23 = 2 * ((points(3, :) - points(2, :)) * (normals(2, :) + normals(3, :))') ...
            / ((points(3, :) - points(2, :)) * (points(3, :) - points(2, :))');
    v31 = 2 * ((points(1, :) - points(3, :)) * (normals(3, :) + normals(1, :))') ...
            / ((points(1, :) - points(3, :)) * (points(1, :) - points(3, :))');
    
    h110 = normals(1, :) + normals(2, :) - v12 * (points(2, :) - points(1, :));
    h011 = normals(2, :) + normals(3, :) - v23 * (points(3, :) - points(2, :));
    h101 = normals(3, :) + normals(1, :) - v31 * (points(1, :) - points(3, :));
    
    h110 = h110 / norm(h110);
    h011 = h011 / norm(h011);
    h101 = h101 / norm(h101);
    
    h110 = h110 / 2;
    h011 = h011 / 2;
    h101 = h101 / 2;
    
    Nx(1, 2) = h110(1);
    Ny(1, 2) = h110(2);
    Nz(1, 2) = h110(3);
    
    Nx(2, 2) = h011(1);
    Ny(2, 2) = h011(2);
    Nz(2, 2) = h011(3);
    
    Nx(2, 1) = h101(1);
    Ny(2, 1) = h101(2);
    Nz(2, 1) = h101(3);
end

end

