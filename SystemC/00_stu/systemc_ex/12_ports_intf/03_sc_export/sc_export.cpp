#include "clock_gen.h"
…
clock_gen clock_gen_i(“clock_gen_i”);
collision_detector cd_i(“cd_i”);
// Connect clock
cd_i.clock(clock_gen_i.clock_xp);
…
