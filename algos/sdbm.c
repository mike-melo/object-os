#include <stdio.h>
#include <stdlib.h>


unsigned long
    sdbm(str)
    unsigned char *str;
    {
        unsigned long hash = 0;
        int c;

        while (c = *str++)
            hash = c + (hash << 6) + (hash << 16) - hash;

        return hash;
    }
 unsigned long
    hash(unsigned char *str)
    {
        unsigned long hash = 5381;
        int c;

        while (c = *str++) {
	printf("\nchar is %c -> %d", c, c);        
    hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
	printf("\nhash is %lu", hash);
	}
        return hash;
    }

int main(int argc, char *argv[]) {

  const char *str = "Hello World";
  printf("\nThe hash is %lu", sdbm(str));
  return 0;
}
