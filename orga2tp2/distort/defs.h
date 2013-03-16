#ifndef _DEFS
#define _DEFS

#ifdef WIN32
#pragma warning (disable:4244)  /* disable nasty conversion warnings. */
#endif

#define WIN_TITLE   "Orga 2 Distortion Example"
#define ICON_TITLE  "OC2TP2"

#define DEFAULT_IMAGE_FN  "data/distort.rgb"

#define DEFAULT_EFFECT  rubber

#define WIN_SIZE_X  600
#define WIN_SIZE_Y  600

// Estas dos variables pueden llegar a serles utiles de modificar a la hora de realizar las mediciones de tiempos de la funcion.
// Cuanto mas chicos estos dos valores, mas grande sera el efecto, pero cuanto mas grandes sean, mas tiempo tardara en ejecutar
#define GRID_SIZE_X  16
#define GRID_SIZE_Y  16

#define CLIP_NEAR  0.1
#define CLIP_FAR   1000.0

typedef struct {
  void (* init)();
  void (* dynamics)();
  void (* redraw)();
  void (* click)();
} EFFECT;

extern EFFECT rubber;
int onAsm;

typedef struct {
  float x[4];
  float v[4];
  float t[2];
  int nail;
} MASS;

typedef struct {
  int i, j;
  float r;
} SPRING;

static int ccounter = 0;
static int asmcounter = 0;
static int caccum = 0;
static int asmaccum = 0;

 int spring_count;

 MASS *mass;
 SPRING *spring;

 int grab;


#endif
