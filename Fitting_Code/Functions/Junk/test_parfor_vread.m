V = VideoReader('Z:\1728\1728.2\Test Data\T5\2021_09_24\Test1\c1.avi');
time_vec = 0:1/V.FrameRate:V.Duration;
parfor i = 1:V.Duration*V.FrameRate
    I = V.readFrame;
    [cmin,ind] = min(abs(V.CurrentTime - time_vec));
    cmin
    
end