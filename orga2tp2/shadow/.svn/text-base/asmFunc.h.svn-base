// Las funciones a implementar son las siguientes:

// Linea 137 de shadow.c
// Esta funcion se encarga de crear una matriz de una Transformacion afin que proyecta en un plano, todos los objetos que se encuentran entre la posicion de la luz y el plano. Es necesario para compilar, crear una implementacion de esta funcion en ASM que al menos vincule el nombre para poder compilar el proyecto.
extern void asm_shadowmatrix(GLfloat matrix[4][4], GLfloat plane[4], GLfloat lightpos[4]);


// Linea 176 de shadow.c
// Esta funcion se encarga de dibujar para un as de luz en particular y un size, su sombra. Es necesario para compilar, crear una implementacion de esta funcion en ASM que al menos vincule el nombre para poder compilar el proyecto.

extern GLfloat* asm_samplelight(GLuint samples, GLuint size, GLfloat light[4]);


// Ademas esta funcion llama a las siguientes funciones, las cuales pueden elegir de implementar como funciones aparte, o dentro de la misma funcion "asm_samplelight", las mismas son:

// Nota: NO es necesario para compilar, crear una implementacion de estas funciones en ASM que al menos vincule el nombre para poder compilar el proyecto.

// Realiza el producto cruz entre dos vectores y lo guarda en el primero.
extern void cross(GLfloat* u, GLfloat* v, GLfloat* n);

// Normaliza un vector de floating points
extern void normalize(GLfloat* n);

static int ccountersm = 0;
static int asmcountersm = 0;
static int caccumsm = 0;
static int asmaccumsm = 0;
static int ccountersl = 0;
static int asmcountersl = 0;
static int caccumsl = 0;
static int asmaccumsl = 0;
