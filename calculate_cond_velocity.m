plot([signals_denoised(:,1) signals_denoised(:,5) signals_denoised(:,9) signals_denoised(:,13)])
legend("1 ring", "2 ring", "3 ring", "4 ring")

[~,loc1] = findpeaks(abs(signals_denoised(:,1)),'MinPeakHeight',2.5e-05,'MinPeakDistance', 15);
[~,loc2] = findpeaks(abs(signals_denoised(:,5)),'MinPeakHeight',5.5e-05,'MinPeakDistance', 15);
[~,loc3] = findpeaks(abs(signals_denoised(:,9)),'MinPeakHeight',5.5e-05,'MinPeakDistance', 15);
[~,loc4] = findpeaks(abs(signals_denoised(:,13)),'MinPeakHeight',2.5e-05,'MinPeakDistance', 15);


for g = 1:length(loc2)
    %v(g,1) = 0.0033333/abs(times(loc1(g))-times(loc2(g)));
    v(g,1) = 0.0033333/abs(times(loc2(g))-times(loc3(g)));
    v(g,2) = 0.0033333/abs(times(loc3(g))-times(loc4(g)));

    

end

cv = max(v,[],2);
