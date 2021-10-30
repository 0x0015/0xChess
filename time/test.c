#include <stdio.h>
#include <sys/time.h>


	unsigned int millis = 0;
	struct timeval current_time;
	gettimeofday(&current_time, NULL);
	millis = (current_time.tv_usec + (current_time.tv_sec * 1000000))/1000;
	printf("%u", millis);
	return(0);
}
