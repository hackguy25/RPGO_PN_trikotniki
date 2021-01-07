function [points_out, normals_out, tris_out] = ...
    pn_subdivide(points_in, normals_in, tris_in, lod)
% pn_subdivide
% Z metodo PN trikotnikov izvede subdivizijo triangulacije
% indeksi trikotnikov morajo biti urejeni!

[n_pts_in, ~] = size(points_in);
[n_tris_in, ~] = size(tris_in);
tri_in = triangulation(tris_in, points_in);

edges_in = edges(tri_in);
[n_edges_in, ~] = size(edges_in);

n_pts_edges = lod * n_edges_in;
n_inner_pts = (lod-1) * lod / 2;
n_pts_faces = n_tris_in * n_inner_pts;
n_pts_out = n_pts_in + n_pts_edges + n_pts_faces;
n_subtriangles = (lod + 1) .^ 2;


points_out = nan(n_pts_out, 3);
normals_out = nan(n_pts_out, 3);
tris_out = nan(n_tris_in * n_subtriangles, 3);


% kopiraj obstojeèe toèke, normale
for i = 1:n_pts_in
    points_out(i, :) = points_in(i, :);
    normals_out(i, :) = normals_in(i, :);
end


% pomožne vrednosti
E12 = 1:(lod+1);
E23 = (lod+3) * E12 - E12 .* (E12 + 1) / 2;
E13 = E23(1:end-1) + 1;
E23 = E23(2:end);
E12 = 2:(lod+1);

[~, U] = trimeshgrid(lod + 1);
outers = [E12 E13 E23 1 lod+2 (lod+2)*(lod+3)/2];
inners = 1:((lod+2)*(lod+3)/2);
inners(outers) = [];

Es = edges_in(:, 1) * n_pts_in + edges_in(:, 2);

macro_triangle = 1:((lod+2)*(lod+3)/2);
idx_matrix = [1 E13 (lod+2)*(lod+3)/2]' * ones(1, lod+2) + ...
    ones(lod+2, 1) * (0:lod+1);


% izvedi subdivizijo na vsakem trikotniku
if lod > 0
    for i = 1:n_tris_in
        triangle = tris_in(i, :);
        macro_triangle([1 lod+2 (lod+2)*(lod+3)/2]) = triangle;

        % izraèunaj koeficiente Bézierjeve krpe
        [Bx, By, Bz, Nx, Ny, Nz] = pn_to_bezier( ...
            points_in(triangle, :), normals_in(triangle, :));

        % izraèunaj vrednosti v iskanih toèkah
        B = bezier3(Bx,By,Bz,U);
        N = bezier3(Nx,Ny,Nz,U);

        % najdi indeks prvega roba (med 1. in 2. toèko trikotnika)
        if (triangle(1) < triangle(2))
            E = binarySearch(Es, triangle(1) * n_pts_in + triangle(2));
            base_e12_pt_idx = n_pts_in + (E-1) * lod + (1:lod);
        else
            E = binarySearch(Es, triangle(2) * n_pts_in + triangle(1));
            base_e12_pt_idx = n_pts_in + (E-1) * lod + (lod:-1:1);
        end
        
        % shrani vrednosti na prvem robu - E12
        points_out(base_e12_pt_idx, :) = B(E12, :);
        normals_out(base_e12_pt_idx, :) = N(E12, :);
        macro_triangle(E12) = base_e12_pt_idx;

        % najdi indeks drugega roba (med 1. in 3. toèko trikotnika)
        if (triangle(1) < triangle(3))
            E = binarySearch(Es, triangle(1) * n_pts_in + triangle(3));
            base_e13_pt_idx = n_pts_in + (E-1) * lod + (1:lod);
        else
            E = binarySearch(Es, triangle(3) * n_pts_in + triangle(1));
            base_e13_pt_idx = n_pts_in + (E-1) * lod + (lod:-1:1);
        end

        % shrani vrednosti na drugem robu - E13
        points_out(base_e13_pt_idx, :) = B(E13, :);
        normals_out(base_e13_pt_idx, :) = N(E13, :);
        macro_triangle(E13) = base_e13_pt_idx;

        % najdi indeks tretjega roba (med 2. in 3. toèko trikotnika)
        if (triangle(2) < triangle(3))
            E = binarySearch(Es, triangle(2) * n_pts_in + triangle(3));
            base_e23_pt_idx = n_pts_in + (E-1) * lod + (1:lod);
        else
            E = binarySearch(Es, triangle(3) * n_pts_in + triangle(2));
            base_e23_pt_idx = n_pts_in + (E-1) * lod + (lod:-1:1);
        end

        % shrani vrednosti na drugem robu - E13
        points_out(base_e23_pt_idx, :) = B(E23, :);
        normals_out(base_e23_pt_idx, :) = N(E23, :);
        macro_triangle(E23) = base_e23_pt_idx;
        
        if lod > 1
            % shrani vrednosti v notranjosti
            B(outers, :) = [];
            N(outers, :) = [];
            base_inner_pt_idx = n_pts_in + n_pts_edges + (i-1) * n_inner_pts;
            points_out((1:n_inner_pts) + base_inner_pt_idx, :) = B;
            normals_out((1:n_inner_pts) + base_inner_pt_idx, :) = N;
            macro_triangle(inners) = (1:n_inner_pts) + base_inner_pt_idx;
        end

        % shrani trikotnike
        tris_idx = (i-1) * n_subtriangles + 1;
        for j = 1:lod+1
            for k = 1:lod+1-j
                tris_out(tris_idx, :) = macro_triangle(...
                    [idx_matrix(j, k) idx_matrix(j, k+1) idx_matrix(j+1, k)]);
                tris_out(tris_idx + 1, :) = macro_triangle(...
                    [idx_matrix(j+1, k) idx_matrix(j, k+1) idx_matrix(j+1, k+1)]);
                tris_idx = tris_idx + 2;
            end
            tris_out(tris_idx, :) = macro_triangle(...
                [idx_matrix(j, lod-j+2) idx_matrix(j, lod+3-j) idx_matrix(j+1, lod+2-j)]);
            tris_idx = tris_idx + 1;
        end
    end
else
    % kopiraj obstojeèe trikotnike
    tris_out = tris_in;
end

end

