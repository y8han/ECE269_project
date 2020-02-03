function [ A ] = ece_269_project_A( image )
    image_size=size(image);
    N2=image_size(1)*image_size(2);
    A=zeros(N2,1);
    for i=1:image_size(2)
        A((i-1)*image_size(1)+1:i*image_size(1),1)=image(:,i);
    end
%     A=uint8(A);
end

