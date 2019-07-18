function res = max_pooling2(input)
% 保持原大小，即padding=same
% 池化层2 核大小3*3 步长1
% 此时前后各添一行，上下各添一行
[row,column] = size(input);
% input_expand = zeros(row+2,column+2);
% tmp = zeros(row+2,column+2);
% input_expand(1:row,1:column) = input;
% for row_index = 2:1:row
%     for column_index =2:1:column
%         tmp(row_index,column_index) = max(max(input_expand(row_index-1:row_index+1,column_index-1:column_index+1)));
%     end
% end
% res = tmp(2:1:row, 2:1:column);

input_expand = zeros(row+2,column+2);
tmp = zeros(row+2,column+2);
input_expand(2:end-1,2:end-1) = input;

tic
for row_index = 2:1:row+1
    for column_index = 2:1:column+1
        tmp(row_index,column_index) = max(max(input_expand(row_index-1:row_index+1,column_index-1:column_index+1)));
    end
end
res = tmp(2:1:row+1, 2:1:column+1);
