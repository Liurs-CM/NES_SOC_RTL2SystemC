// sc_port<sc_signal_in_if<T>>
sc_in<T> name_sig_ip;
sensitive << name_sig_ip.value_changed();
// Additional sc_in specializations...
sc_in<bool> name_bool_sig_ip;
sc_in<sc_logic> name_log_sig_ip;
sensitive << name_sig_ip  pos();
sensitive << name_sig_ip  neg();
// sc_port<sc_signal_out_if<T>>
sc_inout<T> name_sig_op;
sensitive << name_sig_op.value_changed();
sc_inout_resolved<N> name_rsig_op;
sc_inout_rv<N> name_rsig_op;
sc_inout<T> name_rsig_op;
sc_inout_resolved<T> name_rsig_op;
sc_inout_rv<T> name_rsig_op;
// everything under sc_in<T> plus the following...
name_sig_op.initialize(value);
name_sig_op = value; // <-- DON’T USE!!!
