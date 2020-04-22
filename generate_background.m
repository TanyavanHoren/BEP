function frame = generate_background(frame, pixel_data, experiment_data)

frame = frame + poissrnd(experiment_data.average_background,[pixel_data.pixels_y,pixel_data.pixels_x]);

end