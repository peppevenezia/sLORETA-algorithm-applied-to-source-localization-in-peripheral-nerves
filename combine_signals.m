function [data, times] = combine_signals(axons, geometry)


switch size(axons,2)
    case 2
        switch geometry
            case "complex"
                [signals1 , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Recording_"+extractBefore(num2str(axons(1)),'.')+'_'+extractAfter(num2str(axons(1)), '.')+".txt", 'no');
                [signals2 , ~] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Recording_"+extractBefore(num2str(axons(2)),'.')+'_'+extractAfter(num2str(axons(2)), '.')+".txt", 'no');
                data = signals1+signals2;
            case "simple"
                [signals1 , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\37axons_physiologic_passo10\Recording_"+extractBefore(num2str(axons(1)),'.')+'_'+extractAfter(num2str(axons(1)), '.')+".txt", 'no');
                [signals2 , ~] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\37axons_physiologic_passo10\Recording_"+extractBefore(num2str(axons(2)),'.')+'_'+extractAfter(num2str(axons(2)), '.')+".txt", 'no');
                data = signals1+signals2;
        end

    case 3
        switch geometry
            case "complex"
                [signals1 , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Recording_"+extractBefore(num2str(axons(1)),'.')+'_'+extractAfter(num2str(axons(1)), '.')+".txt", 'no');
                [signals2 , ~] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Recording_"+extractBefore(num2str(axons(2)),'.')+'_'+extractAfter(num2str(axons(2)), '.')+".txt", 'no');
                [signals3 , ~] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\Simulazioni\Risultati\Recording_"+extractBefore(num2str(axons(3)),'.')+'_'+extractAfter(num2str(axons(3)), '.')+".txt", 'no');
                data = signals1+signals2+signals3;
            case "simple"
                [signals1 , times] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\37axons_physiologic_passo10\Recording_"+extractBefore(num2str(axons(1)),'.')+'_'+extractAfter(num2str(axons(1)), '.')+".txt", 'no');
                [signals2 , ~] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\37axons_physiologic_passo10\Recording_"+extractBefore(num2str(axons(2)),'.')+'_'+extractAfter(num2str(axons(2)), '.')+".txt", 'no');
                [signals3 , ~] = read_and_plot_data("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\Simulazioni\Risultati\37axons_physiologic_passo10\Recording_"+extractBefore(num2str(axons(2)),'.')+'_'+extractAfter(num2str(axons(2)), '.')+".txt", 'no');

                data = signals1+signals2+signals3;
        end


end


end