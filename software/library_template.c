#include "library_template.h"
#include "utils.h"
#include <string.h>			// list_devices open_device
#include <pthread.h>
#include <unistd.h>			// usleep

FT_HANDLE ftHandle = NULL;
BYTE ftReceivedBytes[FTUTIL_BUFFER_SIZE];
pthread_mutex_t PublicMutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t WorkingMutex = PTHREAD_MUTEX_INITIALIZER;
pthread_t WorkingThreadHandle = (pthread_t)NULL;

FT_STATUS TransmitCommand(int cmd, DWORD waitBytes, int verbose, BYTE data[], int data_size);
int CommandGetInt(BYTE cmd);
float CommandGetFloat(BYTE cmd);
int CommandSetInt(BYTE cmd, DWORD value);
int CommandGetInt(BYTE cmd);
void* WorkingThread(void* var);


int list_devices(int* count, char* serials, char* descriptions)
{
	pthread_mutex_lock(&PublicMutex);
	FT_STATUS ftStatus;
	if ( (ftStatus = FTUTIL_List()) != FT_OK )
	{
		printf("\nERROR list_devices - FTUTIL_List(%d)\n", (int)ftStatus);
		pthread_mutex_unlock(&PublicMutex);
		return (int)ftStatus;
	}
	if (serials!=NULL)
		memcpy(serials, FTUTIL_List_SerialNumbers, FTUTIL_MAX_DEVICES*FTUTIL_EEPROM_SIZE);
	if (descriptions!=NULL)
		memcpy(descriptions, FTUTIL_List_Descriptions, FTUTIL_MAX_DEVICES*FTUTIL_EEPROM_SIZE);
	if (count!=NULL)
		*count = FTUTIL_List_DevicesCount;
	pthread_mutex_unlock(&PublicMutex);
	return RET_OK;
}

int open_device(char* serialNumber)
{
	pthread_mutex_lock(&PublicMutex);
	FT_STATUS ftStatus;
	if (ftHandle)
	{
		printf("\nERROR open_device(0x%p) - already opened\n", ftHandle);
		pthread_mutex_unlock(&PublicMutex);
		return RET_OPENED;
	}
	if ( (ftStatus = FTUTIL_List()) != FT_OK )
	{
		printf("\nERROR open_device - FTUTIL_List(%d)\n", (int)ftStatus);
		pthread_mutex_unlock(&PublicMutex);
		return (int)ftStatus;
	}
	int index = -1;
	if (serialNumber!=0)
	{
		for(int i = 0; i<FTUTIL_List_DevicesCount; i++)
		{
			if (strcmp(serialNumber, FTUTIL_List_SerialNumbers[i])==0)
			{
				index = i;
				break;
			}
		}
		if (index<0)
		{
			printf("Device with serial number(%s) not found\n", serialNumber);
			pthread_mutex_unlock(&PublicMutex);
			return RET_ERROR;
		}
	}
	if ( (ftStatus = FTUTIL_Open(index<=-1?0:index, 500000, FT_BITS_8, FT_STOP_BITS_1, FT_PARITY_NONE, &ftHandle)) != FT_OK )
	{
		printf("\nERROR open_device(0x%p) - FTUTIL_Open(%d)\n", ftHandle, (int)ftStatus);
		ftHandle = NULL;
		pthread_mutex_unlock(&PublicMutex);
		return (int)ftStatus;
	}
	printf("open_device(0x%p)\n", ftHandle);
	//int int1 = CommandGetInt(cmd_GET_INT);
	//double float1 = CommandGetFloat(cmd_GET_FLOAT);
	pthread_mutex_unlock(&PublicMutex);
	return RET_OK;
}


int close_device()
{
	pthread_mutex_lock(&PublicMutex);
	int ret = RET_OK;
	if (!ftHandle)
	{
		printf("\nERROR close_device(0x%p) - not opened\n", ftHandle);
		ret = RET_NOT_OPENED;
	}
	else if (WorkingThreadHandle)
	{
		printf("\nERROR close_device(0x%p) - working\n", ftHandle);
		ret = RET_WORKING;
	}
	if (ret)
	{
		pthread_mutex_unlock(&PublicMutex);
		return ret;
	}
	FT_STATUS ftStatus = FT_Close(ftHandle);
	if (ftStatus != FT_OK)
	{
		printf("\nERROR close_device(0x%p) - FT_Close(%d)\n", ftHandle, (int)ftStatus);
		ftHandle = NULL;
		pthread_mutex_unlock(&PublicMutex);
		return (int)ftStatus;
	}
	printf("close_device(0x%p)\n", ftHandle);
	ftHandle = NULL;
	pthread_mutex_unlock(&PublicMutex);
	return RET_OK;
}


int purge()
{
	pthread_mutex_lock(&PublicMutex);
	int ret = RET_OK;
	if (!ftHandle)
	{
		printf("\nERROR purge(0x%p) - not opened\n", ftHandle);
		ret = RET_NOT_OPENED;
	}
	else if (WorkingThreadHandle)
	{
		printf("\nERROR purge(0x%p) - working\n", ftHandle);
		ret = RET_WORKING;
	}
	if (ret)
	{
		pthread_mutex_unlock(&PublicMutex);
		return ret;
	}
	FT_STATUS ftStatus = FT_Purge(ftHandle, FT_PURGE_RX | FT_PURGE_TX);
	if ( ftStatus != FT_OK )
	{
		printf("\nERROR purge(0x%p) - FT_Purge(%d)\n", ftHandle, (int)ftStatus);
		pthread_mutex_unlock(&PublicMutex);
		return (int)ftStatus;
	}
	printf("purge(0x%p)\n", ftHandle);
	pthread_mutex_unlock(&PublicMutex);
	return RET_OK;
}


int start_work()
{
	pthread_mutex_lock(&PublicMutex);
	int ret = RET_OK;
	if (!ftHandle)
	{
		printf("\nERROR start_work(0x%p) - not opened\n", ftHandle);
		ret = RET_NOT_OPENED;
	}
	else if (WorkingThreadHandle)
	{
		printf("\nERROR start_work(0x%p) - already working\n", ftHandle);
		ret = RET_WORKING;
	}
	if (ret)
	{
		pthread_mutex_unlock(&PublicMutex);
		return ret;
	}
	/*int errno = pthread_mutex_init(&WorkingMutex, NULL);
	if (errno)
	{
		printf("\nERROR yattor_start(0x%p) - WorkingMutex: pthread_mutex_init(%d)\n", ftHandle, errno);
		pthread_mutex_unlock(&PublicMutex);
		return errno;
	}*/
	int errno = pthread_create(&WorkingThreadHandle, NULL, WorkingThread, NULL);//(void*)(long)t );
	if (errno)
	{
		WorkingThreadHandle = (pthread_t)NULL;
		printf("\nERROR start_work(0x%p) - pthread_create(%d)\n", ftHandle, errno);
		pthread_mutex_unlock(&PublicMutex);
		return errno;
	}

	printf("start_work(0x%p)\n", ftHandle);
	pthread_mutex_unlock(&PublicMutex);
	return RET_OK;
}

int working_expression = 1;

void* WorkingThread(void* var)
{
	if ( (int*)var ){;}
	FT_STATUS ftStatus;
	const int reading_bytes = 123;
	BYTE buffer[reading_bytes];
	do
	{
		DWORD ftAvailableBytes;
		int waitDataTimeout = 5000;
		if ( ( ftStatus = FTUTIL_WaitData(ftHandle, reading_bytes, 0, &ftAvailableBytes, waitDataTimeout, 0) ) != FT_OK )
		{
			printf("\nERROR WorkingThread(0x%p) - WaitData(%u)\n", ftHandle, ftStatus);
			WorkingThreadHandle = (pthread_t)NULL;
			return RV_WAIT_DATA;
		}
		DWORD ftReadedBytes;
		if (( ftStatus = FTUTIL_ReadData(ftHandle, buffer, reading_bytes, &ftReadedBytes) ) != FT_OK)
		{
			printf("\nERROR WorkingThread(0x%p) - ReadData(%u)\n", ftHandle, ftStatus);
			WorkingThreadHandle = (pthread_t)NULL;
			return RV_READ_DATA;
		}
		pthread_mutex_lock(&WorkingMutex);
		//WORK with buffer
		usleep(1000);
		if (0)//(error?)
		{
			printf("\nERROR WorkingThread(0x%p) - error?\n", ftHandle);
			WorkingThreadHandle = (pthread_t)NULL;
			pthread_mutex_unlock(&WorkingMutex);
			return RV_ERROR;
		}
		pthread_mutex_unlock(&WorkingMutex);
	}
	while (working_expression);
	printf("WorkingThread(0x%p) - finished\n", ftHandle);
	return RV_OK;
}


int is_working()
{
	pthread_mutex_lock(&PublicMutex);
	int ret = RET_OK;
	if (!ftHandle)
		ret = RET_NOT_OPENED;
	else if (!WorkingThreadHandle)
		ret = RET_NOT_WORKING;
	pthread_mutex_unlock(&PublicMutex);
	return ret;
}


int stop_work()
{
	pthread_mutex_lock(&PublicMutex);
	int ret = RET_OK;
	if (!ftHandle)
	{
		printf("\nERROR stop_work(0x%p) - not opened\n", ftHandle);
		ret = RET_NOT_OPENED;
	}
	else if (!WorkingThreadHandle)
	{
		printf("\nERROR stop_work(0x%p) - not working\n", ftHandle);
		ret = RET_NOT_WORKING;
	}
	if (ret)
	{
		pthread_mutex_unlock(&PublicMutex);
		return ret;
	}
	working_expression = 0;
	pthread_join(WorkingThreadHandle, NULL);
	WorkingThreadHandle = (pthread_t)NULL;
	printf("stop_work(0x%p)\n", ftHandle);
	pthread_mutex_unlock(&PublicMutex);
	sleep(1);
	return purge();
}


int command1()
{
	pthread_mutex_lock(&PublicMutex);
	pthread_mutex_lock(&WorkingMutex);
	if (!ftHandle)
	{
		printf("\nERROR command1(0x%p) - not opened\n", ftHandle);
		pthread_mutex_unlock(&WorkingMutex);
		pthread_mutex_unlock(&PublicMutex);
		return RET_NOT_OPENED;
	}
	if ( TransmitCommand(cmd_COMMAND1, 1, 1, NULL, 0)!=cmd_COMMAND1 )
	{
		pthread_mutex_unlock(&WorkingMutex);
		pthread_mutex_unlock(&PublicMutex);
		return RET_ERROR;
	}

	printf("command1(0x%p)\n", ftHandle);
	pthread_mutex_unlock(&WorkingMutex);
	pthread_mutex_unlock(&PublicMutex);
	return RET_OK;
}


FT_STATUS TransmitCommand(int cmd, DWORD waitBytes, int verbose, BYTE data[], int data_size)
{
	DWORD bytesAvailable;
	BYTE transmitData[256] = {HAND_SHAKE};
	FT_STATUS ftStatus = FT_OK;
	if ((ftStatus = FTUTIL_WriteData(ftHandle, transmitData, 1)) != FT_OK)
		return ftStatus;
	if (verbose)
		printf("transmit HAND_SHAKE 0x%x\n", HAND_SHAKE);
	if ((ftStatus = FTUTIL_WaitData(ftHandle, 1, 1, &bytesAvailable, 1000, verbose)) != FT_OK)
		return ftStatus;
	if ((ftStatus = FTUTIL_ReadData(ftHandle, ftReceivedBytes, 1, &bytesAvailable)) != FT_OK)
		return ftStatus;
	if (ftReceivedBytes[0]!=HAND_SHAKE)
	{
		printf("Received invalid replay HAND_SHAKE byte 0x%x\n", ftReceivedBytes[0]);
		return RET_ERROR;
	}
	else if (verbose)
		printf("receive HAND_SHAKE 0x%x\n", ftReceivedBytes[0]);

	transmitData[0] = cmd;
	for (int i = 1; i<=data_size; i++)
		transmitData[i] = data[i-1];
	if ((ftStatus = FTUTIL_WriteData(ftHandle, transmitData, 1+data_size)) != FT_OK)
		return ftStatus;
	if (verbose)
		printf("transmit command 0x%x\n", cmd);
	if (waitBytes>0)
	{
		if ((ftStatus = FTUTIL_WaitData(ftHandle, waitBytes, 1, &bytesAvailable, 5000, verbose)) != FT_OK)
			return ftStatus;
		if ((ftStatus = FTUTIL_ReadData(ftHandle, ftReceivedBytes, waitBytes, &bytesAvailable)) != FT_OK)
			return ftStatus;
		if (verbose)
			printf("data received (%u)\n", waitBytes);
		if (ftReceivedBytes[0]==cmd && bytesAvailable==waitBytes)
			return FT_OK;
		else
		{
			BYTE* d = ftReceivedBytes;
			printf("corrupt data: %2x %2x %2x %2x %2x %2x %2x %2x...\n", d[0], d[1], d[2], d[3], d[4], d[5], d[6], d[7]);
			return FT_IO_ERROR;
		}
	}
	return FT_OK;
}


int CommandSetInt(BYTE cmd, DWORD value)
{
	union
	{
		DWORD value;
		BYTE data[4];
	} u;
	u.value = value;
	FT_STATUS ftStatus = TransmitCommand(cmd, 1, 1, u.data, 4);
	if ( ftStatus!=FT_OK )
		printf("\nERROR CommandSetInt(0x%p) - cmd(0x%x)\n", ftHandle, cmd);
	return ftStatus;
}


int CommandGetInt(BYTE cmd)
{
	union
	{
		DWORD value;
		BYTE data[4];
	} u;
	FT_STATUS ftStatus = TransmitCommand(cmd, 5, 1, NULL, 0);
	if ( ftStatus!=FT_OK )
	{
		printf("\nERROR CommandGetInt(0x%p) - cmd(0x%x)\n", ftHandle, cmd);
		return ftStatus;
	}
	u.data[0] = ftReceivedBytes[1];
	u.data[1] = ftReceivedBytes[2];
	u.data[2] = ftReceivedBytes[3];
	u.data[3] = ftReceivedBytes[4];
	return u.value;
}


int CommandSetFloat(BYTE cmd, float value)
{
	union
	{
		float value;
		BYTE data[4];
	} u;
	u.value = value;
	FT_STATUS ftStatus = TransmitCommand(cmd, 1, 1, u.data, 4);
	if ( ftStatus!=FT_OK )
		printf("\nERROR CommandSetFloat(0x%p) - cmd(0x%x)\n", ftHandle, cmd);
	return ftStatus;
}


float CommandGetFloat(BYTE cmd)
{
	union
	{
		float value;
		BYTE data[4];
	} u;
	FT_STATUS ftStatus = TransmitCommand(cmd, 5, 1, NULL, 0);
	if ( ftStatus!=FT_OK )
	{
		printf("\nERROR CommandGetFloat(0x%p) - cmd(0x%x)\n", ftHandle, cmd);
		return ftStatus;
	}
	u.data[0] = ftReceivedBytes[1];
	u.data[1] = ftReceivedBytes[2];
	u.data[2] = ftReceivedBytes[3];
	u.data[3] = ftReceivedBytes[4];
	return u.value;
}
