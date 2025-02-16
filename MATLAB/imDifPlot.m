function [] = imDifPlot(orig, moved)
% Generates 2 figures  1. raw images of moves with moved piece isolated and displayed  2. isolated images of piece before and after move

orig = imread(orig);
move = imread(moved);
diffnew = move - orig;
diffold = orig - move;

diffcombo = diffold + diffnew;

sobdiff = sobelMask(diffnew, 0.9);

sobdiffcombo = sobelMask(diffcombo, 0.9);

figure(1)
subplot(2,2,1)
image(orig)
title('original image')

subplot(2,2,2)
image(move)
title('moved image')

subplot(2,2,3)
image(diffnew)
title('Difference')

subplot(2,2,4)
image(sobdiff)
title('SobleMask of differnec (thresh = 0.99')


figure(2)
subplot(2,2,1)
image(diffnew)
title('After Move')
subplot(2,2,2)
image(diffold)
title('Before Move')
subplot(2,2,3)
image(diffcombo)
title('Total Differnece')
subplot(2,2,4)
image(sobdiffcombo)
title('Sobel Mask tol = 0.9')


end

% Generates 2 figures  1. raw images of moves with moved piece isolated and displayed  2. isolated images of piece before and after move