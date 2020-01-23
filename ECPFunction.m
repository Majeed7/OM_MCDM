function [EPC] = ECPFunction(matrix,weights,criteria_type)

%%% Norm 2 normalization
normalized_matrix = matrix ./ (sum(matrix.^2).^.5); 
normalized_matrix(:,find(criteria_type == -1)) = 1 - normalized_matrix(:,find(criteria_type == -1));
%%% Norm infinity normalization
%normalized_matrix = matrix ./ max(matrix); 
%normalized_matrix(:,find(criteria_type == -1)) = 1 - normalized_matrix(:,find(criteria_type == -1));


%%% simple weighted averaging
%EPC = sum(normalized_matrix*diag(weights),2);

%%% harmonic mean
EPC = sum((weights) ./ sum(weights ./ normalized_matrix),2);

end