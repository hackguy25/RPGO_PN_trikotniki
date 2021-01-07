function demo_suzanne()

clf;
tiledlayout(1,3);

nexttile();
axis equal;
camproj('perspective');
hold on;

suz_points = load("suzanne_points.txt");
suz_normals = normalize(suz_points(:, [4 5 6]));
suz_points = suz_points(:, [1 2 3]);
suz_tris = load("suzanne_tris.txt") + 1;
suzanne = triangulation(suz_tris, suz_points);

% trisurf(suzanne, "EdgeColor", "none");
trisurf(suzanne);
quiver3(suz_points(:, 1), suz_points(:, 2), suz_points(:, 3), ...
    suz_normals(:, 1), suz_normals(:, 2), suz_normals(:, 3));

view(12,5);
nexttile();
axis equal;
camproj('perspective');
hold on;

[suz_points_s, suz_normals_s, suz_tris_s] = ...
    pn_subdivide(suz_points, suz_normals, suz_tris, 3);
suzanne = triangulation(suz_tris_s, suz_points_s);
trisurf(suzanne);
quiver3(suz_points_s(:, 1), suz_points_s(:, 2), suz_points_s(:, 3), ...
    suz_normals_s(:, 1), suz_normals_s(:, 2), suz_normals_s(:, 3));

view(12,5);
nexttile();
axis equal;
camproj('perspective');
hold on;

[suz_points_s, suz_normals_s, suz_tris_s] = ...
    pn_subdivide(suz_points, suz_normals, suz_tris, 31);
suzanne = triangulation(suz_tris_s, suz_points_s);
f = trisurf(suzanne, "EdgeColor", "none");
shading interp;
lightangle(180,30)
f.FaceLighting = 'gouraud';
f.AmbientStrength = 0.3;
f.DiffuseStrength = 0.8;
f.SpecularStrength = 0.9;
f.SpecularExponent = 25;
f.BackFaceLighting = 'unlit';
% quiver3(suz_points_s(:, 1), suz_points_s(:, 2), suz_points_s(:, 3), ...
%     suz_normals_s(:, 1), suz_normals_s(:, 2), suz_normals_s(:, 3), ...
%     "LineWidth", 0.25);

view(12,5);

end

