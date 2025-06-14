//Defining FIFO class template
template<typename T, int maxdepth=1>
class fifo {
    vector<T> m_fifo;
    public:
    void push(T v);
    T pop();
    bool full() { return m_fifo.size() >= maxdepth; }
    bool empty() { return m_fifo.size() == 0; }
};

//Using FIFO class template
fifo<double> readout_fifo;
fifo<string> message_fifo;
readout_fifo.push(2.71);
