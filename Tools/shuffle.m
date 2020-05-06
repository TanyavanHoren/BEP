function [obj, set] = shuffle(obj, set)

obj = generate_binding_events(obj, set, set.other.t_shuffle);
for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind
        obj.object(i).site(j).t_switch = obj.object(i).site(j).t_switch - set.other.t_shuffle; 
    end
end

set= generate_non_specific_binding_events(set, set.other.t_shuffle);
for i=1:set.non.N
    set.non.site(i).t_switch = set.non.site(i).t_switch - set.other.t_shuffle;
end

end