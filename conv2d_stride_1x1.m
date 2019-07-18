function res = conv2d_stride_1x1(image,filter)
% padding = same
[row,column] = size(image);
[filter_h,filter_w] = size(filter);
res = zeros(row,column);
% image_expand = zeros(row+2,column+2);
image_expand = zeros(row+filter_h-1,column+filter_w-1);
image_expand(filter_h-1:end-floor(filter_h/2),filter_w-1:end-floor(filter_w/2)) = image;
% tmp = ones(9,9);
for row_index = 1:row
    for column_index = 1:column
         tmp =  image_expand(row_index:row_index+filter_h-1,column_index:column_index+filter_w-1).*filter;
         res(row_index,column_index) = sum(tmp(:));
    end
end

