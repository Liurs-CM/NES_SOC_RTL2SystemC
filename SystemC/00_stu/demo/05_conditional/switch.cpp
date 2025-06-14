switch (c) {
    case ‘a’:
        cout<< “Aborting…” <<endl;
        break;
    case ‘q’:
    case ‘x’:
        cout<< “Quiting” <<endl;
        break;
    case ‘c’:
        cout<< “Quiting” <<endl;
        break;
    default:
        cout<< “Unknown command ‘” << c << “’” <<endl;
        break;
}//endswitch
