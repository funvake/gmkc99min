/*!@file  main.c
*  @brief “Hello, World!” in C89/C99
*
*  Due to the C89-compatibility requirement, `<stdbool.h>` is not
*  available. Ditto for `EXIT_SUCCESS` from `<stdlib.h>`. And, we
*  *must* have a `return` statement in `main` (optional in C99).
*/
#include <stdio.h>

int main (int argc, char* argv[]) {
   printf("%s #args: %d\n", argv[0], argc);
   printf("Hello, World!\n");
   return 0;
   }
