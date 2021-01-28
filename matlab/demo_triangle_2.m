function demo_triangle_2()

points = 3 * [0 0 0; 1 .1 .1; .1 1 .1];
normals = normalize([.2 .2 1; .8 0 1; 0 .5 1]);

plot_PN_triangle(points, normals, 0);
grid off;
view(12,15);
print('figs/tri/tri', '-dpng', '-r400')
grid on;

pause;
plot_PN_triangle(points, normals, inf);
grid on;
view(12,15);

pause;
plot_PN_triangle(points, normals, 1);
grid off;
view(12,15);
print('figs/tri/lod_1', '-dpng', '-r400')
grid on;

pause;
plot_PN_triangle(points, normals, 2);
grid off;
view(12,15);
print('figs/tri/lod_2', '-dpng', '-r400')
grid on;

pause;
plot_PN_triangle(points, normals, 3);
grid off;
view(12,15);
print('figs/tri/lod_3', '-dpng', '-r400')
grid on;

pause;
plot_PN_triangle(points, normals, 5);
grid off;
view(12,15);
print('figs/tri/lod_5', '-dpng', '-r400')
grid on;

pause;
plot_PN_triangle(points, normals, 7);
grid on;
view(12,15);

pause;
plot_PN_triangle(points, normals, 31);
grid on;
view(12,15);

pause;
plot_PN_triangle(points, normals, inf);
grid off;
view(12,15);
print('figs/tri/bezier', '-dpng', '-r400')
grid on;

end

