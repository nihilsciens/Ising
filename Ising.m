%% Definitioner

% Antal noder (måste vara en kvadrat).
n = 100;
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
        H = H + J*DeltaE([x,y], A);
    end
end

%% Monte Carlo simulering

% Antal itereringar
I = 10000;
% Position för grannar
Z = [1 -1 0 0; 0 0 1 -1];

% Utför I antal iterationer
for i=1:I
    % Nollställ energiförändring
    dE = 0;
    % Generera slumpmässig koordinat
    C = unidrnd(N,2,1);
    % Ändra på noden
    A(C(1), C(2)) = 1 - A(C(1), C(2));
    % Avgör om förändringen i energi är mindre än 0
    dE = J*DeltaE(C, A);
    for j=1:4
        X = Z(:,j) + C;
        if min(X) > 0 && max(X) < N+1
            dE = dE + J*DeltaE(Z(:,j)+C, A);
        end
    end
    % Inte mindre än 0
    if dE > 0
        % Ändra tillbaka
        A(C(1), C(2)) = 1 - A(C(1), C(2));
    end
    % Mindre än 0
    if dE < 0
        % Förändra Hamiltonianen
        H = H + dE;
        % Måla om noden
        C = C - 1;
        if A(C(1)+1, C(2)+1) == 1
            fill([C(1) C(1)+1 C(1)+1 C(1)],[C(2) C(2) C(2)+1 C(2)+1],'r')
        else
            fill([C(1) C(1)+1 C(1)+1 C(1)],[C(2) C(2) C(2)+1 C(2)+1],'b')
        end
    end
end
