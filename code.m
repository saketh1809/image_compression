% Comprehensive Image Compression: JPEG, JPEG2000, SPIHT, AEZW 
clc; clear; close all;

% Load Input Image
inputImage = imread('input_image.jpg');

% Ensure the image is grayscale for SPIHT and AEZW
if size(inputImage, 3) == 3
    grayImage = rgb2gray(inputImage);
else
    grayImage = inputImage;
end

% Display Original Image
figure;
imshow(inputImage);
title('Original Image');

% Original file size
originalFileSize = numel(inputImage); % in bytes
fprintf('Original Image Size: %d bytes\n', originalFileSize);

% ******** JPEG Compression **********
fprintf('Performing JPEG Compression...\n');
imwrite(inputImage, 'compressed_JPEG.jpg', 'Quality', 50);
jpegFileInfo = dir('compressed_JPEG.jpg'); % Get file info
jpegCompressedSize = jpegFileInfo.bytes; % Compressed file size in bytes
jpegCompressed = imread('compressed_JPEG.jpg');

% Display JPEG Compression Results
fprintf('JPEG Compressed Size: %d bytes\n', jpegCompressedSize);
fprintf('JPEG Compression Ratio: %.2f\n', originalFileSize / jpegCompressedSize);
figure;
imshow(jpegCompressed);
title('JPEG Compressed Image');

% ******** JPEG2000 Compression **********
fprintf('Performing JPEG2000 Compression...\n');
imwrite(inputImage, 'compressed_JPEG2000.jp2', 'CompressionRatio', 20);
jpeg2000FileInfo = dir('compressed_JPEG2000.jp2'); % Get file info
jpeg2000CompressedSize = jpeg2000FileInfo.bytes; % Compressed file size in bytes
jpeg2000Compressed = imread('compressed_JPEG2000.jp2');

% Display JPEG2000 Compression Results
fprintf('JPEG2000 Compressed Size: %d bytes\n', jpeg2000CompressedSize);
fprintf('JPEG2000 Compression Ratio: %.2f\n', originalFileSize / jpeg2000CompressedSize);
figure;
imshow(jpeg2000Compressed);
title('JPEG2000 Compressed Image');

% ******** SPIHT Compression ***********
fprintf('Performing SPIHT Compression...\n');
[coeff, sizes] = wavedec2(grayImage, 2, 'haar');

% SPIHT Encoding
[spihtCompressed, bitsSPIHT] = SPIHT_encode(coeff, sizes);
spihtCompressedSize = bitsSPIHT / 8; % Size in bytes

% SPIHT Decoding
spihtReconstructed = SPIHT_decode(spihtCompressed, sizes);

% Display SPIHT Compression Results
fprintf('SPIHT Compressed Size: %.2f bytes\n', spihtCompressedSize);
fprintf('SPIHT Compression Ratio: %.2f\n', originalFileSize / spihtCompressedSize);
figure;
imshow(uint8(spihtReconstructed));
title('SPIHT Reconstructed Image');

% ******** AEZW Compression **********
fprintf('Performing AEZW Compression...\n');
aezwCompressed = AEZW_encode(coeff, sizes);
aezwCompressedSize = numel(aezwCompressed); % Placeholder size in bytes

% AEZW Decoding
aezwReconstructed = AEZW_decode(aezwCompressed, sizes);

% Display AEZW Compression Results
fprintf('AEZW Compressed Size: %.2f bytes\n', aezwCompressedSize);
fprintf('AEZW Compression Ratio: %.2f\n', originalFileSize / aezwCompressedSize);
figure;
imshow(uint8(aezwReconstructed));
title('AEZW Reconstructed Image');

fprintf('Compression processes completed.\n');

% ******** Placeholder SPIHT Encoding ********
function [encoded, bits] = SPIHT_encode(coeff, sizes)
    % SPIHT Encoding (simplified placeholder)
    encoded = coeff(:); % Serialize all coefficients
    bits = numel(encoded) * 8; % Assuming 8 bits per coefficient
end

% ******** Placeholder SPIHT Decoding ********
function decoded = SPIHT_decode(encoded, sizes)
    % SPIHT Decoding (simplified placeholder)
    decoded = waverec2(encoded, sizes, 'haar'); % Reconstruct using wavelet synthesis
end

% ******** Placeholder AEZW Encoding ********
function encoded = AEZW_encode(coeff, sizes)
    % AEZW Encoding (simplified placeholder)
    encoded = coeff(:); % Flatten coefficients
end

% ******** Placeholder AEZW Decoding ********
function decoded = AEZW_decode(encoded, sizes)
    % AEZW Decoding (simplified placeholder)
    decoded = waverec2(encoded, sizes, 'haar'); % Reconstruct using wavelet synthesis
end
