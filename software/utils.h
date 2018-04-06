#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <locale.h>
#include <wchar.h>			// printing to OpenTerm
//#include <ncurses.h>																				//need -lncursesw
typedef		long long int				LLI;
typedef		long long unsigned int		LLUI;	//uint64_t

char Getch(void);
void getTime(char* str);
int isFileExist(char* filename);
int createDir(char* dirName);
LLI getMilliseconds();
FILE* OpenTerm();

#define DEBUG

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
#define PRINT(...) printw(__VA_ARGS__)																//need -lncursesw <ncurses.h>
#define REFRESH { refresh(); timeout(0); }															//need -lncursesw <ncurses.h>
#define ENDWIN { endwin(); setlocale(LC_ALL, "C"); }												//need -lncursesw <ncurses.h>
#define INITSCR { setlocale(LC_ALL, ""); initscr(); scrollok(stdscr, TRUE); noecho(); }				//need -lncursesw <ncurses.h>
#endif

#endif