#define _XOPEN_SOURCE 700
#define _GNU_SOURCE
#include "utils.h"
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <termios.h>
#include <time.h>
#include <sys/stat.h>
#include <sys/timeb.h>
#include <string.h>
#include <wchar.h>
#include <unistd.h>

static struct termios old, new;

/* Initialize new terminal i/o settings */
void initTermios(int echo)
{
	tcgetattr(0, &old); /* grab old terminal i/o settings */
	new = old; /* make new settings same as old settings */
	new.c_lflag &= ~ICANON; /* disable buffered i/o */
	new.c_lflag &= echo ? ECHO : ~ECHO; /* set echo mode */
	tcsetattr(0, TCSANOW, &new); /* use these new terminal i/o settings now */
}

/* Restore old terminal i/o settings */
void resetTermios(void)
{
	tcsetattr(0, TCSANOW, &old);
}

/* Read 1 character - echo defines echo mode */
char getch_(int echo)
{
	char ch;
	initTermios(echo);
	ch = getchar();
	resetTermios();
	return ch;
}


char Getch(void)
{
	return getch_(0);
}

void getTime(char* str)
{
	time_t timer;
	struct tm* tm_info;
	time(&timer);
	tm_info = localtime(&timer);
	strftime(str, 26, "%Y-%m-%d_%H:%M:%S", tm_info);
}

int isFileExist(char* filename)
{
	struct stat st = {0};
	return stat(filename, &st) != -1;
}

int createDir(char* dirName)
{
	return mkdir(dirName, 0755);
}

LLI getMilliseconds()
{
	struct timeb time;
	ftime(&time);
	return time.time*1000ll + time.millitm;
}

/*
char *trimwhitespace(char *str)
{
	char *end;
	// Trim leading space
	while(isspace((unsigned char)*str)) str++;
	if (*str == 0)  // All spaces?
	  return str;
	// Trim trailing space
	end = str + strlen(str) - 1;
	while(end > str && isspace((unsigned char)*end)) end--;
	// Write new null terminator
	*(end+1) = 0;
	return str;
}
*/

/*int deleteMultiSpaces(char *str)
{
	int n = strlen(str);
	int i = 0;
	while (i<n)
	{
		if(str[i]==' ' && (str[i+1]==' ' || str[i-1]==' '))
		{
			for(int j=i; j<n; j++)
				str[j] = str[j+1];
			n--;
		}
		else
			i++;
	}
	str[n] = 0;
return n;
}*/


FILE* OpenTerm()
{
	setlocale(LC_ALL, "");
	// https://stackoverflow.com/questions/22200398/c-setup-pseudoterminal-and-open-with-xterm
	// https://www.x.org/archive/X11R6.7.0/doc/xterm.1.html
	int masterPT;
	char slavename[64], addr[64], geometry[64];
	FILE *term;
	masterPT = posix_openpt(O_RDWR);
	grantpt(masterPT);
	unlockpt(masterPT);
	if(ptsname_r(masterPT, slavename, sizeof(slavename)) < 0)
	{
		perror("OpenTerm - get slave name (ptsname_r)");
		setlocale(LC_ALL, "C");
		return 0;
	}
	printf("PT master: %d\n", masterPT);
	printf("PT slavename: %s\n", slavename);

	sprintf(geometry,"-geometry 200x50+50+50");
	snprintf(addr, sizeof(addr), "-S%s/%d", strrchr(slavename,'/')+1, masterPT);
	printf("xterm: %s %s\n", addr, geometry);
	if(!fork())
	{
		execlp("xterm", "xterm", addr, (char*)0);
		setlocale(LC_ALL, "");
		_exit(1);
	}
	term = fopen(slavename, "w, ccs=UNICODE");
	/*if(fwide(term, 0) == 0)
	{
		if(fwide(term, 1) <= 0)
			printf("could not switch to wide char mode!\n");
		else
			printf("switched to wide char mode!\n");
	}*/
	if(fwide(term, 1) > 0)
		printf("switched to wide char mode!\n");
	fwprintf(term, L"X-terminal\n");
	setlocale(LC_ALL, "C");
	return term;
}
