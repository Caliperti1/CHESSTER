function grey = greyScale(im)
% Normalizes an image (0 - white, 1 - black)
    grey = (0.2989 * double(im(:,:,1)) + 0.5870 * double(im(:,:,2)) + 0.1140 * double(im(:,:,3)))/255;
end

