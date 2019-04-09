
function score = vinit_code(img)

plus=0.001;
th1=35;
size1=5;
th=25;
avg=3;

[m,n,~]=size(img);
G=rgb2gray(double(img));
medfil=medfilt2(G,[size1,size1]);
aaa=ones(avg,avg)/(avg*avg);
t=(abs(G-medfil)*1);%figure(1);imshow(mat2gray(t))
t=filter2(aaa,t,'same');%figure(2);imshow(mat2gray(t))
 
t(t<th)=0;%figure(3);imshow(t/10)
b=std2(t);

t(t<th1)=0;%figure(4);imshow(t/10)
b1=std2(t);

score(1)=b+b1;
score(2)=b*b1;
score(3)=(b*b1+plus)/(b^2+plus);
score(4)=(b*b1+plus)/(b1^2+plus);
score(5)=(2*b*b1+plus)/(b^2+b1^2+plus);

function grayImage = rgb2gray(rgbImage)
try
[rows, columns, numberOfColorChannels] = size(rgbImage);
if numberOfColorChannels  == 3
  % It's color, need to convert it to grayscale.
  redChannel = rgbImage(:, :, 1);
  greenChannel = rgbImage(:, :, 2);
  blueChannel = rgbImage(:, :, 3);
  % Do the weighted sum.
  grayImage = .299*double(redChannel) + ...
              .587*double(greenChannel) + ...
              .114*double(blueChannel);
  % You probably want to convert it back to uint8 so you can display it.
  grayImage = uint8(grayImage);
else
  % It's already gray scale.
  grayImage = rgbImage;  % Input image is not really RGB color.
end
catch ME
errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
    ME.stack(1).name, ME.stack(1).aline, ME.message);
fprintf(1, '%s\n', errorMessage);
uiwait(warndlg(errorMessage));
end
