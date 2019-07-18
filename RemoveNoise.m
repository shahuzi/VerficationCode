function image = RemoveNoise(image)
image(1,:,:) = image(2,:,:);
image(28,:,:) = image(27,:,:);
template=[240,248,255];
    for i=1:3
        for j =1:18
            for k = 1:28
                if 210<image(k,j,i) && image(k,j,i)<220
                    image(k,j,i) = template(i);
                end
            end
        end
    end
end