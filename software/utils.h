#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <locale.h>

typedef		long long int				LLI;
typedef		long long unsigned int		LLUI;	//uint64_t

#ifdef WINDOWS
#include <ncursesw/ncurses.h>
#else
#include <wchar.h>			// printing to X_Term
#include <ncurses.h>
#endif

//#define DEBUG
#ifdef DEBUG
#define DGETCH Getch();
#define DPRINT(...) printf(__VA_ARGS__)
#define PRINT(...) printf(__VA_ARGS__)
#define REFRESH ;
#define ENDWIN ;
#define INITSCR ;
#else
#define DGETCH ;
#define DPRINT(...)
#define PRINT(...) printw(__VA_ARGS__)
#define REFRESH { refresh(); timeout(0); }
#define ENDWIN { endwin(); setlocale(LC_ALL, "C"); }
#define INITSCR { setlocale(LC_ALL, ""); initscr(); scrollok(stdscr, TRUE); noecho(); }
#endif

char Getch(void);
void getTime(char* str);
int isFileExist(char* filename);
int createDir(char* dirName);
LLI getMilliseconds();
FILE* Open_X_Term();

#endif
