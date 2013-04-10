function [ err, IX,dist,x] = KNN( input_args )
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
        correctLabel = x(i,145)
        labels = x(IX(i,1:k),145)
        output = abs(correctLabel - labels); %TODO: fix
        error = error + sum(output);
    end
    err(k) = error;
end
