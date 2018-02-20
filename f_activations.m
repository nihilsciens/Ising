function A = f_activations(I, W, B)

    %%%%%%%%%%%%%%%%%%%
    % Input variables %
    %%%%%%%%%%%%%%%%%%%
    % I: Input (matrix)
    % W: Weights (cell)
    % B: Biases (cell)

    %%%%%%%%%%%%%%%%%%%
    % Initializations %
    %%%%%%%%%%%%%%%%%%%
    % Amount of layers
    L = size(W,1)+1;
    % Weighted input
    Z = cell(L,1);
    % Activations
    A = cell(L,1);
    % Initial values
    a = zeros(size(I,1),1);
    for i=1:size(I,1)
        a(i) = I(i);
    end
    Z{1} = a;
    A{1} = a;

    %%%%%%%%%%%%%%%%%%%%%%
    % Forwardpropagation %
    %%%%%%%%%%%%%%%%%%%%%%
    for l=1:L-1
        % Calculate weighted input
        Z{l+1} = W{l}*A{l} + B{l};
        % Calculate activation
        A{l+1} = f_sigmoid(Z{l+1});
    end
    
    %Soft-max istället:
    A{L} = exp(Z{L})/sum(exp(Z{L}));

end

