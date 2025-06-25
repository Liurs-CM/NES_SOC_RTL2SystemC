class non_blocking_if  : public virtual sc_interface {
    public:
        // non-blocking BUS interface
        virtual void read(
                unsigned int unique_priority,
                int *data,
                unsigned int address,
                bool lock = false
                ) = 0;
        virtual void write(
                unsigned int unique_priority,
                int *data,
                unsigned int address,
                bool lock = false
                ) = 0; 
        virtual status get_status(
                unsigned int unique_priority
                ) = 0;  
}; // end class non_blocking_if
