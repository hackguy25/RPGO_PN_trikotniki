function demo_triangle_subdivide(n)

clf;
hold on;
axis equal;
camproj('perspective');

points = 3 * [0 0 0; 1 .1 .1; .1 1 .1];
normals = normalize([.5 .5 1; .5 .8 1; .8 .5 1]);
tris = [1 2 3];
[points, normals, tris] = pn_subdivide(points, normals, tris, n);

quiver3(points(:, 1),  points(:, 2),  points(:, 3), ...
    normals(:, 1), normals(:, 2), normals(:, 3), 0);
tr = triangulation(tris, points);
trisurf(tr);

hold off;

end

