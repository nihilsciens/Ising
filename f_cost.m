function C = f_cost(A, Y)

    

    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Return quadratic cost %
    %%%%%%%%%%%%%%%%%%%%%%%%%
    C = 0.5 * sum( (A - Y).^2 );

end

