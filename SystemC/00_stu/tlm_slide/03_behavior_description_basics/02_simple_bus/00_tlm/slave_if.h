class slave_if  : public direct_if {
    public:
        // Slave interface
        //Regular I/O
        virtual status read(int *data, unsigned int address) = 0;
        virtual status write(int *data, unsigned int address) = 0;
        //Address Mapping
        virtual unsigned int start_address() const = 0;
        virtual unsigned int end_address() const = 0;  
}; // end class slave_if
