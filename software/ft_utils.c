#include "ft_utils.h"
#include <stdio.h>
#include <unistd.h>

// ERROR func - message : sub_func(error code)
char		FTUTIL_List_SerialNumbers[FTUTIL_MAX_DEVICES][FTUTIL_EEPROM_SIZE];
char		FTUTIL_List_Descriptions[FTUTIL_MAX_DEVICES][FTUTIL_EEPROM_SIZE];
int			FTUTIL_List_DevicesCount = 0;

FT_STATUS FTUTIL_List()
{
	FT_STATUS	ftStatus;
	DWORD		libraryVersion = 0;
	char*		pcBufLD[FTUTIL_MAX_DEVICES + 1];
	//DWORD		iNumDevs = 0;
	//system("rmmod ftdi-sio");
	//system("rmmod usbserial");
	if ( ( ftStatus = FT_GetLibraryVersion(&libraryVersion) ) == FT_OK )
		printf("FTDI library version = 0x%x\n", (unsigned int)libraryVersion);
	else
	{
		printf("ERROR FTUTIL_List - Failed reading FTDI library version : FT_GetLibraryVersion(%d)\n", (int)ftStatus);
		return ftStatus;
	}
	for(DWORD i = 0; i<FTUTIL_MAX_DEVICES-1; i++)
		pcBufLD[i] = FTUTIL_List_SerialNumbers[i];
	ftStatus = FT_ListDevices(pcBufLD, &FTUTIL_List_DevicesCount, FT_LIST_ALL | FT_OPEN_BY_SERIAL_NUMBER);
	if ( ftStatus == FT_OK )
		printf("FTDI devices count = %d\n", FTUTIL_List_DevicesCount);
	else
	{
		printf("ERROR FTUTIL_List - Failed to get serial numbers FT_ListDevices(%d)\n", (int)ftStatus);
		return ftStatus;
	}
	for(DWORD i = 0; i<FTUTIL_MAX_DEVICES-1; i++)
		pcBufLD[i] = FTUTIL_List_Descriptions[i];
	ftStatus = FT_ListDevices(pcBufLD, &FTUTIL_List_DevicesCount, FT_LIST_ALL | FT_OPEN_BY_DESCRIPTION );
	if ( ftStatus == FT_OK )
	{
		for(int i = 0; i < FTUTIL_List_DevicesCount; i++)
			printf("#%d    SerialNumber=%s Description=%s\n", i, FTUTIL_List_SerialNumbers[i], FTUTIL_List_Descriptions[i]);
	}
	else
	{
		printf("ERROR FTUTIL_List - Failed to get  descriptions FT_ListDevices(%d)\n", (int)ftStatus);
		return ftStatus;
	}
	return FT_OK;
	/*ftStatus = FT_CreateDeviceInfoList(&iNumDevs);
	if(ftStatus != FT_OK) { printf("Error: FT_CreateDeviceInfoList(%d)\n", (int)ftStatus); return 1; }
	else printf("FT_CreateDeviceInfoList iNumDevs=%d\n", iNumDevs);*/
	/*ftStatus = FT_GetDeviceInfoList(&DevInfoList, &iNumDevs);
	if (ftStatus != FT_OK) { printf("Error: FT_GetDeviceInfoList(%d)\n", (int)ftStatus); return 1; }
	else {
		printf("FT_GetDeviceInfoList iNumDevs=%d\n", iNumDevs);
		for(i = 0; i < iNumDevs; i++) {
			printf("device %d\n", i);
			printf("    SerialNumber=%s\n", DevInfoList[i].SerialNumber);
			printf("    Description=%s\n", DevInfoList[i].Description);
			printf("    Flags=0x%x\n", DevInfoList[i].Flags);
			printf("    Type=0x%x\n", DevInfoList[i].Type);
			printf("    ID=0x%x\n", DevInfoList[i].ID);
			printf("    LocId=0x%x\n", DevInfoList[i].LocId);
			printf("    ftHandle=0x%x\n\n", DevInfoList[i].ftHandle);
		}
	}*/
	/*ftStatus = FT_ListDevices(&iNumDevs, NULL, FT_LIST_NUMBER_ONLY);
	if(ftStatus != FT_OK) { printf("Error: FT_ListDevices(%d)\n", (int)ftStatus); return 1; }
	else printf("FT_ListDevices iNumDevs=%d\n", iNumDevs);*/
}

FT_STATUS FTUTIL_Open(int deviceListIndex, ULONG baudRate, UCHAR wordLength, UCHAR stopBits, UCHAR parity, FT_HANDLE* pHandle)
{
	FT_STATUS ftStatus = FT_Open(deviceListIndex, pHandle);
	if (ftStatus == FT_OK)
		printf("FT_Open(#%d) handle=0x%p\n", deviceListIndex, pHandle);
	else
	{
		printf("ERROR FTUTIL_Open - Failed to open device #%d : FT_Open(%d)\n", deviceListIndex, ftStatus);
		return ftStatus;
	}
	//FT_ResetDevice(ftHandle); TRY
	if ( (ftStatus = FT_SetBaudRate(*pHandle, baudRate)) == FT_OK)
		printf("FT_SetBaudRate(%d)\n", baudRate);
	else
	{
		printf("ERROR FTUTIL_Open - Failed to set baud rate : FT_SetBaudRate(%d)\n", (int)ftStatus);
		return ftStatus;
	}
	if ( (ftStatus = FT_SetDataCharacteristics(*pHandle, wordLength, stopBits, parity)) == FT_OK)
		printf("FT_SetDataCharacteristics(BITS:%d STOP_BITS:%d PARITY:%d)\n", wordLength, stopBits, parity);
	else
	{
		printf("ERROR FTUTIL_Open - Failed to configure : FT_SetDataCharacteristics(%d)\n", (int)ftStatus);
		return ftStatus;
	}
	//FT_SetUSBParameters
	UCHAR Latency;
	if ( (ftStatus = FT_GetLatencyTimer(*pHandle, &Latency)) == FT_OK)
		printf("FT_GetLatencyTimer = %d\n", Latency);
	else
	{
		printf("ERROR FTUTIL_Open - Failed FT_GetLatencyTimer(%d)\n", (int)ftStatus);
		return ftStatus;
	}
	return FT_OK;
}

FT_STATUS FTUTIL_WriteData(FT_HANDLE ftHandle, LPVOID transmitData, DWORD bytesToWrite)
{
	DWORD dwBytesWritten = 0;
	FT_STATUS ftStatus = FT_Write(ftHandle, transmitData, bytesToWrite, &dwBytesWritten);
	if (ftStatus != FT_OK)
		printf("ERROR FTUTIL_WriteData - FT_Write(%d)\n", (int)ftStatus);
	if (dwBytesWritten != bytesToWrite) {
		printf("ERROR FTUTIL_WriteData - FT_Write only wrote %d (of %d) bytes\n", (int)dwBytesWritten,  bytesToWrite);
		ftStatus = FT_OTHER_ERROR;
	}
	//usleep(1000);
	return ftStatus;
}

FT_STATUS FTUTIL_WaitData(FT_HANDLE ftHandle, DWORD bytesWait, int exactlyBytes, LPDWORD bytesAvailable, int timeout, int verbose)
{
	int counter = 0;
	*bytesAvailable = 0;
	if (verbose)
		printf("Waiting data (%d)... \n", bytesWait);
	if ( bytesWait==0 )
		return FT_OK;
	DWORD bytes = 0;
	do
	{
		//DWORD temp = 0;
		FT_STATUS ftStatus = FT_GetQueueStatus(ftHandle, &bytes);
		if ( ftStatus!=FT_OK ) {
			printf("ERROR FTUTIL_WaitData - FT_GetQueueStatus - Failed to get number of bytes available to read (error %d)\n", ftStatus);
			*bytesAvailable = bytes;
			return ftStatus;
		}
		counter++;
		if ( (timeout>=0) && (counter*10>timeout) ) {
			printf("ERROR FTUTIL_WaitData - Waiting timeout expired %d ms. Available bytes = %d\n", timeout, bytes);
			*bytesAvailable = bytes;
			return FT_OTHER_ERROR;
		}
		if (bytes<bytesWait)
			usleep(10000);
		//if (verbose)
		//	printf("%d ", bytes);
		//bytes = temp;
	}
	while (bytes<bytesWait);
	*bytesAvailable = bytes;
	//if (verbose)
	//	printf("\n");
	if (exactlyBytes) {
		if (bytes!=bytesWait) {
			printf("ERROR FTUTIL_WaitData - Available invalid number of bytes %d (expected %d)\n", bytes, bytesWait);
			return FT_OTHER_ERROR;
		}
	}
	else if (bytes<bytesWait) {
		printf("ERROR FTUTIL_WaitData - Available invalid number of bytes %d (expected %d)\n", bytes, bytesWait);
		return FT_OTHER_ERROR;
	}
	return FT_OK;
}

FT_STATUS FTUTIL_ReadData(FT_HANDLE ftHandle, LPVOID readData, DWORD bytesToRead, LPDWORD bytesReaded)
{
	*bytesReaded = 0;
	FT_STATUS ftStatus = FT_Read(ftHandle, readData, bytesToRead, bytesReaded);
	if (ftStatus!=FT_OK) {
		printf("ERROR FTUTIL_ReadData - FT_Read(%d)\n", ftStatus);
		return ftStatus;
	}
	if ( *bytesReaded != bytesToRead ){
		printf("ERROR FTUTIL_ReadData - Readed invalid number of bytes %d (expected %d)\n", *bytesReaded, bytesToRead);
		return FT_OTHER_ERROR;
	}
	return FT_OK;
}