function [obj, set] = shuffle(obj, set)

obj = generate_binding_events_new(obj, set, set.other.t_shuffle);
for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind
        obj.object(i).site(j).t_switch = obj.object(i).site(j).t_switch - set.other.t_shuffle; 
    end
end

obj = generate_non_specific_binding_events(obj, set, set.other.t_shuffle);
for i=1:obj.non.N
    obj.non.site(i).t_switch = obj.non.site(i).t_switch - set.other.t_shuffle;
end

end