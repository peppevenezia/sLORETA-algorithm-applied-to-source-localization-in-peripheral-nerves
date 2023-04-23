function outcome= estimate(axon,geometry, leadfield, algorithm,lambda,mode, number_of_electrodes,number_of_slices,number_of_slice_sources, percentage_noise, shows,showt, saves, savet )

switch number_of_slice_sources
    case 9
        [signals ,times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\"+number_of_slice_sources+"axons_passo10\Recording_"+axon+".txt", 'no');
    case 37

        switch length(axon)
            case 1
                [signals ,times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\"+number_of_slice_sources+"axons_physiologic_passo10\Config2\Recording_"+extractBefore(num2str(axon),'.')+'-'+extractAfter(num2str(axon), '.')+".txt", 'no');

            case 2
                try
                    [signals , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\37axons_physiologic_passo10\2axons\Recording_"+extractBefore(num2str(axon(1)),'.')+'_'+extractAfter(num2str(axon(1)), '.')+'-'+extractBefore(num2str(axon(2)),'.')+'_'+extractAfter(num2str(axon(2)), '.')+".txt", 'no');
                catch
                    [signals, times] = combine_signals(axon,geometry);
                end
            case 3
                [signals, times] = combine_signals(axon);
        end
    case 28
        switch length(axon)
            case 1
                [signals , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Config3\Recording_"+extractBefore(num2str(axon),'.')+'_'+extractAfter(num2str(axon), '.')+".txt", 'no');
            case 2
                try
                    [signals , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\2axons\Recording_"+extractBefore(num2str(axon(1)),'.')+'_'+extractAfter(num2str(axon(1)), '.')+'-'+extractBefore(num2str(axon(2)),'.')+'_'+extractAfter(num2str(axon(2)), '.')+".txt", 'no');
                catch
                    [signals, times] = combine_signals(axon,geometry);
                end
            case 3
                %[signals , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\3axons\Recording_"+extractBefore(num2str(axon(1)),'.')+'_'+extractAfter(num2str(axon(1)), '.')+'-'+extractBefore(num2str(axon(2)),'.')+'_'+extractAfter(num2str(axon(2)), '.')+'-'+extractBefore(num2str(axon(3)),'.')+'_'+extractAfter(num2str(axon(3)), '.')+".txt", 'no');
                [signals, times] = combine_signals(axon,geometry);

        end
end

% signals = downsample(signals, 3);
% times = downsample(times, 3);

template = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Recording_4_1.txt", 'no');
% template = downsample(template, 3);
template = mean(template(:,5:8),2);

%template = template(:,7);

[signals_noisy, noise] = add_noise(signals,times, number_of_electrodes, percentage_noise, 'no'); %0.75 in letteratura

%signals_denoised = wdenoise(signals_noisy,5,Wavelet="sym8" ); %nel caso di segnale intero era 5 di livello, con downsampling a 10 è 3
%signals_wsa = mean(signals_denoised(:,5:8),2);
signals_wsa = signals_noisy(:,7);

axon = sort(axon,2, 'descend');

[r,lags] = xcorr(signals_noisy(:,8),template);
%stem(lags,r)

%findpeaks(r,'MinPeakHeight',0.5e-07,'MinPeakDistance', 7);
[~, locsc] = findpeaks(r,'MinPeakHeight',0.3e-07,'MinPeakDistance', 7);

%findpeaks(abs(signals_wsa),'MinPeakHeight',0.5e-04,'MinPeakDistance', 12);
%[~, locsc] = findpeaks(abs(signals_wsa),'MinPeakHeight',0.8e-04,'MinPeakDistance', 12);
[~, locs] = findpeaks(abs(template),'MinPeakHeight',0.5e-04,'MinPeakDistance', 5); %per 5kHz è 5 per 33 e 100kHz è 15
count = 1;
for d = 1:length(locsc)
    %delay = locsc(d)-locs;
    delay=locsc(d)-max(length(signals_noisy(:,8)),length(template));
    templatesig = circshift(template, delay);
    %     figure,plot(signals_denoised(:,8))
    %     hold,plot(delay+1:length(template(:,8))+delay,template(:,8),'r');
    %     grid on
    %plot([signals_wsa templatesig(:)])

    signalsonly = signals_noisy(locs+delay-10:locs+delay+10,:); %nel caso di segnale intero era 10 metà intervallo
    timesonly = times(locs+delay-10:locs+delay+10,:);

    %plot(timesonly, signalsonly);

    switch round(signals_wsa(locs+delay)/templatesig(locs+delay))
        case 1
            
            switch algorithm
                case 'wmn'
                    currents_wmn = find_sources_slices_together(signalsonly,leadfield, noise, 'wmn',  lambda);
                    outcome(count) = showresults(currents_wmn, mode, axon(count),geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt,saves, savet);

                case 'loreta'
                    currents_loreta = find_sources_slices_together(signalsonly,leadfield, noise, 'loreta',  lambda);
                    outcome(count) = showresults(currents_loreta, mode, axon(count),geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt, saves, savet);

                case 'sloreta'
                    currents_sloreta = sLORETA(signalsonly,leadfield, noise, lambda);
                    outcome = showresults(currents_sloreta, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt,saves, savet);
                    
                case 'I'
                    currents_identity = find_sources_slices_together(signalsonly,leadfield, noise, 'I',  lambda);
                    outcome(count) = showresults(currents_identity, mode, axon(count),geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt, saves, savet);

            end
            count = count+1;

        case 2
            
            switch algorithm
                case 'wmn'
                    currents_wmn = find_sources_slices_together(signals_noisy,leadfield, noise, 'wmn',  lambda);
                    outcome(count:count+1) = showresults(currents_wmn, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt,saves, savet);

                case 'loreta'
                    currents_loreta = find_sources_slices_together(signals_noisy,leadfield, noise, 'loreta',  lambda);
                    outcome(count:count+1) = showresults(currents_loreta, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt, saves, savet);

                case 'sloreta'
                    currents_sloreta = sLORETA(signalsonly,leadfield, noise, lambda);
                    outcome(count:count+1) = showresults(currents_sloreta, mode, axon(count:count+1),geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt,saves, savet);
                    
                case 'I'
                    currents_identity = find_sources_slices_together(signals_noisy,leadfield, noise, 'I',  lambda);
                    outcome(count:count+1) = showresults(currents_identity, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt, saves, savet);

            end
            count = count+2;

        case 3

            switch algorithm
                case 'wmn'
                    currents_wmn = find_sources_slices_together(signals_noisy,leadfield, noise, 'wmn',  lambda);
                    outcome(count:count+1) = showresults(currents_wmn, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt,saves, savet);

                case 'loreta'
                    currents_loreta = find_sources_slices_together(signals_noisy,leadfield, noise, 'loreta',  lambda);
                    outcome(count:count+1) = showresults(currents_loreta, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt, saves, savet);

                case 'sloreta'
                    currents_sloreta = sLORETA(signalsonly,leadfield, noise, lambda);
                    outcome(count:count+2) = showresults(currents_sloreta, mode, axon(count:count+2),geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt,saves, savet);

                case 'I'
                    currents_identity = find_sources_slices_together(signals_noisy,leadfield, noise, 'I',  lambda);
                    outcome(count:count+1) = showresults(currents_identity, mode, axon,geometry, number_of_slices, number_of_slice_sources,percentage_noise,shows,showt, saves, savet);

            end
            count = count+3;

    end




end
