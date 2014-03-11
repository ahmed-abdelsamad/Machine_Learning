function [ sortDist,IX,x,err , K , minK ] = KNN( input_args )
%KNN Summary of this function goes here
%   Detailed explanation goes here

x = zeros(182,145);
K = 182; % Maximum Value of K
 alph = 'abcdefghijklmnopqrstuvwxyz';
  for i = 1:1:26
      for j =1:1:7
      str = strcat('Noise Train/A1',alph(i),int2str(j),'.jpg');    
      img = double(imread(str));
      size(img);
      re = reshape(img,1,[]);
      x((i-1)*7 + j,:) = [re i];
      end
  end
  
dist = zeros(182,182);
xSquare = x(:,1:144);
for i=1:K
    x(i,1:144);
    crrnt = xSquare(i,:);
    crrntMat = ones(182,1) * crrnt;
    crrnt = xSquare - crrntMat;
    crrnt = crrnt.^2;
    dist(i,:) = sum(crrnt');
end

dist(logical(eye(size(dist)))) = inf;
[sortDist,IX] = sort(dist,2);
err = zeros(K-1,1);
for k=1:K-1
    error = 0;
    for i=1:K
        correctLabel = x(i,145);
        labels = x(IX(i,1:k),145);
        predictedLabel = mode(labels);
        if(correctLabel ~= predictedLabel)
            error = error + 1;
        end
    end
    err(k) = error;
end
minK = find(err == min(err));

figure;
stem(1:K-1,err);
title('Error against K');
end