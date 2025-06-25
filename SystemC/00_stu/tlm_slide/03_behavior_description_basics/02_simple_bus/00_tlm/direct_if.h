class direct_if : public virtual sc_interface {
    public:
        // direct BUS/Slave interface
        virtual bool direct_read(
                int *data, 
                unsigned int address
                ) = 0;
        virtual bool direct_write(
                int *data, 
                unsigned int address
                ) = 0;  
}; // end class direct_if 

