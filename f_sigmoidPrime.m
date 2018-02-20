function Y = f_sigmoidPrime(X)

    %%%%%%%%%%%%%%%%
    % Calculations %
    %%%%%%%%%%%%%%%%
    Y = f_sigmoid(X).*(1-f_sigmoid(X));

end