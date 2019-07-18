function predict = TestFile(image)
    load code_table.mat
    Read_CNN_para;
    length(image(1,:,1));
    if length(image(1,:,1))==88
        l=4;
    else 
        l=6;
    end
   
%     predict=cell(1,l);
    for i=1:l
        switch i
        case 1
            Image = image(:,7:24,:);
        case 2
            Image = image(:,25:42,:);
        case 3
            Image = image(:,43:60,:);
        case 4
            Image = image(:,64:81,:);
        case 5
            Image = image(:,82:99,:);
        case 6
            Image = image(:,100:117,:);
        end
        
        img=ToBinary(RemoveNoise(Image));
    
        predict(i) = code_table{CNN_ForwardFeed(img)};
    end
end


