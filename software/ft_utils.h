#ifndef FT_UTILS_H
#define FT_UTILS_H

#if defined WINDOWS && !defined _WIN32
	#define _WIN32
#endif
#include "ftd2xx.h"

#define FTUTIL_MAX_DEVICES		128
#define FTUTIL_EEPROM_SIZE		64
#define FTUTIL_BUFFER_SIZE		64*1024
extern char		FTUTIL_List_SerialNumbers[][FTUTIL_EEPROM_SIZE];
extern char		FTUTIL_List_Descriptions[][FTUTIL_EEPROM_SIZE];
extern int		FTUTIL_List_DevicesCount;

FT_STATUS FTUTIL_List();
FT_STATUS FTUTIL_Open(int deviceListIndex, ULONG baudRate, UCHAR wordLength, UCHAR stopBits, UCHAR parity, FT_HANDLE* pHandle);
FT_STATUS FTUTIL_WriteData(FT_HANDLE, LPVOID, DWORD);
FT_STATUS FTUTIL_WaitData(FT_HANDLE, DWORD, int, LPDWORD, int, int);
FT_STATUS FTUTIL_ReadData(FT_HANDLE, LPVOID, DWORD, LPDWORD);

#endif