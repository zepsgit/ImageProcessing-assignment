%--------------------------------------------------
%Part I
%Manually add noise and do fft and ifft accordingly
%--------------------------------------------------

F=imread('moonlanding.png'); % read the gs image
im_size=size(F);% Obtain the size of the image
P=2*im_size(1);
Q=2*im_size(2); % Obtaining padding parameters as 2*image size
FS=fft2(double(F),P,Q);
%caculate the max value of specturm
                    %--------------
                    %QUESTION1
                    %--------------
FSmax=max(FS(:));
fprintf("FSmax is:%d\n", FSmax);
Fim=fftshift(FS);%move spectrum to center of image
Fim_log=log(1+abs(Fim));%compute the magnitude, log to compress the data range
%so that can be shown properly.
%FT range around from 0 to 16, so normalize it to[0,255] for 'imshow' and
%'imwrite'
Fim_log = uint8(mat2gray(Fim_log) * 255);
                    %--------------
                    %QUESTION2
                    %--------------
figure(1)
%show the spectrum of original
imshow(Fim_log,[])
imwrite(Fim_log,'ori_spec.png')
title('original spectrum')

%caculate the coordinates of noise points
%center point coordinate
x_o=P/2+1; y_o=Q/2+1;
%east noise point
%distance from noise point to center
d=100; offset=100/sqrt(2);
%east point
x_e=x_o; y_e=y_o+d;
%north east point
x_ne=round(x_o-offset); y_ne=round(y_o+offset);
%north point
x_n=x_o-d; y_n=y_o;
%north west point
x_nw=round(x_o-offset); y_nw=round(y_o-offset);
%west point
x_w=x_o; y_w=y_o-d;
%south west point
x_sw=round(x_o+offset); y_sw=round(y_o-offset);
%south point
x_s=x_o+d; y_s=y_o;
%south east point
x_se=round(x_o+offset); y_se=round(y_o+offset);
%south west point
%set neighbourhood of abouve points specified value
Fim_copy=Fim;
[Fim_copy(x_e-1,y_e+1),Fim_copy(x_e,y_e+1),Fim_copy(x_e+1,y_e+1),...
 Fim_copy(x_e-1,y_e),Fim_copy(x_e,y_e),Fim_copy(x_e+1,y_e),...
 Fim_copy(x_e-1,y_e-1),Fim_copy(x_e,y_e-1),Fim_copy(x_e+1,y_e-1)]=deal(FSmax/10);

[Fim_copy(x_se-1,y_se+1),Fim_copy(x_se,y_se+1),Fim_copy(x_se+1,y_se+1),...
 Fim_copy(x_se-1,y_se),Fim_copy(x_se,y_se),Fim_copy(x_se+1,y_se),...
 Fim_copy(x_se-1,y_se-1),Fim_copy(x_se,y_se-1),Fim_copy(x_se+1,y_se-1)]=deal(FSmax/10);

[Fim_copy(x_s-1,y_s+1),Fim_copy(x_s,y_s+1),Fim_copy(x_s+1,y_s+1),...
 Fim_copy(x_s-1,y_s),Fim_copy(x_s,y_s),Fim_copy(x_s+1,y_s),...
 Fim_copy(x_s-1,y_s-1),Fim_copy(x_s,y_s-1),Fim_copy(x_s+1,y_s-1)]=deal(FSmax/10);

[Fim_copy(x_sw-1,y_sw+1),Fim_copy(x_sw,y_sw+1),Fim_copy(x_sw+1,y_sw+1),...
 Fim_copy(x_sw-1,y_sw),Fim_copy(x_sw,y_sw),Fim_copy(x_sw+1,y_sw),...
 Fim_copy(x_sw-1,y_sw-1),Fim_copy(x_sw,y_sw-1),Fim_copy(x_sw+1,y_sw-1)]=deal(FSmax/10);

[Fim_copy(x_w-1,y_w+1),Fim_copy(x_w,y_w+1),Fim_copy(x_w+1,y_w+1),...
 Fim_copy(x_w-1,y_w),Fim_copy(x_w,y_w),Fim_copy(x_w+1,y_w),...
 Fim_copy(x_w-1,y_w-1),Fim_copy(x_w,y_w-1),Fim_copy(x_w+1,y_w-1)]=deal(FSmax/10);

[Fim_copy(x_nw-1,y_nw+1),Fim_copy(x_nw,y_nw+1),Fim_copy(x_nw+1,y_nw+1),...
 Fim_copy(x_nw-1,y_nw),Fim_copy(x_nw,y_nw),Fim_copy(x_nw+1,y_nw),...
 Fim_copy(x_nw-1,y_nw-1),Fim_copy(x_nw,y_nw-1),Fim_copy(x_nw+1,y_nw-1)]=deal(FSmax/10);

[Fim_copy(x_n-1,y_n+1),Fim_copy(x_n,y_n+1),Fim_copy(x_n+1,y_n+1),...
 Fim_copy(x_n-1,y_n),Fim_copy(x_n,y_n),Fim_copy(x_n+1,y_n),...
 Fim_copy(x_n-1,y_n-1),Fim_copy(x_n,y_n-1),Fim_copy(x_n+1,y_n-1)]=deal(FSmax/10);

[Fim_copy(x_ne-1,y_ne+1),Fim_copy(x_ne,y_ne+1),Fim_copy(x_ne+1,y_ne+1),...
 Fim_copy(x_ne-1,y_ne),Fim_copy(x_ne,y_ne),Fim_copy(x_ne+1,y_ne),...
 Fim_copy(x_ne-1,y_ne-1),Fim_copy(x_ne,y_ne-1),Fim_copy(x_ne+1,y_ne-1)]=deal(FSmax/10);
                    %--------------
                    %QUESTION3
                    %--------------
figure(2)
Fim_copy_log=log(1+abs(Fim_copy));
Fim_copy_log=uint8(mat2gray(Fim_copy_log)*255);
imshow(Fim_copy_log,[])
imwrite(Fim_copy_log,'noise_added_spec.png');
title('noise added spectrum')
                    %--------------
                    %QUESTION4
                    %--------------
%{
iFim=ifft2(Fim);
resize_iFim=iFim(1:im_size(1),1:im_size(2));
figure(3)
imshow(abs(resize_iFim),[]);
%}
iFim_copy=ifft2(Fim_copy);
iFim_copy=iFim_copy(1:im_size(1),1:im_size(2));
iFim_copy=uint8(abs(iFim_copy));
%iFim_copy_log=log(1+abs(iFim_copy));
%iFim_copy_log=uint8(mat2gray(iFim_copy_log)*255);
figure(3)
imshow(iFim_copy,[])
imwrite(iFim_copy,'noise_added_img.png');
title('noise added image')
                    %--------------
                    %QUESTION5
                    %--------------
noise_Fim=fft2(iFim_copy);
noise_Fim_log=log(1+abs(noise_Fim));%use log to compress data range[0,16] around
noise_Fim_center=fftshift(noise_Fim_log);
noise_Fim_norm=uint8(mat2gray(noise_Fim_center)*255);%normalize date to [0,255]
figure(4)
imshow(noise_Fim_norm,[]);
imwrite(noise_Fim_norm,'noise_fft_spec.png')
title("noise added fft spectrum")

%{

%show corrupted image
cor_img=(ifft2(Fim_copy));
cor_img=cor_img(1:im_size(1), 1:im_size(2));
cor_img_rd=uint8(cor_img);%round it for saving it
cor_img_log=log(1+abs(cor_img));
cor_img_log=uint8(mat2gray(cor_img_log)*255);
figure(4)
imshow(abs(cor_img_log),[])
title('no shift noise corrupted img')
imwrite(abs(cor_img_log),'no_shift_cor_img.png')

figure(9)
imshow(abs(cor_img),[])
imwrite(cor_img_rd, 'shift_noise_cor_img.png');
title('manually corrupted and shift noise')

fft_cor_img=fft2(double(cor_img),P,Q);
fft_cor_img_log=log(1+abs(fft_cor_img));
fft_cor_img_normalize=uint8(mat2gray(fft_cor_img_log)*255);
figure(10)
imshow(fft_cor_img_normalize,[])
imwrite(fft_cor_img_normalize,'fft_cor_img.png');
title('fft cor img')

%FS without shift, so f(x,y) remains the same as original
%so ifft2(FS) does not generate noise
ifft_ori_img=real(ifft2(FS));
ifft_ori_img=ifft_ori_img(1:im_size(1), 1:im_size(2));
ifft_ori_img_normalize=uint8(mat2gray(ifft_ori_img)*255);

figure(5)
imshow(ifft_ori_img,[]);
imwrite(ifft_ori_img_normalize,'ifft_ori_img.png');
title('ifft of original img')
%caculate ifft_ori_img spectrum
%because FS without shift, so the spectrum need to shift to center
ifft_ori_img_spec=fft2(double(ifft_ori_img),P,Q);
ifft_ori_img_spec_shift=fftshift(ifft_ori_img_spec);
ifft_ori_img_spec_log=log(1+abs(ifft_ori_img_spec_shift));
ifft_ori_img_spec_log=uint8(mat2gray(ifft_ori_img_spec_log)*255);

figure(6)
imshow(ifft_ori_img_spec_log,[])
imwrite(ifft_ori_img_spec_log,'ifft_ori_img_spec.png')
title('ifft original image spectrum')

%now, I apply ifft to Fim which has been shifted to the center means
%f(x,y) has been multiplied by (-1)^(x+y) which will causes
%f(x,y)=-f(x,y),f(x,y),-f(x,y),f(x,y)... so the noise will be created.
ifftshift_ori_img=real(ifft2(Fim));
ifftshift_ori_img=ifftshift_ori_img(1:im_size(1),1:im_size(2));

figure(7)
imshow(ifftshift_ori_img,[]);
title('ifftshift original img')
%the spectrum no need to be centered because Fim already centered
ifftshift_ori_img_spec=fft2(double(ifftshift_ori_img),P,Q);
ifftshift_ori_img_spec=log(1+abs(ifftshift_ori_img_spec));

%show (-1)^(x+y)f(x,y) spectrum which is same as f(x,y)
%because shift transformation cannot change the spectrum value
figure(8)
imshow(ifftshift_ori_img_spec,[])
title('ifftshift original img spectrum')
%}

%---------------------------------------
%Part II
%Construct three type band reject filter
%Ideal Butterworth and Gaussian
%---------------------------------------





