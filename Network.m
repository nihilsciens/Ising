%% Graph setup

%{
    Det är viktigt att notera att W{l} och B{l} förhåller sig till
    A{x} och Z{x} som x = l + 1. W och B börjar alltså ett steg efter
    i grafen och inte på allra första lagret. Det är därför synligt
    i backward algoritmen nedan att de förhåller sig på så vis.
%}

%%%%%%%%%%%%%%%%%%
% Personal input %
%%%%%%%%%%%%%%%%%%
% Graph
G = [1 1 1;
     0 1 1];

%%%%%%%%%%%%%%%%
% Construction %
%%%%%%%%%%%%%%%%
% Layers
L = size(G,2);
% Weights (L-1 number of weight matrices)
W = cell(L-1,1);
for i=1:L-1
    W{i} = 2*rand(sum(G(:,i+1)), sum(G(:,i)))-1;
end
% Biases (L-1 number of bias vectors)
B = cell(L-1,1);
for i=1:L-1
    B{i} = 2*rand(sum(G(:,i+1)),1)-1;
end

%% Backpropagation algorithm

%%%%%%%%%%%%%%%%%%
% Personal input %
%%%%%%%%%%%%%%%%%%
% Iterations
iter = 10^7;
% Taking averages
per = 10^2;
% Step length
h = 5;

%%%%%%%%%%%%%%%%%%%
% Initializations %
%%%%%%%%%%%%%%%%%%%
% Generate random values
in = randi(3,iter,1)-2;
%in = ones(iter,1);
% Associated correct answer
EXP = zeros(sum(G(:,L),1),iter);
% Calculate correct answers
for i=1:iter
    EXP(:,i) = [0;1];
    if in(i) == 0
        EXP(:,i) = [1;0];
    end
end
% Layer error
dl = cell(L,1);
% Cost function
C = zeros(iter,1);
% Bias average differential
DB = cell(L-1,1);
for i=1:L-1
    DB{i} = zeros(sum(G(:,i+1)),1);
end
% Weight average differential
DW = cell(L-1,1);
for i=1:L-1
    DW{i} = zeros(sum(G(:,i+1)), sum(G(:,i)));
end

%%%%%%%%%%%%%%%%%
% Prepare graph %
%%%%%%%%%%%%%%%%%
clf
hold on

%%%%%%%%%%%%%%%%%
% The algorithm %
%%%%%%%%%%%%%%%%%
% Do iterations
for x=1:iter
   
    %%%%%%%%%%%%%%%%%%%%%%
    % Iteration specific %
    %%%%%%%%%%%%%%%%%%%%%%
    % Gather input and correct output
    I = in(x);
    Y = EXP(:,x);
    % Retrieve activations
    A = f_activations(I, W, B);
    % Retrieve weighted inputs
    Z = f_weightedInput(I, W, B);
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % Initial calculations %
    %%%%%%%%%%%%%%%%%%%%%%%%
    % Gradient of cost function
    DC = f_costGrad(A{L}, Y);
    % Sigmoid prime of weighted inputs
    Sp = f_sigmoidPrime(Z{L});
    % Calculate error of layer L
    dl{L} = DC.*Sp;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate remaining layer errors %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Do calculation backwards
    for l=L-1:-1:1
        % Calculate intermediary gradient
        DC = transpose(W{l})*dl{l+1};
        % Sigmoid prime of weighted inputs
        Sp = f_sigmoidPrime(Z{l});
        % Calculate error of layer l
        dl{l} = DC.*Sp;
        % Add to average differentials
        DB{l} = DB{l} + dl{l+1};
        DW{l} = DW{l} + dl{l+1}*transpose(A{l});
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Increment weights and biases %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check if time to take average
    if mod(x,per) == 0
        % Do for each layer
        for l=1:L-1
            % Calculate new biases
            B{l} = B{l} - h * DB{l} / per;
            % Calculate new weights 
            W{l} = W{l} - h * DW{l} / per;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Nullify average differentials %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Nullify bias differentials
        DB = cell(L-1,1);
        for i=1:L-1
            DB{i} = zeros(sum(G(:,i+1)),1);
        end
        % Nullify weight differentials
        DW = cell(L-1,1);
        for i=1:L-1
            DW{i} = zeros(sum(G(:,i+1)), sum(G(:,i)));
        end
        
        %%%%%%%%%%%%%%%%%
        % Cost function %
        %%%%%%%%%%%%%%%%%
        % Calculate cost function
        C(x/per) = f_cost(A{L}, Y);

        %%%%%%%%%%%%%%%%%%%%%%%
        % Continuous plotting %
        %%%%%%%%%%%%%%%%%%%%%%%
        % Add next point on graph
        scatter(x/per,C(x/per))
        drawnow limitrate
        axis([0 x/per 0 1])
        
    end
end

scatter(1:x/per,C(1:x/per))
axis([0 x/per 0 max(C)])
