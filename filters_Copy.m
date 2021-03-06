%--------------------------------------------------
%Part II
%Construct three types of band-reject filter
%Ideal, Butterworth, Gaussian
%Cutoff frequency D0=100, width W=8
%For Butterworth order n=4
%--------------------------------------------------
F=imread('noise_added_spec.png');
im_size=size(F); % Obtain the size of the image
P=2*im_size(1);Q=2*im_size(2); % Optaining padding parameters
FTIm=fft2(double(F),P,Q); % FT with padded size
D0 = 100; W=8;
Filter_ideal = band_reject_filters('ideal', P, Q, D0,W); 
Filter_btw = band_reject_filters('btw', P, Q, D0,W); 
Filter_gaussian = band_reject_filters('gaussian', P, Q, D0,W); 
%center the filter
Ff_ideal=fftshift(Filter_ideal);
figure(1)
imshow(Ff_ideal,[]);
title('ideal')
imwrite(Ff_ideal,'ideal_.png');

Ff_btw=fftshift(Filter_btw);
figure(2)
imshow(Ff_btw,[]);
title('btw')
imwrite(Ff_btw,'btw_.png');

Ff_gaussian=fftshift(Filter_gaussian);
figure(3)
imshow(Ff_gaussian,[]);
title('gaussian')
imwrite(Ff_gaussian,'gaussian_.png');
                    %--------------
                    %QUESTION6
                    %--------------
%create the filters are of same size as image
%when apply the filter to the noise spectrum, will resize the filters as
%same as the spectrum size such that can do element-wise multiplication
%{
function H_out = band_reject_filters(filter_type, P, Q, D0,W)
m=P/2;n=Q/2;
D=zeros(P,Q);
for i=1:P
    for j=1:Q
        D(i,j)=sqrt((i-m)^2+(j-n)^2);
    end
end
switch filter_type
    case 'ideal'
        H2=double(D<=D0+W/2);
        H1=double(D<=D0-W/2);
        H_out=1-(H2-H1);
    case 'btw'
        H_out = 1./(1 + (D.*W./(D.^2-D0^2)).^(2*4));
    case 'gaussian'
        H_out = 1-exp(-((D.^2-D0^2)./(D.*W)).^2);
end       
end
%}
                    %--------------
                    %QUESTION7
                    %--------------
Fim=fftshift(FTIm); % move the origin of the FT to the center
FTI=log(1+abs(Fim)); 
FTI_norm=double(mat2gray(FTI)*255);
figure(4)
imshow(FTI_norm,[]);
imwrite(uint8(FTI_norm),'noise_spec.png');
title('original spec');

ideal_filtered_spec=uint8(Ff_ideal.*FTI_norm);
figure(5)
imshow(ideal_filtered_spec,[]);
imwrite(ideal_filtered_spec,'ideal_filtered_spec.png');
title('ideal filtered spec');

btw_filtered_spec=uint8(Ff_btw.*FTI_norm);
figure(6)
imshow(btw_filtered_spec,[]);
imwrite(btw_filtered_spec,'btw_filtered_spec.png');
title('btw filtered spec');

gaussian_filtered_spec=uint8(Ff_gaussian.*FTI_norm);
figure(7)
imshow(gaussian_filtered_spec,[]);
imwrite(gaussian_filtered_spec,'gaussian_filtered_spec.png');
title('gaussian filtered spec');
                    %--------------
                    %QUESTION8
                    %--------------
ideal_image=uint8(abs(ifft2(Ff_ideal.*Fim))); % multiply the FT of
ideal_image=ideal_image(1:im_size(1), 1:im_size(2));
figure(8)
imshow(ideal_image,[]);
title('ideal image');
imwrite(ideal_image,'ideal_image.png');

btw_image=uint8(abs(ifft2(Ff_btw.*Fim))); % multiply the FT of
btw_image=btw_image(1:im_size(1), 1:im_size(2));
figure(9)
imshow(btw_image,[]);
title('btw image');
imwrite(btw_image,'btw_image.png');

gaussian_image=uint8(abs(ifft2(Ff_gaussian.*Fim))); % multiply the FT of
gaussian_image=gaussian_image(1:im_size(1), 1:im_size(2));
figure(10)
imshow(gaussian_image,[]);
title('gaussian image');
imwrite(gaussian_image,'gaussian_image.png');

function H_out = band_reject_filters(filter_type, P, Q, D0,W)
%  Developing frequency domain coordinates
u = 0:(P-1);
v = 0:(Q-1);

idx = find(u > P/2);
u(idx) = u(idx) - P;
idy = find(v > Q/2);
v(idy) = v(idy) - Q;
% Compute the meshgrid coordinates
[V, U] = meshgrid(v, u);
% Compute the istance matrix
D = sqrt(U.^2 + V.^2);

% Begin fiter computations.
switch filter_type
    case 'ideal'
        H2=double(D<=D0+W/2);
        H1=double(D<=D0-W/2);
        H_out=1-(H2-H1);
    case 'btw'
        H_out = 1./(1 + (D.*W./(D.^2-D0^2)).^(2*4));
    case 'gaussian'
        H_out = 1-exp(-((D.^2-D0^2)./(D.*W)).^2);
    otherwise
       error('Unknown filter type.')
end
end

