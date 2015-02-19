%converting to gray scale
in = imread('image.png');
bw=rgb2gray(in);

%noise removal using median filter
img=medfilt2(bw,[5 5]);
bw=double(img);
[row, col] = size(bw);
for i= 1:row
    for j=1:col
        if i>=79 && i<=84
            bw(i,j)=255;
        end
        if i>=189 && i<=191
            bw(i,j)=255;
        end
    end
end
B=im2bw(bw);
B=~B;
simg=imfill(B,'holes');

[bw_labelled num]=bwlabel(simg);

j=0;
areas= regionprops(bw_labelled, 'BoundingBox');
for i=1:length(areas)
    
    subImage = imcrop(simg, areas(i).BoundingBox);
    [x,y]=size(subImage);
    if((x*y)>50)
        j=j+1;
        subImage=imresize(subImage,0.3);
        imwrite(subImage,strcat('C:\Users\Maitreya\project\char',num2str(j),'.png'));
        
    end
end


%areas1=[];
%for i=1:length(areas);
 %   areas1=[areas1; areas(i,1).Area];
%end
%disp(areas1);

%index=find(areas1>100 & areas1<2000);
%finalimg= zeros(size(bw_labelled));
%for i=1:length(index)
 %   image=bw_labelled==index(i);
  %  imwrite(image,strcat('char',num2str(i),'.png'));
   % disp(strcat('char',num2str(i),'.png'));
%end


