#include <stdlib.h>
#include <stdio.h>

unsigned int custom(const char *str) {
    unsigned int hash = 0;
	int c;
	 while (c = *str++) {    
      hash += c; 
	}
    return hash + (hash << 1);
}

int main(int argc, char *argv[]) {
	printf("\nThe hash is %d", custom("ab"));
	printf("\nThe hash is %d", custom("ba"));
	return 0;
}