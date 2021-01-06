function demo_triangle()

points = 3 * [0 0 0; 1 .1 .1; .1 1 .1];
normals = normalize([.5 .5 1; .5 .8 1; .8 .5 1]);
plot_PN_triangle(points, normals, 20);

end

