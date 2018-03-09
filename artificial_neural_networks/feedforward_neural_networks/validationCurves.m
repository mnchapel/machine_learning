function [lambda_vec, err_train, err_cv] = validationCurves(X, y, X_cv, y_cv, ...
                                                            nn_weights_initial, ...
                                                            input_layer_size, ...
                                                            hidden_layer_size, ...
                                                            output_layer_size)
  
  lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10];
  options = optimset('MaxIter', 50);
  
  err_train = zeros(length(lambda_vec), 1);
  err_cv    = zeros(length(lambda_vec), 1);

  % Test different models
  for i=1:length(lambda_vec)
    lambda = lambda_vec(i);
    costFunc = @(p) costFunction(X, y, lambda, p, ...
                                 input_layer_size, ...
                                 hidden_layer_size, ...
                                 output_layer_size);

    [nn_weights, cost] = fmincg(costFunc, nn_weights_initial, options);
    
    % Compute error on the training set
    err_train(i) =  costFunction(X, y, 0, nn_weights, ...
                                 input_layer_size, ...
                                 hidden_layer_size, ...
                                 output_layer_size);
    
    % Compute error on the cross-validation set
    err_cv(i) = costFunction(X_cv, y_cv, 0, nn_weights, ...
                             input_layer_size, ...
                             hidden_layer_size, ...
                             output_layer_size);
  endfor
  
end