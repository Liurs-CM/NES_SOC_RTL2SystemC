try {
    //Code to monitor for exceptions.
    //In other words, this is where the
    // exceptions will occur. It is possible,
    // they occur within calls to functions
    // several levels down.
}
catch (type1 the_exception) {
    // Handle an exception of type1
}
catch (type2 the_exception) { // As many as desired
                              // Handle an exception of type1
}
catch (...) { // This is optional
              // All uncaught exceptions here
}

throw OBJECT;
throw; // Only used to re-throw from within catch
