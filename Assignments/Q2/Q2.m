function [] = Q2()

x = zeros(7,145);
re1 = ones(1,145);
testcon1 = ones(1,145);
t = ones(7,1);
eq = double(zeros(145,26));
class = zeros(2,26);
check = 1:26;
alph = 'abcdefghijklmnopqrstuvwxyz';
 for i =1:1:26
     for j =1:1:7
     str = strcat('Train/A1',alph(i),int2str(j),'.jpg');    
     img = double(imread(str));
%      size(img)
     re = reshape(img,1,[]);
     re1(:,1:144) = re;
%      re1 = cat(1,re,[1]);
     x(j,:) = re1;
     end
%      size(x)
      xt = transpose(x);
      mult = xt*x;
      xinv = pinv(mult);
      w = xinv*xt;
      eq(:,i) = double(w*t);
 end
 for i =1:1:26
     for j=1:1:2
         
         str = strcat('Test/A1',alph(i),int2str(j+7),'.jpg');    

         img1 = double(imread(str));
         testre = reshape(img1,1,[]);
         testcon1(:,1:144) = testre;
         result = testcon1*eq;
         class(j,i)= find(result == max(result));
         

     end 
          
 end
 
 accuracy = zeros(1,26);
 for i=1:26
     accuracyT = size(find (class(:,i) == check(i)));
     accuracy(i) = accuracyT(1);
 end

accuracy
bar(alphabet,accuracy);


