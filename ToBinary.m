function img = ToBinary(image)
    img = image(:,:,3);
%     min_num = min(img(:));
%     if min_num < 139
%         min_num = 139;    
%     end
%     index = img>min_num;
    index = img>181;
    img(index) = 0;
    img(logical(1-index)) = 1;

end