%% ±ê¶¨
function cal = Calibration(img)
    img = double(img);
    [M, N] = size(img);
    fmin = min(min(img));
    fm = img - fmin * ones(M, N);
    fmmax = max(max(fm));
    fs = 255 * fm ./ fmmax;
    cal = uint8(fs);
end
