function [ correctLabels,predictedLabels ] = predictKNN(x,usedK)
%PREDICTKNN Summary of this function goes here
%  @sortDist:   Distance between points
%  @IX:         Indicies of points
%  @K:          Length of Input
%  @x:          Input Data
%
%

testData = zeros(182,144);
alph = 'abcdefghijklmnopqrstuvwxyz';
K = 26 * 2;
correctLabels = 1:26;
for i =1:1:26
 for j=1:1:2
  str = strcat('Noise Test/A1',alph(i),int2str(j+7),'.jpg')  ; 
  img = double(imread(str));
  size(img);
  re = reshape(img,1,[]);
  testData((i-1)*2 + j,:) = re;
  end
end

xSquare = x(:,1:144);
for i=1:K
    crrnt = testData(i,:);
    crrntMat = ones(182,1) * crrnt;
    crrnt = xSquare - crrntMat;
    crrnt = crrnt.^2;
    dist(i,:) = sum(crrnt');
end

[sortDist,IX] = sort(dist,2);
predictedLabels = zeros(2,26);
for i =1:1:26
 for j=1:1:2
    labels = x(IX((i-1)*2+j,1:usedK),145);
    predictedLabel = mode(labels);
    predictedLabels(j,i) = predictedLabel;
  end
end

accuracy = zeros(1,26);
 for i=1:26
     accuracyT = size(find (predictedLabels(:,i) == correctLabels(i)));
     accuracy(i) = accuracyT(1);
 end
 
figure;
labels = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'};
bar([1:26],accuracy);
axis([0 27 0 3]);
set(gca, 'XTick', 1:26, 'XTickLabel', labels);


end