function plot_PN_triangulation(points,normals,triangles)
% points:       n x 3 tabela toèk v prostoru
% normals:      n x 3 tabela normiranih vektorjev
% triangles:    k x 3 tabela indeksov trikotnikov

clf;
hold on;
axis equal;

tr = triangulation(triangles, points);
trisurf(tr);
quiver3(points(:, 1),  points(:, 2),  points(:, 3), ...
        normals(:, 1), normals(:, 2), normals(:, 3));

end

