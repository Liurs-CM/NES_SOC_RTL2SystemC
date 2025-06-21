// Add "& resume" to sensitivity while suspended
void sc_process_handle::suspend(descend);
void sc_process_handle::resume(descend);
// Ignore sensitivity while disabled
void sc_process_handle::disable(descend);
void sc_process_handle::enable(descend);
// Complete remove process
void sc_process_handle::kill(descend);
// Asynchronously restart a process
void sc_process_handle::reset(descend);
// Reset process on every resumption event
void sc_process_handle::sync_reset_on(descend);
void sc_process_handle::sync_reset_off(descend);
// Throw an exception in the specified process
template<typename T>
void sc_process_handle::throw_it( const T&,descend);
