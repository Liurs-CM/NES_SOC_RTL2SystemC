class eslx_heartbeat_if: public sc_interface {
    public:
        virtual const sc_event& default_event() const = 0;
        virtual const sc_event& posedge_event() const = 0;
};
