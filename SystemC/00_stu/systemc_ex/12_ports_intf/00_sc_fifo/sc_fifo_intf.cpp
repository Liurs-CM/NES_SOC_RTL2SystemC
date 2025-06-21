// Definition of sc_fifo<T> output interface
template <class T>
class sc_fifo_out_if: virtual public sc_interface {
    public:
        virtual void write(const T& ) = 0;
        virtual bool nb_write(const T& ) = 0;
        virtual int num_free() const = 0;
        virtual const sc_event&
            data_read_event() const = 0;
};

// Definition of sc_fifo<T> input interface
template<class T>
class sc_fifo_in_if: virtual public sc_interface{
    public:
        virtual void read( T& ) = 0;
        virtual T read() = 0;
        virtual bool nb_read( T& ) = 0;
        virtual int num_available()const = 0;
        virtual const sc_event&
            data_written_event() const = 0;
};

