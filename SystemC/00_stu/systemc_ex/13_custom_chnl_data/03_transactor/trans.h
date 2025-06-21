#include "cpu2pca.h"
enum operation {WRITE=false, READ=true};
void cpu2pca::write(unsigned long addr
        ,long data) {
    wait(ck->posedge_event());
    ld->write(true);
    rw->write(WRITE);
    a->write(addr);
    d->write(data);
    wait(ck->posedge_event());
    ld->write(false);
}
long cpu2pca::read(unsigned long addr) {
    wait(ck->posedge_event());
    ld->write(true);
    rw->write(READ);
    a->write(addr);
    d->write(FLOAT);
    wait(ck->posedge_event());
    ld->write(false);
    return d->read().to_long();
}
