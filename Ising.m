%% Definitioner

% Antal noder (måste vara en kvadrat).
n = 2500;
% Coupling-parametern
J = 1;

%% Isingmodellen (instansiering)

% Sidlängd på matrisen
N = sqrt(n);
% Matrisen som huserar noderna
A = zeros(N,N);
% Hamiltonianen
H = 0;

% Gör bakgrunden vit
fill([1 N+1 N+1 1],[1 1 N+1 N+1],'w')
axis([0 N 0 N])
hold on

% Ritar linjerna på grafen
for k=1:N+1
    plot([0 N+1],[k k], 'color', 'black')
    plot([k k],[0 N+1],'color', 'black')
end

% Instantiera slumpmässig matris
% Röd färg: 1
% Blå färg: -1
% "Vit färg: 0"

for x=0:N-1
    for y=0:N-1
        rnd = unidrnd(2,1,1);
        if rnd == 1
            A(x+1,y+1) = 1;
            fill([x x+1 x+1 x],[y y y+1 y+1],'r')
        end
        if rnd == 2
            A(x+1,y+1) = -1;
            fill([x x+1 x+1 x],[y y y+1 y+1],'b')
        end
    end
end

% Beräkna Hamiltonianen
for x=1:N
    for y=1:N
        % Här sker operation för varje nod
        if y < N
            H = H + J*A(x,y)*A(x,y+1);
        end
        if y > 1
            H = H + J*A(x,y)*A(x,y-1);
        end
        if x < N
            H = H + J*A(x,y)*A(x+1,y);
        end
        if x > 1
            H = H + J*A(x,y)*A(x-1,y);
        end
    end
end

%% Monte Carlo simulering

