void print_data(scv_extensions_if* data_ptr) {
    switch(data_ptr->get_type()) {
        case scv_extensions_if::BOOLEAN:
            cout<<data_ptr ->get_type_name()
                <<“_value is: “
                <<data_ptr ->get_bool();
            …
    }//end switch
}// end print_data
