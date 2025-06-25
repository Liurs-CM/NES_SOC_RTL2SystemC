void bus::main_action() {
    if (!m_current_request)
        m_current_request = get_next_request();
    if (m_current_request)
        handle_request();
    if (!m_current_request)
        clear_locks();
}
