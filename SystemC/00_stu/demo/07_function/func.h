//1st: Declare, to establish their argument syntax
float add_time(float curr_hrs, int delta_secs);
void display(string message);

//2nd: Define, to establish their implementation code and behavior
float add_time(float curr_hrs, int delta_secs) {
    return (curr_hrs + delta_secs/3600.0);
}
void display(string message) {
    cout << message <<endl;
    return; // optional
}

//3rd: Called, from other functions to initiate their behavior
float total(0.0);
total = add_time(total,15);
display(“Drivers, start your engines”);
