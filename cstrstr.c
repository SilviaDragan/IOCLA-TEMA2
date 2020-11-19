#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int i, j, temp, copy;
void cstrstr(int *index, char *source, char *find, int l_source, int l_find) {
	
	for( i = 0; i < l_source; i++) {
		temp = i;
		for(j = 0; j < l_find; j++) {
			if(source[temp] != find[j]) {
				break;
			}
			temp++;
			if(j == l_find - 1) {
				(*index) = i;
				return; 
			}
		}
	}

}

int main() {
	char *x = "Ana are mere si mere si pere";
	char *y = "mere";

	int *i = calloc(1, sizeof(int));
	cstrstr(i, x, y, 29, 4);
	printf("%d\n", *i);
	return 0;
}