%% Definitioner

% Antal noder (måste vara en kvadrat).
n = 100;
% Sidlängd på matrisen
N = sqrt(n);
% Matrisen som huserar noderna
A = zeros(N,N);
% Hamiltonianen
H = 0;
% Coupling-parametern
J = 1;

%% Isingmodellen (instansiering)

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
% Vit färg: 0

for i=0:N-1
    for j=0:N-1
        rnd = unidrnd(2,1,1);
        if rnd == 1
            A(i+1,j+1) = 1; 
            fill([i i+1 i+1 i],[j j j+1 j+1],'r')
        end
        if rnd == 2
            A(i+1,j+1) = -1;
            fill([i i+1 i+1 i],[j j j+1 j+1],'b')
        end
    end
end

% Beräkna Hamiltonianen
for i=0:N-1
    for j=1:0-1
        H += 
    end
end

%% Monte Carlo simulering