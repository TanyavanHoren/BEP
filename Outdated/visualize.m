function void = visualize(frame, fig)
%figure
fig = imagesc([1:size(frame,2)], [1:size(frame,1)], frame);
%view(2)
%box('on')
%set(fig,'linewidth',1.5)
%set(fig,'edgecolor','none')
%xlim([1 size(frame,2)])
%ylim([1 size(frame,1)])
end