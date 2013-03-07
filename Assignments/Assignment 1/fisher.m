%function [ A ] = fisher(file1)
%FISHER Summary of this function goes here
%   Detailed explanation goes here

file1 = 'data1.txt';
noOfClasses = 2;
dataSet1 = fopen(file1);

%Read Dataset
[A,count] = fscanf(dataSet1, '%f %f %f',[3 inf]);

count = count/3;
A = A';

%
%  Row 1 for Class 1 (A)
%  Row 2 for Class -1  (B)
%
m = zeros(2,noOfClasses);
% end

%mA contains classes 1
%mB contains classes -1

mA = A( find(A(:,3) == 1),1:2);
countA = size(mA,1);
mB = A( find(A(:,3) == -1),1:2);
countB = size(mB,1);

%Mean Calculation for both classes
meanA = sum(mA) / countA;
meanB = sum(mB) / countB;

meanA = meanA';
meanB = meanB';

mAt = mA';
mBt = mB';
%Sw Calculation
swA(1,:) = mAt(1,:) - meanA(1);
swA(2,:) = mAt(2,:) - meanA(2);

swB(1,:) = mBt(1,:) - meanB(1);
swB(2,:) = mBt(2,:) - meanB(2);



a = zeros(2);
b = zeros(2);
for i=1:countA
    a =  a +(swA(:,i) * swA(:,i)');
end

for i=1:countB
    b = b + (swB(:,i) * swB(:,i)');
end

sw = a + b;

swI = sw^-1;

w = swI * (meanB - meanA)

figure
hold on;scatter(mA(:,1),mA(:,2));
hold on;scatter(mB(:,1),mB(:,2),'filed');