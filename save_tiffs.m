function tiff_data = save_tiffs(frame, n_frame, i)

imwrite(frame, strcat('Figures\ROI',num2str(i)','frame',num2str(n_frame(i)),'.tiff'))
end
