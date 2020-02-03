function [ A ] = ece_269_project_B( vector,image_size )
    A=zeros(image_size(1),image_size(2));
    for i=1:image_size(2)
        A(:,i)=vector((i-1)*image_size(1)+1:i*image_size(1),1);
    end
%     A=uint8(A);
end

