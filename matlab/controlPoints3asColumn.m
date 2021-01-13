function b = controlPoints3asColumn(B)

[n, ~] = size(B);
b = nan(n * (n+1) / 2, 1);
acc = 1;
for i = 1:n
    b(acc:acc+n-i) = B(i, 1:n-i+1);
    acc = acc + n - i + 1;
end
end

