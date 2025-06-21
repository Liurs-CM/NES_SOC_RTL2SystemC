sc_process_handle hname = // ordinary function
    sc_spawn(
            sc_bind(&funcName, ARGS…)//no return value
            ,processName
            ,spawnOptions
            );

sc_process_handle hname = // member function
    sc_spawn(
            sc_bind(&methName, object, ARGS…)//no return
            ,processName
            ,spawnOptions
            );

sc_process_handle hname = // ordinary function
    sc_spawn(
        &returnVar
        ,sc_bind(&funcName, ARGS…)
        ,processName
        ,spawnOptions
        );

sc_process_handle hname = // member function
    sc_spawn(
        &returnVar
        ,sc_bind(&methodName, object, ARGS …)
        ,processName
        ,spawnOptions
        );
