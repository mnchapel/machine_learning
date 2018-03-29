function [J grad] = costFunction(X, Y, ...
                                 nn_weights_initial, ...
                                 input_layer_size, ...
                                 hidden_layer_size, ...
                                 output_layer_size)
  
  m = size(X,2); % the number of sentences
  J = 0;
  N = 0;
  
  for i=1:m % for each sentence
  
    % Feedforward
    [a2, a3] = feedforward(X{i}, nn_weights_initial, ...
                           input_layer_size, ...
                           hidden_layer_size, ...
                           output_layer_size);
    
    if iscell(Y{i})
      Y_sent = cell2mat(Y{i});
    else
      Y_sent = Y{i};
    endif
    
    correct_word_predictions = zeros(numel(Y_sent),1);
    for j=1:numel(Y_sent)
      correct_word_predictions(j) = a3(Y_sent(j), j);
      N += 1;
    endfor
    
    % Compute the cost
    J += sum(log(correct_word_predictions));
    
    % Backpropagation
    
    if iscell(X{i})
      X_sent = cell2mat(X{i});
    else
      X_sent = X{i};
    endif
    
    grad = bptt(X_sent, Y_sent, ...
                a3, a2, ...
                nn_weights_initial, ...
                input_layer_size, ...
                hidden_layer_size, ...
                output_layer_size);
    
  endfor
  
  J *= -1/N;
  
end