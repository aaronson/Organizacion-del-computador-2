#include "tss.h"

unsigned int nf_tss = 0;

tss tsss[TSS_COUNT];
tss tarea_inicial;
tss tarea_idle;

unsigned int next_free_tss_entry(){
	int x = nf_tss;
	nf_tss++;
	return x;
}
