function b = blossom3_simple(B,U)

[n, ~] = size(B);
n = n-1;

for r = 0:n-1
    for depth = 1:(n-r)
        for k = 1:depth
            B(depth-k+1, k) = ...
                U(1) * B(depth-k+1, k) + ...
                U(2) * B(depth-k+1, k+1) + ...
                U(3) * B(depth-k+2, k);
        end
    end
end

b = B(1, 1);

end