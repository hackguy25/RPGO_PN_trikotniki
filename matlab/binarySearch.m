function n = binarySearch(A, x)

N = length(A);
n = round((N + 1) / 2);
delta = floor((length(A) + 1) / 4);

while delta > 1
    if A(n) > x
        n = n - delta;
        delta = floor(delta / 2);
    elseif A(n) < x
        n = n + delta;
        delta = floor(delta / 2);
    else
        return
    end
end

if A(n) > x
    while A(n) > x
        n = n - 1;
        if n < 1
            error("x not in A!");
        end
    end
    if A(n) == x
        return
    else
        error("x not in A!");
    end
elseif A(n) < x
    while A(n) < x
        n = n + 1;
        if n > N
            disp([x A(n) A(n+1)])
            error("x not in A!");
        end
    end
    if A(n) == x
        return
    else
        disp([x A(n-1) A(n)])
        error("x not in A!");
    end 
else
    return
end 

end

