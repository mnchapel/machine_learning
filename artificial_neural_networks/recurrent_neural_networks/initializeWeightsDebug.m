function W = initializeWeightsDebug(size_out, size_in)
  
  W = zeros(size_out, size_in);
  
  % Initialize with the sin function for debug
  W = reshape(sin(1:numel(W)), size(W)) / 10;
  
end