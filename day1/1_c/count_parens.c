
#include <stdio.h>

int main(void) {
	int c = 0;
	int count = 0;
	while ((c = getchar()) != EOF) {
		if (c == '(')
			count++;
		else if (c == ')')
			count--;
	}
	printf("%d\n", count);
}