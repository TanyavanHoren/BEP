function nanorod_data = generate_binding_events(nanorod_data, experiment_data,t) 

for i=1:nanorod_data.number
    for j=1:nanorod_data.nanorod(i).number_bind
        if nanorod_data.nanorod_bindingspots(i).binding_spot(j).isBound==0
             if rand()>expcdf(t-nanorod_data.nanorod_bindingspots(i).binding_spot(j).time,experiment_data.td)
                continue 
            end
                nanorod_data.nanorod_bindingspots(i).binding_spot(j).isBound = abs(nanorod_data.nanorod_bindingspots(i).binding_spot(j).isBound-1);
                nanorod_data.nanorod_bindingspots(i).binding_spot(j).time = t;
        else
             if rand()>expcdf(t-nanorod_data.nanorod_bindingspots(i).binding_spot(j).time,experiment_data.tb) 
                continue
            end
                nanorod_data.nanorod_bindingspots(i).binding_spot(j).isBound = abs(nanorod_data.nanorod_bindingspots(i).binding_spot(j).isBound-1);
                nanorod_data.nanorod_bindingspots(i).binding_spot(j).time = t;
        end
    end
end

%off: 0
%on: 1
%generate a random number and compare to the cumulative exponential
%distribution
%if prob gives a no -> leave unchanged
%else -> switch
%use abs(x-1) to switch
%if 1, make sure to add gaussian 