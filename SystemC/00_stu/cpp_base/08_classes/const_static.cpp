//const
class A {
    int const the_answer;
    A() // Constructor
        :the_answer(42) // Initialization list
    {} // Body of constructor
};

//static
class A {
    static int m_count;
    static in count() { t return m_count; }
    A() { m_count++; } // Constructor
    ~A() { m_count--; }// Destructor
};
int A::m_count(0); // initialize
