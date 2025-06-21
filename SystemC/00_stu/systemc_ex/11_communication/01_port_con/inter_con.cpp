//Con by name
SC_HAS_PROCESS(VIDEO_Mixer);
VIDEO_Mixer::VIDEO_Mixer(sc_module_name nm)
    : sc_module(nm)
    , Rgb2YCrCb_i(“Rgb2YCrCb_i”)
      , YCRCB_Mixer_i(“YCRCB_Mixer_i”)
{
    // Connect
    Rgb2YCrCb_i.rgb_pi(rgb_graphics);
    Rgb2YCrCb_i.ycrcb_po(ycrcb_graphics);
    YCRCB_Mixer_i.K_pi(K);
    YCRCB_Mixer_i.a_pi(dvd_pi);
    YCRCB_Mixer_i.b_pi(ycrcb_graphics);
    YCRCB_Mixer_i.y_po(video_po);
}

//Con by position
SC_HAS_PROCESS(VIDEO_Mixer);
VIDEO_Mixer::VIDEO_Mixer(sc_module_name nm)
    : sc_module(nm)
{
    // Instantiate
    Rgb2YCrCb_iptr = new Rgb2YCrCb(
            "Rgb2YCrCb_i"
            );
    YCRCB_Mixer_iptr = new YCRCB_Mixer(
            "YCRCB_Mixer_i"
            );
    // Connect
    (*Rgb2YCrCb_iptr)( rgb_graphics
            ,ycrcb_graphics
            );
    (*YCRCB_Mixer_iptr)( K
            ,dvd_pi
            ,ycrcb_graphics
            ,video_po
            );
}
