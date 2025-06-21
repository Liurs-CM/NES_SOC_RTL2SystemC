//FILE: Rgb2YCrCb.h
SC_MODULE(Rgb2YCrCb) {
    sc_port<sc_fifo_in_if<RGB_frame> > rgb_pi;
    sc_port<sc_fifo_out_if<YCRCB_frame> > ycrcb_po;
};

//FILE: YCRCB_Mixer.h
SC_MODULE(YCRCB_Mixer) {
    sc_port<sc_fifo_in_if<float> > K_pi;
    sc_port<sc_fifo_in_if<YCRCB_frame> > a_pi, b_pi;
    sc_port<sc_fifo_out_if<YCRCB_frame> > y_po;
};

//FILE: VIDEO_Mixer.h
SC_MODULE(VIDEO_Mixer) {
    // ports
    sc_port<sc_fifo_in_if<YCRCB_frame> > dvd_pi;
    sc_port<sc_fifo_out_if<YCRCB_frame> > video_po;
    sc_port<sc_fifo_in_if<MIXER_ctrl> > control;
    sc_port<sc_fifo_out_if<MIXER_state> > status;
    // local channels
    sc_fifo<float> K;
    sc_fifo<RGB_frame> rgb_graphics;
    sc_fifo<YCRCB_frame> ycrcb_graphics;
    // local modules
    Rgb2YCrCb Rgb2YCrCb_i;
    YCRCB_Mixer YCRCB_Mixer_i;
    // constructor
    VIDEO_Mixer(sc_module_name nm);
    void Mixer_thread();
};
