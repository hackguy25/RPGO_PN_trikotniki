function plot_PN_triangle(points, normals, lod)
% points:       3 x 3 tabela toèk v prostoru
% normals:      3 x 3 tabela normiranih vektorjev

clf;
hold on;
axis equal;
camproj('perspective');

% trikotnik
tr = triangulation([1 2 3], points);
if lod == 0
    trisurf(tr);
else
    trisurf(tr, "FaceColor", "none");
end

[Bx, By, Bz, Nx, Ny, Nz] = pn_to_bezier(points, normals);

if lod == Inf
    % bezierjeva krpa
    [T, U] = trimeshgrid(100);
    B = bezier3(Bx,By,Bz,U);
    trisurf(T, B(:, 1), B(:, 2), B(:, 3), "EdgeColor", "none");
    
    % kontrolni poligon
    [T, ~] = trimeshgrid(3);
    Ux = controlPoints3asColumn(Bx);
    Uy = controlPoints3asColumn(By);
    Uz = controlPoints3asColumn(Bz);
    trimesh(T, Ux, Uy, Uz, "FaceColor", "none", "EdgeColor", "k");
elseif lod > 0
    % bezierjeva ploskev
    [T, U] = trimeshgrid(lod + 1);
    B = bezier3(Bx,By,Bz,U);
    trisurf(T, B(:, 1), B(:, 2), B(:, 3));

    % normale bezierjeve ploskve
    N = bezier3(Nx,Ny,Nz,U);
    N = normalize(N) / 3;
    N([1 lod+2 end], :) = [];
    B([1 lod+2 end], :) = [];
    quiver3(B(:, 1), B(:, 2), B(:, 3), N(:, 1), N(:, 2), N(:, 3), 0);
end

% normale trikotnika
quiver3(points(:, 1),  points(:, 2),  points(:, 3), ...
        normals(:, 1), normals(:, 2), normals(:, 3), 0);

hold off;

end

