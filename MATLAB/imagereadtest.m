%% Image Processing Workbook
clc
clear 
close all 

%% Set path 
 
path = 'C: / out';
filelist = dir;

%% Test Sobel Mask 
% generate 12 images of sobel maskl at diferent thresholds 

im = imread('Demo Blank.BMP');

threshs = [.1, .2, .3, .4, .5, .6, .7, .8, .9, .95, .99, .99999];

sz = size(im);

sob = zeros(sz(1), sz(2),length(threshs));

for i = 1:length(threshs)
    sob(:,:,i) = sobelMask(im, threshs(i));
    
    figure(7)
    subplot(length(threshs)/4,length(threshs)/(length(threshs)/4),i)
    image(sob(:,:,i))
    title("Sobel Mask (threshhold = " + threshs(i) + ")")
    
end 

%% Test difference between 2 images 

orig = imread('7.BMP');
move = imread('10.BMP');
diffnew = move - orig;
diffold = orig - move;

diffcombo = diffold + diffnew;

sobdiff = sobelMask(diffnew, 0.9);

sobdiffcombo = sobelMask(diffcombo, 0.9);

figure(8)
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


figure(11)
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

%% Test boardBounds and sqaureOff function 
im = imread('Demo Blank.BMP');

sobim = sobelMask(im, 0.9999);

bound = boardBounds(im)

board = squareOff(im);

sobSQ = sobelMask(board, .3)

figure(9)
subplot(3,1,1)
image(im)
subplot(3,1,2)
image(sobim)
subplot(3,1,3)
image(board)

%% Test sqaureBounds function
im = imread('Demo Blank.BMP');

bound = boardBounds(im)

board = squareOff(im);

sqBounds = sqaureBounds(board);

% Plot all 64 sqaure individually

k = 1;
for i = 1:8
    for j = 1:8
        sqaure = board([sqBounds(i,j,1):sqBounds(i,j,2)],[sqBounds(i,j,3):sqBounds(i,j,4)],:);
        figure(10)
        subplot(8,8,k)
        image(sqaure)
        
        k = k+1;
    end
end

%% Test find loc of move function 
orig = imread('7.BMP');
move = imread('10.BMP');
blank = imread('Demo Blank.BMP');

coord = moveLoc(blank, orig, move);

move = findMove(blank, orig, move)

%% Show Off 
orig = imread('7.BMP');
moved = imread('10.BMP');
blank = imread('Demo Blank.BMP');

move = findMove(blank, orig, moved);

origchess = mapToChess(move(1,1),move(1,2));
movedchess = mapToChess(move(2,1),move(2,2));

figure(12)
subplot(1,2,1)
image(orig)
title({"Pre Move", "Piece located at " + origchess,  "Confidence :  " + move(1,3)})
subplot(1,2,2)
image(moved)
title({"Post Move", "Piece located at " + movedchess,  "Confidence :  " + move(2,3)})

% Test game update 

game0 = startGame('color')
game1 = updateGame(game,move)

figure(14)
subplot(1,2,1)
displayBoard(game0)
subplot(1,2,2)
displayBoard(game1)


%% Test Show off func 
orig = imread('7.BMP');
moved = imread('10.BMP');
blank = imread('Demo Blank.BMP');

gameOrig = startGame();


showOff(blank, orig, moved,gameOrig)


%% Exeriment 
close all
game = startGame()

figure(15)
displayBoard(game)
%% Utility Functions 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Normalize an image (0 - white, 1 - black)
function grey = greyScale(im)
    grey = (0.2989 * double(im(:,:,1)) + 0.5870 * double(im(:,:,2)) + 0.1140 * double(im(:,:,3)))/255;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3D BW filter 
function BW = BW(rgb)
    BW = zeros(size(rgb));
    
    thresh = mean(mean(rgb));
    
    BW(rgb > thresh) = 255;
    BW(rgb < thresh)  = 0;
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Square off image and isolate Board based on camera rig setup
function SQ = squareOffRig(BW)

    % Define dimansions of board in image 
        % Can eventually mke this find edges or calculate based off camera
        % height. For now assume rig is centered on board 

    top = 75; 
    bot = 290;
    left = 20;
    right = 230;

    
    SQ = zeros(bot-top,right-left,3);
    
    % Isolate board from entire picture 
    SQ = BW([top:bot],[left:right],:);
    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sobel Mask - Finds edges and genertes an edge map image 
function sob = sobelMask(im, thresh)

    %use greyScale function to normalzie values between 0 and 1
    gs = greyScale(im);
    
    % define Mask (3x3 matrix that will be used for convolution)
    maskX = [1 2 1; 0 0 0; -1 -2 -1];
    maskY = maskX';
    
    % Perform convolution of mask over image in X and Y 
    % 'same' parameter returns only center convolution matrix that is same
    % size as im
    H = conv2(double(gs), maskX, 'same');
    V = conv2(double(gs), maskY, 'same');
    
    % Find magnitude of convolutions
    E = sqrt(H.*H + V.*V);
    
    sob = uint8((E > thresh) * 255);
    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ID edges of the board 
    % Start at middle of sboel masked image and find coordinate of first
    % edge in each direction. trim matrix to be square with n-1 off that
    % edge dimension.
    
    % Recommended Sobel threshold o .75 to .8 to ensure no mid edges
    % detected but maxmimum length of outer edges detected 
    
    % meant to be run on image on empty board

function bounds = boardBounds(im)
    
    % Apply sobel Mask at .75 tol 
    sob = sobelMask(im, .75);

    % ID starting point for search (middle of image)
    sz = size(sob)
    midrow = round(sz(1)/2);
    midcol = round(sz(2)/2);
    
    %initialize edge counters at 0 
    left = 0;
    right = 0;
    top = 0;
    bot = 0;
    
    %initialize moves at 0
    moveleft = 0;
    moveright = 0;
    moveup = 0;
    movedown = 0;
    
    %start at center and continue moving one sqaure to left until edge is
    %found
    while moveleft ~= 255 
        
        moveleft = sob(midrow,midcol - left);
        left = left+1;
    end 
    
    %start at center and continue moving one sqaure to right until edge is
    %found
    while moveright ~= 255 
        
        moveright = sob(midrow,midcol + right);
        right = right+1;
    end 
    
    %start at center and continue moving one sqaure up until edge is
    %found
    while moveup ~= 255 
        
        moveup = sob(midrow - top, midcol);
        top = top+1;
    end 

    
    %start at center and continue moving one sqaure down until edge is
    %found
    while movedown ~= 255 
        
        movedown = sob(midrow + bot, midcol);
        bot = bot+1;
    end 
    
    
    % Turn cooindates in single vector 
    left = midcol - left;
    right = midcol + right;
    top = midrow - top;
    bot = midrow + bot;
    
    bounds = [top, bot, left, right]
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Square off image and isolate Board based on calculated bounds 
function SQ = squareOff(im)

    bound = boardBounds(im);
    
    SQ = im([bound(1):bound(2)],[bound(3):bound(4)],:);

end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Square off image and isolate Board based on calculated bounds from a
% blank baord 
function SQ = squareOff2(blank,im)

    bound = boardBounds(blank);
    
    SQ = im([bound(1):bound(2)],[bound(3):bound(4)],:);

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create library of bounds for 64 squares 

function squareBounds = sqaureBounds(SQ)

    % Divide dimesnions by 8 to create incements 
    sz = size(SQ);
    LRincr = round(sz(2) / 8);
    UDincr = round(sz(1) / 8);
    
    % Create a vactor of left / right bounds 
    LRBounds = [1];
    for i = 1:8
        LRBounds(1+i) = LRBounds(i) + LRincr;
    end
    
    % Create a vactor of up / down bounds 
    UDBounds = [1];
    for i = 1:8
        UDBounds(1+i) = UDBounds(i) + UDincr;
    end
    
    %Create array that stores [top, bot, left, right] for each square array
    %should be 64x4

        sqaureBounds = zeros(8,8,4);
   for i = 1:8
       for j = 1:8
        squareBounds(i,j,1) = UDBounds(i);
        squareBounds(i,j,2) =  UDBounds(i +1);
        squareBounds(i,j,3) =  LRBounds(j);
        squareBounds(i,j,4) = LRBounds(j+1);
       end
   end
   
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create 64 different matricies for each sqaure 

% building of a 4D matrix that stores each individual sqaure
% but takes for ever to run and prbably isnt necessary 

function indi = indivSquares(SQ)

    sqBounds = sqaureBounds(SQ);
    
    xsize = round((sqBounds(2) - sqBounds(1))/8);
    ysize = round((sqBounds(4) - sqBounds(3))/8);
    
    indi = zeros(8,8, xsize, ysize);
    
    for i = 1:8
        for j = 1:8
            indi(i,j,:,:) = SQ([sqBounds(i,j,1):sqBounds(i,j,2)],[sqBounds(i,j,3):sqBounds(i,j,4)]);
        end
    end
end

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create 64 different matricies for each sqaure given square bounds

% This version is useful if you want to appl th edimensions from another
% image to this one

function indi = indivSquares2(im,sqBounds)

    xsize = round(sqBounds(2) - sqBounds(1));
    ysize = round(sqBounds(4) - sqBounds(3));
    
    indi = zeros(8,8, xsize, ysize);
    
    for i = 1:8
        for j = 1:8
            indi(i,j,:,:) = im([sqBounds(i,j,1):sqBounds(i,j,2)],[sqBounds(i,j,3):sqBounds(i,j,4)]);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Counts how many values above 0 exist in each sqaure on high tol sobel
% masked image of moved piece 

% find total of all values within bounds on sobel mask diff image 
% make 8x8 matrix of totals 

% uses the square dimesnions of one of the pics and applies it to
% difference since edges cant be found in dif image 

function coord_conf = moveLoc(blank,pic1, pic2)
    
    % Calculate difference between two pics 
    diff = pic1 - pic2;
    
    % Sobel Mask diff
    diffmask = sobelMask(diff,0.9);
    
    %Square off diff pic using blank baord bounds
    diffmaskSQ = squareOff2(blank,diffmask);

    % find sqbounds from blank board    
    blankSQ = squareOff(blank);
    sqBounds = sqaureBounds(blankSQ);
    
   % Search between bounds in sqBounds and add total to scores 
   
   % Should be 8x8
    sz = size(sqBounds);
    
    % Build empty matrix repersenting "scores" for each square
    scores = zeros(sz(1),sz(2));

    for i = 1:sz(1)
        for j = 1:sz(2)
            % for each "sqaure" in board find bounds from sq Bounds 
           tb = sqBounds(i,j,1);
           bb = sqBounds(i,j,2);
           lb = sqBounds(i,j,3);
           rb = sqBounds(i,j,4);

            % use bounds as limits to iterate through all pixels in that
            % "square"
            for k = tb:bb
                for p = lb:rb
                    if diffmaskSQ(k,p) > 0
                        scores(i,j) = scores(i,j) + 1;
                    end
                end
            end 
        end 
    end
    
    [max_score, max_inx] = max(scores(:));
    [X Y] = ind2sub(size(scores),max_inx);
    
    % calculate confidence 
    conf = max_score / sum(sum(scores));
    coord_conf = [X Y conf]
            
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % Take original image and new image and determine coordinat epiece left
 % and coordinate piece moved to 
 
 function move = findMove(blank, orig, new)
 
    % Find starting loc of piece 
    startmv = moveLoc(blank, orig, new);
    
    startsq = startmv;
    
    % Find ending loc of piece 
    endmv = moveLoc(blank, new, orig);
    
    endsq = endmv;
    
    move = [startsq;endsq];
 end 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Converts matrix coordinates to Chess locations 
 % Assumes top right is A1 
 
 function chessLoc = mapToChessPlot(x,y)
    
    dict = fliplr(flipud(["a8" "b8" "c8" "d8" "e8" "f8" "g8" "h8";
        "a7" "b7" "c7" "d7" "e7" "f7" "g7" "h7";
        "a6" "b6" "c6" "d6" "e6" "f6" "g6" "h6";
        "a5" "b5" "c5" "d5" "e5" "f5" "g5" "h5";
        "a4" "b4" "c4" "d4" "e4" "f4" "g4" "h4";
        "a3" "b3" "c3" "d3" "e3" "f3" "g3" "h3";
        "a2" "b2" "c2" "d2" "e2" "f2" "g2" "h2";
        "a1" "b1" "c1" "d1" "e1" "f1" "g1" "h1";]));

        
    chessLoc = dict(x,y);
    
 end
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Converts matrix coordinates to Chess locations 
 % Assumes top right is A1 
 
 function chessLoc = mapToChess(x,y)
    
    dict = ["a8" "b8" "c8" "d8" "e8" "f8" "g8" "h8";
        "a7" "b7" "c7" "d7" "e7" "f7" "g7" "h7";
        "a6" "b6" "c6" "d6" "e6" "f6" "g6" "h6";
        "a5" "b5" "c5" "d5" "e5" "f5" "g5" "h5";
        "a4" "b4" "c4" "d4" "e4" "f4" "g4" "h4";
        "a3" "b3" "c3" "d3" "e3" "f3" "g3" "h3";
        "a2" "b2" "c2" "d2" "e2" "f2" "g2" "h2";
        "a1" "b1" "c1" "d1" "e1" "f1" "g1" "h1";];

        
    chessLoc = dict(x,y);
    
 end
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Plot previous board, moved board and confidence 
 
 function showOffFig = showOff(blank, orig, moved, gameOrig)
 
 
move = findMove(blank, orig, moved);

origchess = mapToChess(move(1,1),move(1,2));
movedchess = mapToChess(move(2,1),move(2,2));

gameMoved = updateGame(gameOrig,move)

figure
subplot(2,2,1)
image(orig)
title({"Pre Move", "Piece located at " + origchess,  "Confidence :  " + move(1,3)})
subplot(2,2,2)
image(moved)
title({"Post Move", "Piece located at " + movedchess,  "Confidence :  " + move(2,3)})
subplot(2,2,3)
displayBoard(gameOrig)
subplot(2,2,4)
displayBoard(gameMoved)
 end 
 

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % Start a game by establishing a Game matrix containing the names of
 % pieces 
 % ****** REPLACE WITH INSTANCES OF OBJECTS LATER ********

 function game = startGame()
    
    colors = ["B" "B" "B" "B" "B" "B" "B" "B";
        "B" "B" "B" "B" "B" "B" "B" "B";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "W" "W" "W" "W" "W" "W" "W" "W";
        "W" "W" "W" "W" "W" "W" "W" "W"];
        
    pieces = flipud(["R" "N" "B" "Q" "K" "B" "N" "R";
        "P" "P" "P" "P" "P" "P" "P" "P";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "P" "P" "P" "P" "P" "P" "P" "P";
        "R" "N" "B" "Q" "K" "B" "N" "R"]);
        
%     if opt == 'color'
%         game = gameBoardColors; 
%     elseif opt == 'no color'
%         game = gameBoard;
%     else 
%         game = 'opt must = color or no color'
%     end 

    game = strings(8,8,2);
    game(:,:,1) = pieces;
    game(:,:,2) = colors;
    
    
    
 end 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Make blank Board 
 
 function cb = checkerBoard(game)
 
    wb = ones(8,8,3);
    
    bb =  zeros(8,8,3);
    
    cb = [bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;
        bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;
        bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;
        bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;];
    
 end
 
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Display Board 
 function boardFig = displayBoard(game)
 
    cb = checkerBoard();
    
    vec = linspace(1,64,8);
    pos = zeros(8,8,2);
    
    % Positions for a8 - d8 - a5 - d5  
    for i =1:4
        for j=1:4
            pos(i,j,:) = [64 - vec(i)-2, vec(j)+2];
        end
    end   

    % Positions for a4 - d4 - a1 - d1
    for i =1:4
        for j=5:8
            pos(i,j,:) = [64-vec(i)-2, vec(j)-2];
        end
    end   
    
    % Positions for e8 - e5 - h5 - h8 
    for i =5:8
        for j=1:4
            pos(i,j,:) = [64-vec(i)+2, vec(j)+2];
        end
    end  
    
% Positions for h4 - h1 - e1 - e4
    for i =5:8
        for j=5:8
            pos(i,j,:) = [64-vec(i)+2, vec(j)-2];
        end
    end  
    
    hold on 
    image(cb)
    for row = 1:8
        for col = 1:8
            x = pos(row, col, 2);
            y = pos(row, col, 1);
            if game(row,col,2) == 'W'
                text(x, y, game{row, col,1}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','color','r','fontweight','bold');
            else 
                text(x, y, game{row, col,1}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','color','b','fontweight','bold');
            end    
        end
    end
    xticklabels({'h' 'g' 'f' 'e' 'd' 'c' 'b' 'a'})
    yticklabels({'8' '7' '6' '5' '4' '3' '2' '1'})
    hold off
    
 end
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update Game 
 
 function updatedGame = updateGame(game,move)
 
    % Original location of piece 
    origx = move(1,1);
    origy = move(1,2);
    
    %new lcoation of piece 
    movedx = move(2,1);
    movedy = move(2,2);
    
    %find name of piece that moved 
    pieceID = game(origx,origy,1);
    pieceCol = game(origx, origy,2);
    
    %change piece in updated game 
    updatedGame = game;
    updatedGame(origx, origy,1) = "  ";
    updatedGame(origx, origy,2) = "  ";
    updatedGame(movedx, movedy,1) = pieceID; 
    updatedGame(movedx, movedy,2) = pieceCol;
 
 end
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % play game - will start game ,track moves and produce the sow off fig
 % every time a move is made (key press?)

 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Calibrate 
    % will prompt user to clear board adn take 8 pictures, then display all
    % 8 iamges and ask the user to hoose whihc one to use as new "blank"