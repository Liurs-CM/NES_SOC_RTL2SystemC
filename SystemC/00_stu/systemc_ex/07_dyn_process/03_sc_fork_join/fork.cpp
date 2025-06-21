//FILE: Fork.cpp
#define SC_INCLUDE_DYNAMIC_PROCESSES
#include <systemc>
#include "Fork.h"
    …
Fork::Fork(sc_module_name nm) //{{{
    : sc_module(nm)
{
    SC_THREAD(fork_thread);
    …
}
void Fork::fork_thread() { //{{{
    bool lf_up, rt_up; // use for return values
    SC_FORK
        sc_spawn(
                &lf_up
                ,sc_bind(
                    &Fork::road_thread
                    ,this
                    ,sc_ref(wheel_lf)
                    )
                ,"lf" // process name
                ),
        sc_spawn(
                &rt_up
                ,sc_bind(
                    &Fork::road_thread
                    ,this
                    ,sc_ref(wheel_rt)
                    )
                ,"rt" // process name
                )
            SC_JOIN
}
bool Fork::road_thread(sc_fifo<double>& which) { //
                                                 // Do some work
    return (road > 0.0);
}
