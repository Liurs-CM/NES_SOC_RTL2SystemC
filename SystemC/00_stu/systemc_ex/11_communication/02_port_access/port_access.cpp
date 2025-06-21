void VIDEO_Mixer::Mixer_thread() {
    …
        switch (control->read()) {
            case MOVIE: K.write(0.0f); break;
            case MENU: K.write(1.0f); break;
            case FADE: K.write(0.5f); break;
            default: status->write(ERROR); break;
        } …
}
