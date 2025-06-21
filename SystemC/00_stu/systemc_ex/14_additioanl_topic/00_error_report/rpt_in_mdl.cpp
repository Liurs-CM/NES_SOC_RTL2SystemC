extern char* MSGID;
void mymod::some_thread() {
    wait(2,SC_NS);
    SC_REPORT_INFO(MSGID,"Sample info");
    SC_REPORT_WARNING(MSGID,"Sample warning");
    SC_REPORT_ERROR(MSGID,"Sample error");
    SC_REPORT_FATAL(MSGID,"Sample fatal");
}
