#define _XOPEN_SOURCE 700
#define _GNU_SOURCE

#ifdef WINDOWS
#include <io.h>				// createDir
#include <conio.h>
#else
#include <termios.h>		// Getch
#include <stdlib.h>			// OpenTerm
#include <fcntl.h>			// OpenTerm
#include <string.h>			// OpenTerm
#include <unistd.h>			// OpenTerm
#endif

#include "utils.h"
#include <time.h>			// getTime
#include <sys/timeb.h>		// getMilliseconds
#include <sys/stat.h>		// isFileExist createDir



/* Read 1 character - echo defines echo mode */
char Getch()
{
#ifdef WINDOWS
	return _getch();
#else
	struct termios old, new;
	int echo = 0;
	{	// Initialize new terminal i/o settings
		tcgetattr(0, &old); /* grab old terminal i/o settings */
		new = old; /* make new settings same as old settings */
		new.c_lflag &= ~ICANON; /* disable buffered i/o */
		new.c_lflag &= echo ? ECHO : ~ECHO; /* set echo mode */
		tcsetattr(0, TCSANOW, &new); /* use these new terminal i/o settings now */
	}
	char ch = getchar();
	{	// Restore old terminal i/o settings
		tcsetattr(0, TCSANOW, &old);
	}
	return ch;
#endif
}

void getTime(char* str)
{
	time_t timer;
	struct tm* tm_info;
	time(&timer);
	tm_info = localtime(&timer);
	strftime(str, 26, "%Y-%m-%d_%H:%M:%S", tm_info);
}

LLI getMilliseconds()
{
	struct timeb time;
	ftime(&time);
	return time.time*1000ll + time.millitm;
}

int isFileExist(char* filename)
{
	struct stat st = {0};
	return stat(filename, &st) != -1;
}

int createDir(char* dirName)
{
#ifdef WINDOWS
	return mkdir(dirName);
#else
	return mkdir(dirName, 0755);
#endif
}

FILE* Open_X_Term()
{
#ifdef WINDOWS
	return NULL;
#else
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
		perror("Open_X_Term - get slave name (ptsname_r)");
		setlocale(LC_ALL, "C");
		return 0;
	}
	printf("PT master: %d\n", masterPT);
	printf("PT slavename: %s\n", slavename);

	sprintf(geometry,"-geometry 200x50+50+50");
	snprintf(addr, sizeof(addr), "-S%s/%d", strrchr(slavename,'/')+1, masterPT);
	printf("xterm: %s %s\n", addr, geometry);
	int fr = 0;
	if(!(fr = fork()))
	{
		execlp("xterm", "xterm", addr, (char*)0);
		setlocale(LC_ALL, "");
		_exit(1);
	}
	else if (fr==-1)
	{
		printf("Cannot fork xterm! (%d)\n", fr);
		setlocale(LC_ALL, "C");
		return NULL;
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
#endif
}


/*
char *trimWhiteSpace(char *str)
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
