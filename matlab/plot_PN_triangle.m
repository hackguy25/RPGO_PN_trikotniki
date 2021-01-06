function plot_PN_triangle(points, normals, n)
% points:       3 x 3 tabela toèk v prostoru
% normals:      3 x 3 tabela normiranih vektorjev

clf;
hold on;
axis equal;
camproj('perspective');

% trikotnik
tr = triangulation([1 2 3], points);
trisurf(tr, "FaceColor", "none");

[Bx, By, Bz, Nx, Ny, Nz] = pn_to_bezier(points, normals);

% bezierjeva ploskev
[T, U] = trimeshgrid(n);
B = bezier3(Bx,By,Bz,U);
trisurf(T, B(:, 1), B(:, 2), B(:, 3));

% normale bezierjeve ploskve
N = bezier3(Nx,Ny,Nz,U);
N = normalize(N) / 3;
quiver3(B(:, 1), B(:, 2), B(:, 3), N(:, 1), N(:, 2), N(:, 3), 0);

% normale trikotnika
quiver3(points(:, 1),  points(:, 2),  points(:, 3), ...
        normals(:, 1), normals(:, 2), normals(:, 3), 0);

hold off;

end

