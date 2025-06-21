sc_semaphore NAME(COUNT);
NAME.wait(); // Lock one semaphore
             // Wait until available if in use
int NAME.trywait(); // Non-blocking, return success
int NAME.get_value(); // Returns available semaphores
NAME.post(); // Free one previously locked semaphore
