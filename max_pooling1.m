function res = max_pooling1(input)
% 保持原大小，即padding=same
% 此处只写针对本任务的3*3池化，步长为2*2
[row,column] = size(input);
% ksize_h = ksize(1);
% ksize_w = ksize(2);


%%  前后上下都补零的方法
% input_expand = zeros(row+ksize_h-1,column+ksize_w-1);
% tmp = zeros(row+ksize_h-1,column+ksize_w-1);
% input_expand(ksize_h-1:end-floor(ksize_h/2),ksize_w-1:end-floor(ksize_w/2)) = input;
% 
% tic
% for row_index = ksize_h-1:stride_h:row
%     for column_index = ksize_w-1:stride_w:column
%         tmp(row_index,column_index) = max(max(input_expand(row_index-1:row_index+1,column_index-1:column_index+1)));
%     end
% end
% res = tmp(ksize_h-1:stride_h:row, ksize_w-1:stride_w:column);
% toc
        
%% 单后面和下面补零

input_expand = zeros(row+1,column+1);
tmp = zeros(row+1,column+1);
input_expand(1:row,1:column) = input;
for row_index = 2:2:row
    for column_index =2:2:column
        tmp(row_index,column_index) = max(max(input_expand(row_index-1:row_index+1,column_index-1:column_index+1)));
    end
end
res = tmp(2:2:row, 2:2:column);
