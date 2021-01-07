function demo_suzanne()

clf;
hold on;
axis equal;
camproj('perspective');

suz_points = load("suzanne_points.txt");
suz_normals = suz_points(:, [4 5 6]);
suz_points = suz_points(:, [1 2 3]);
suz_tris = load("suzanne_tris.txt") + 1;
suzanne = triangulation(suz_tris, suz_points);

trisurf(suzanne, "EdgeColor", "none");
quiver3(suz_points(:, 1), suz_points(:, 2), suz_points(:, 3), ...
    suz_normals(:, 1), suz_normals(:, 2), suz_normals(:, 3));

hold off;

end

