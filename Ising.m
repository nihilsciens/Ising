%% Initialization

T = linspace(1,10,1000);

J  = 1;
numSpinsPerDim = 100;
probSpinUp = 0.5;
spin = sign(probSpinUp - rand(numSpinsPerDim, numSpinsPerDim));
kT = 10;
%% test
%% Metropolis algorithm
i = 0;
numIters = 10^10 * numel(spin);
for iter = 1 : numIters
    % Pick a random spin
    linearIndex = randi(numel(spin));
    [row, col]  = ind2sub(size(spin), linearIndex);
    
    % Find its nearest neighbors
    above = mod(row - 1 - 1, size(spin,1)) + 1;
    below = mod(row + 1 - 1, size(spin,1)) + 1;
    left  = mod(col - 1 - 1, size(spin,2)) + 1;
    right = mod(col + 1 - 1, size(spin,2)) + 1;
    
    neighbors = [      spin(above,col);
        spin(row,left);                spin(row,right);
                       spin(below,col)];
    
    % Calculate energy change if this spin is flipped
    dE = 2 * J * spin(row, col) * sum(neighbors);
    
    % Boltzmann probability of flipping
    prob = exp(-dE / kT);
    
    % Spin flip condition
    if dE <= 0 || rand() <= prob
        spin(row, col) = - spin(row, col);
    end
    % hej
    % DRAW
    if(mod(iter, 100) == 0)
        imagesc(spin)
        drawnow limitrate
    end
    
    % CHANGE TEMP
    if(mod(iter, 10^5) == 0)
        i = i + 1;
        kT = T(i)
    end
    
    
end

% The mean energy
sumOfNeighbors = ...
      circshift(spin, [ 0  1]) ...
    + circshift(spin, [ 0 -1]) ...
    + circshift(spin, [ 1  0]) ...
    + circshift(spin, [-1  0]);
Em = - J * spin .* sumOfNeighbors;
E  = 0.5 * sum(Em(:));
Emean = E / numel(spin);

% The mean magnetization
Mmean = mean(spin(:));
