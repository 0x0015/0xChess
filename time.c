#include <stddef.h>
#include <sys/time.h>

unsigned int millis(){
	struct timeval current_time;
	gettimeofday(&current_time, NULL);
	return((current_time.tv_usec + (current_time.tv_sec * 1000000))/1000);
}
