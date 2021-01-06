function b = bezier3(Bx,By,Bz,U)
% Opis:
%  bezier3 izracuna tocke na trikotni Bezierjevi ploskvi
%
% Definicija:
%  b = bezier3(Bx,By,Bz,U)
%
% Vhodni podatki:
%  Bx, By, Bz   matrike velikosti n+1 x n+1, ki dolocajo
%               koordinate kontrolnih tock ploskve
%               (element posamezne matrike na mestu (i,j),
%               j <= n+2-i, doloca koordinato kontrolne
%               tocke z indeksom (n+2-i-j, j-1, i-1)),
%  U            matrika, v kateri vrstice predstavljajo
%               baricentricne koordinate tock glede na
%               domenski trikotnik, za katere racunamo
%               tocke na Bezierjevi ploskvi
%
% Izhodni podatek:
%  b            matrika, v kateri vsaka vrstica predstavlja
%               tocko na Bezierjevi ploskvi pri istoleznih
%               parametrih iz matrike U

[n, ~] = size(U);
b = nan(n, 3);

for i = 1:n
    b(i, 1) = blossom3_simple(Bx, U(i, :));
    b(i, 2) = blossom3_simple(By, U(i, :));
    b(i, 3) = blossom3_simple(Bz, U(i, :));
end

end
