function E = DeltaE(X, M)
E = 0;
x = X(1);
y = X(2);
N = size(M, 1);
if y < N
    E = E + M(x,y)*M(x,y+1);
end
if y > 1
    E = E + M(x,y)*M(x,y-1);
end
if x < N
    E = E + M(x,y)*M(x+1,y);
end
if x > 1
    E = E + M(x,y)*M(x-1,y);
end
end
