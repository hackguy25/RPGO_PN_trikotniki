function N = normalize(P)

[n, k] = size(P);
N = nan(n, k);
for i = 1:n
    N(i, :) = P(i, :)/norm(P(i, :));
end

end

