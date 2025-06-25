class blocking_if   : public virtual sc_interface {
    public:
        virtual status burst_read(
                unsigned int unique_priority, 
                int *data,
                unsigned int start_address,
                unsigned int length = 1,
                bool lock = false
                ) = 0;
        virtual status burst_write(
                unsigned int unique_priority,
                int *data,
                unsigned int start_address,
                unsigned int length = 1,
                bool lock = false
                ) = 0;  
}; // end class blocking_if 

