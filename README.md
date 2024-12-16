# MatrixOperationsAssembly
Repositorio que implementa operaciones matriciales en ensamblador para el DSPIC33FJ32MC202. Incluye un switch para multiplicación, suma, resta, determinantes, transposición, obtención de mayor/menor, y ordenamiento ascendente/descendente de matrices 3x3 Se usa la memoria . 

El archivo P3.s es el código en lenguaje ensamblador en donde se encuentra la lógica de las matrices y sus operaciones. 
El archivo p33FJ32MC202.gld es el archvo linker. 
El archivo p33FJ32MC202.inc es el archvo header.

Dentro de la herramienta MPLABX se puede observar el funcionamiento de las matrices en la memoria, mediante la herramienta de file registers a partir de la posición 0x0800.

## Organización de las Matrices en Memoria
Las matrices se almacenan en memoria en posiciones específicas:

Matriz A: Comienza en la dirección 0x0800, con las celdas organizadas por filas consecutivas.
Matriz B: Comienza en la dirección 0x0808, también organizada por filas consecutivas.
Matriz C (resultado): Comienza en la dirección 0x0840 y se usa para almacenar los resultados de las operaciones.
Por ejemplo, para la Matriz A:

0x0800 contiene A[0][0]
0x0802 contiene A[0][1]
0x0804 contiene A[0][2]
Y así sucesivamente, respetando un incremento de 0x10 por fila.
## Lógica de Operaciones
El programa utiliza un selector (W10) para determinar la operación a realizar. Cada caso implementa una operación específica, como:

Case 0: Multiplicación de matrices.
Case 4 y 5: Cálculo del determinante para las matrices A y B.
Case 10 y 11: Ordenamiento de las matrices A y B de forma ascendente y descendente, respectivamente.
## Uso de Memoria y Apuntadores
Las celdas de las matrices son accedidas dinámicamente mediante registros que actúan como punteros (W1, W2, ..., W9) para recorrer las filas y columnas.
Los resultados intermedios y las operaciones complejas, como el ordenamiento, aprovechan almacenamiento temporal en direcciones dedicadas (0x0880 en adelante).
Este enfoque permite trabajar con operaciones matriciales más complejas y evita la limitación impuesta por el número de registros disponibles.

## Configuración inicial de bits y registros.
Inicialización de matrices en memoria.
Implementación de cada operación dentro de una estructura de casos (Switch).
Resultados almacenados en la Matriz C para su posterior uso o verificación.
