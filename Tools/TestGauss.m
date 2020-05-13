for i=1:set.ROI.number

    SupResParams=rainSTORM_main(rainSTORM_env, frame_data.ROI(i).frame, set); %frame_data.ROI(i).frame
end