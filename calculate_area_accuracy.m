function accuracy = calculate_area_accuracy(predicted_values, true_values)
global coord correspondences
tot =0;
   [theta, rho] = cart2pol(coord(:,1), coord(:,2));
   second  =  [theta((theta >= 1.57079632679490) | (theta < -2.61799387799150)), rho(find((theta >= 1.57079632679490) | (theta < -2.61799387799150))), find((theta >= 1.57079632679490) | (theta < -2.61799387799150))];
   first = [theta((theta < 1.57079632679490 & theta >= 0 ) | (theta >= -0.523598775598299 & theta <= 0 )), rho(find((theta < 1.57079632679490 & theta >= 0 ) | (theta >= -0.523598775598299 & theta <= 0 ))), find((theta < 1.57079632679490 & theta >= 0 ) | (theta >= -0.523598775598299 & theta <= 0 ))];
   third = [theta(theta < -0.523598775598299 & theta >= -2.61799387799150 ), rho(find(theta < -0.523598775598299 & theta >= -2.61799387799150 )), find(theta < -0.523598775598299 & theta >= -2.61799387799150 )];
   [secondzone(:,1), secondzone(:,2)] = pol2cart(second(:,1), second(:,2));
   for i=1:size(secondzone,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
       if abs(secondzone(i,1))<1e-15
           secondzone(i,1)=0;
       end
       if abs(secondzone(i,2))<1e-15
           secondzone(i,2)=0;
       end
   end

   [firstzone(:,1), firstzone(:,2)] = pol2cart(first(:,1), first(:,2));
   for i=1:size(firstzone,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
       if abs(firstzone(i,1))<1e-15
           firstzone(i,1)=0;
       end
       if abs(firstzone(i,2))<1e-15
           firstzone(i,2)=0;
       end
   end

   [thirdzone(:,1), thirdzone(:,2)] = pol2cart(third(:,1), third(:,2));
   for i=1:size(thirdzone,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
       if abs(thirdzone(i,1))<1e-15
           thirdzone(i,1)=0;
       end
       if abs(thirdzone(i,2))<1e-15
           thirdzone(i,2)=0;
       end
   end
    
   secondzone(:,3) = correspondences([second(:,3)]);
   thirdzone(:,3) = correspondences([third(:,3)]);
   firstzone(:,3) = correspondences([first(:,3)]);


   for i =1:size(predicted_values,1)
       if all(ismember([true_values(i), predicted_values(i)], firstzone(:,3))) == 1
           tot = tot+1;

       elseif all(ismember([true_values(i), predicted_values(i)], secondzone(:,3))) == 1
           tot = tot+1;

       elseif all(ismember([true_values(i), predicted_values(i)], thirdzone(:,3))) == 1
           tot = tot+1;

       end

   end

   

   accuracy = tot/size(predicted_values,1);
   disp(accuracy)

       
   

end 