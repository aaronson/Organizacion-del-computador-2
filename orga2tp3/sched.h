#ifndef __SCHED_H__
#define __SCHED_H__

#define CANT_TAREAS 16

extern void setear_tss (unsigned int gdtpos, unsigned int tsspos, unsigned int cr3, unsigned int stack);

extern unsigned short tareas[CANT_TAREAS];

unsigned int obtener_pid();


unsigned int tarea_actual;

unsigned int next_free_tareas();

unsigned short int proximo_indice();

unsigned int proxima_tarea();



#endif
