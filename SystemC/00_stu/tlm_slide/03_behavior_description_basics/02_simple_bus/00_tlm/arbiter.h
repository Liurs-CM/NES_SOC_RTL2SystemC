class arbiter  : public arbiter_if  , public sc_module {
    public:
        // constructor
        arbiter(sc_module_name name_ , bool verbose = false)
            : sc_module(name_) , m_verbose(verbose)
        { }
        request *arbitrate(const request_vec &requests);
    private:
        bool m_verbose;
};

request* arbiter::arbitrate(const request_vec &requests) {
    int i;
    // at least one request is here
    request *best_request = requests[0]; 

    // highest priority: status==WAIT and lock is set: locked burst-action
    for (i = 0; i < requests.size(); ++i) {
        request *request = requests[i];
        if ((request->status == TRANSFER_WAIT) && 
                (request->lock == LOCK_SET)) { 
            return request;	
        }
    } 

    // second priority: lock is set at previous call,  i.e. LOCK_GRANTED  
    for (i = 0; i < requests.size(); ++i)    
        if (requests[i]->lock == LOCK_GRANTED)  {	return requests[i];      }

    // third priority: priority  
    for (i = 1; i < requests.size(); ++i)    {
        sc_assert(requests[i]->priority != best_request->priority);
        if (requests[i]->priority < best_request->priority)	
            best_request = requests[i];
    }
    if (best_request->lock != LOCK_NO)
        best_request->lock = LOCK_GRANTED;  

    return best_request;
}
