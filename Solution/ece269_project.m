%Project for ECE269A
clear;
clc;
close all
m=1;
dir1 = 'C:\Users\Administrator\Desktop\ece269_project\part1\';
for k=1:100
    fn=strcat(dir1,int2str(k),'a.jpg');
    f{m}=imread(fn);  
    m=m+1;
end
dir2 = 'C:\Users\Administrator\Desktop\ece269_project\part2\';
for k=101:190
    fn=strcat(dir2,int2str(k),'a.jpg');
    f{m}=imread(fn);  
    m=m+1;
end
m=m-1;
image_size=size(f{1});
N2=image_size(1)*image_size(2);
A=zeros(N2,m);
for M=1:m
    A(:,M)=ece_269_project_A(f{M});
end
%A=uint8(A);
aver=sum(A,2)./m;
%aver=uint8(aver);
aver=round(aver);
figure(1);
aver1=ece_269_project_B(aver,image_size);
aver1=uint8(aver1);
imshow(aver1);
saveas(figure(1),['C:\Users\Administrator\Desktop\ece269_project\Solution\figures\aver.jpg']);
title('The average face')
for i=1:m
    A(:,i)=A(:,i)-aver;
end
C=A'*A;
[eigenvectors,eigenvalues]=eig(C);
eigenfaces=A*eigenvectors;
% sum=zeros(1,40-2+1);
% index=1;
% for number=2:40
% % number=30;
% dir3='C:\Users\Administrator\Desktop\ece269_project\Solution\figures\eigenface';
% for i=1:number
%     eigenfaces_image{i}=ece_269_project_B(eigenfaces(:,191-i),image_size);
% %     figure(i+1)
% %     imagesc(eigenfaces_image{i})
% %     colormap(gray)
% %     fn=strcat(dir3,int2str(i),'b.jpg');
% %     saveas(figure(i+1),fn);
% end
% %then I choose the 13th eigenface for reconstruction
% face_1=ece_269_project_A(f{13});
% face_1_aver=face_1-aver;
% omega=zeros(1,number);
% for i=1:number
%     omega(1,number+1-i)=eigenfaces(:,190+1-i)'*face_1_aver;
% end
% new_face1=zeros(image_size(1)*image_size(2),1);
% for i=1:number
%     new_face1=new_face1+eigenfaces(:,190+1-i)*omega(1,number+1-i);
% end
% new_face2=new_face1;
% new_face22=new_face1;
% face_max=max(new_face1);
% face_min=min(new_face1);
% for i=1:image_size(1)*image_size(2)
%     new_face2(i,1)=round((new_face2(i,1)-face_min)/(face_max-face_min)*255);
%     new_face22(i,1)=round((new_face22(i,1)-face_min)/(face_max-face_min)*255)-127;
% end
% new_face=ece_269_project_B(new_face1,image_size);
% % figure(20)
% % imagesc(new_face);
% % colormap(gray)
% new_face3=uint8(ece_269_project_B(new_face2,image_size));
% figure(20+number)
% %fn=strcat(dir3,'part2b.jpg');
% imshow(new_face3)
% %saveas(figure(21),fn);
% %then I calculate the MSE for different numbers of PCs
% for i=1:image_size(1)*image_size(2)
%     sum(1,index)=sum(1,index)+(face_1_aver(i,1)-new_face22(i,1))^2;
% end
% sum(1,index)=sum(1,index)/(image_size(1)*image_size(2));
% index=index+1;
% end
% figure(100)
% plot(sum);
% grid on
% title('MSE versus the number of PCs')
%this is for part(d)
% sum=zeros(1,40-2+1);  %the number of PCs are 2-40
% index=1;
% for number=2:40
number_degree=60;
sum_degree=zeros(1,number_degree);
class_degree=zeros(1,number_degree);
for degree=1:number_degree
sum=0;
class_error=0;
number=190;
dir3='C:\Users\Administrator\Desktop\ece269_project\Solution\figures\13a.jpg';
dir5='C:\Users\Administrator\Desktop\ece269_project\Solution\figures\';
% dir4='C:\Users\Administrator\Desktop\ece269_project\Solution\figures\building.jpg';
J=imread(dir3);
J_r=imrotate(J,degree,'bilinear','crop');
imshow(J)
figure(2)
% J_r=imread(dir4);
% J_r=rgb2gray(J_r);
% J_r=imresize(J_r,[193,162]);
% J_r=imrotate(J_r,degree,'bilinear','crop');
imshow(J_r)
for i=1:number
    eigenfaces_image{i}=ece_269_project_B(eigenfaces(:,191-i),image_size);
%     figure(i+1)
%     imagesc(eigenfaces_image{i})
%     colormap(gray)
%     fn=strcat(dir3,int2str(i),'b.jpg');
%     saveas(figure(i+1),fn);
end
%then I choose the 13th eigenface for reconstruction
face_1=ece_269_project_A(J);
face_1_r=ece_269_project_A(J_r);
face_1_aver=face_1-aver;
face_1_aver_r=face_1_r-aver;
omega=zeros(1,number);
omega_r=zeros(1,number);
for i=1:number
    omega(1,number+1-i)=eigenfaces(:,190+1-i)'*face_1_aver;
end
for i=1:number
    omega_r(1,number+1-i)=eigenfaces(:,190+1-i)'*face_1_aver_r;
end
for i=1:number
%     sum(1,index)=sum(1,index)+(face_1_aver(i,1)-new_face22(i,1))^2;
    class_error=class_error+(omega(1,number+1-i)-omega_r(1,number+1-i))^2;
end
% sum(1,index)=sum(1,index)/(image_size(1)*image_size(2));
class_error=class_error/(190);
class_degree(1,degree)=class_error;
new_face1=zeros(image_size(1)*image_size(2),1);
for i=1:number
    new_face1=new_face1+eigenfaces(:,190+1-i)*omega_r(1,number+1-i);
end
new_face2=new_face1;
new_face22=new_face1;
face_max=max(new_face1);
face_min=min(new_face1);
for i=1:image_size(1)*image_size(2)
    new_face2(i,1)=round((new_face2(i,1)-face_min)/(face_max-face_min)*255);
    new_face22(i,1)=round((new_face22(i,1)-face_min)/(face_max-face_min)*255)-127;
end
new_face=ece_269_project_B(new_face1,image_size);
% figure(20)
% imagesc(new_face);
% colormap(gray)
new_face3=uint8(ece_269_project_B(new_face2,image_size));
if(mod(degree,5)==0) 
figure(3+degree)
fn=strcat(dir5,int2str(degree),'part6.jpg');
imshow(new_face3)
saveas(figure(3+degree),fn);
end
%then I calculate the MSE for different numbers of PCs
for i=1:image_size(1)*image_size(2)
%     sum(1,index)=sum(1,index)+(face_1_aver(i,1)-new_face22(i,1))^2;
    sum=sum+(face_1_aver(i,1)-new_face22(i,1))^2;
end
% sum(1,index)=sum(1,index)/(image_size(1)*image_size(2));
sum=sum/(image_size(1)*image_size(2));
sum_degree(1,degree)=sum;
end
figure(4)
plot(sum_degree)
grid on 
title('MSE versus degree')
figure(5)
plot(class_degree)
title('face class error versus degree')
%index=index+1;
% end
% figure(100)
% plot(sum);
% grid on
% title('MSE versus the number of PCssu')