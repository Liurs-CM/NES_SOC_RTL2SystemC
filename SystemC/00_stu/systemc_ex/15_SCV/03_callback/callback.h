enum callback_reason {
    VALUE_CHANGE,
    DELETE
}
// Register a simple callback function
callback_h register_cb (
        void (*f)(
            scv_extensions_if& OBJ,
            callback_reason REASON
            )
        );
// Template method registers a callback function
// with an extra argument in a type-safe manner
template<typename T>
callback_h register_cb(
        void (*f)(
            scv_extensions_if& OBJECT,
            callback_reason REASON,
            T ARG
            ),
        T arg
        );
// Remove existing callback
virtual void remove_cb( callback_h HANDLE);
