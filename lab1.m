mask = zeros(16);
load("waves")
ORIGIM = imread('cameraman.tif');
ORIGIM = double(ORIGIM);

% 
% for n = 1:16
%     for m = 1:16
%         mask(n,m) = manhat(n, m, 9, 9);
%     end
% end
% 
% shortwaves = waves(1:16:256, 1:16:256);
% ftshortwaves = fftshift(fft2(shortwaves));
% 
% for k = 0:2
%     
% ftshortwaves0 = ftshortwaves.*(mask<=k);
% rec0 = ifft2(fftshift(ftshortwaves0));
% figure
% 
% subplot(2,2,1);
% plot(shortwaves) 
%  
% subplot(2,2,2);
% plot(real(rec0))
% 
% subplot(2,2,3);
% plot(shortwaves-real(rec0))
% 
% subplot(2,2,4);
% imagesc(rec0)
% 
% end

 %% 
SFFTIMAGE = complex(zeros(size(ORIGIM)));
    for k = 1:16:size(ORIGIM,1)-15
        for m = 1:16:size(ORIGIM,2)-15
            SFFTIMAGE(k:k+15, m:m+15)=fftshift(fft2(ORIGIM(k:k+15,m:m+15)));
        end
    end
   
    for n = 1:16
        for m = 1:16
            mask(n,m) = manhat(n, m, 9, 9);
        end
    end
    
    for mthres = 1:max(mask(:))+1
        for k = 1:16:size(ORIGIM,1)-15
            for m = 1:16:size(ORIGIM,2)-15
                RECIM = ifft2(fftshift((SFFTIMAGE(k:k+15, m:m+15).*(mask<=mthres))));
                RECIMAGE(k:k+15,m:m+15) = abs(RECIM);
            end 
        end
        figure(1);
        imagesc(ORIGIM)
        figure(2);
        imagesc(RECIMAGE);
        drawnow
        pause
    end
   
    
    

    


