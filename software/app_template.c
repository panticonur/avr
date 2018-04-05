#include <stdlib.h>
#include <string.h>
#include "ft_utils.h"
#include "utils.h"
#include <unistd.h>

#define menu_PLEASE						0
#define menu_COMMAND1					1
#define menu_COMMAND2					2
#define menu_COMMAND3					2
#define menu_SET_STRING_VALUE1			3
#define menu_SET_INT_VALUE1				4

//#define NO_DEVICE

int main(int argc, char **argv)
{
	FT_STATUS ftStatus = FT_OK;
	FT_HANDLE ftHandle = NULL;
	BYTE ftReceivedBytes[FTUTIL_BUFFER_SIZE];
	int menu = menu_PLEASE;
	char StringValue1[256] = "temp";
	int IntValue1 = 1;
	int working = 0;

	printf("\n\n\n****************\n");

	for (int i = 1; i < argc; ++i) {
		printf("argv[%d]: %s\n", i, argv[i]);
		double val = strtod(argv[i], NULL);
		if (i==1 && strlen(argv[i])>0)
			strcpy(StringValue1, argv[i]);
		else if (i==2)
			IntValue1 = val;
	}

	printf("args: 1) StringValue1 = <%s>\n", StringValue1);
	printf("      2) IntValue1 = <%d>\n", IntValue1);
	printf("\n");

	if ( (ftStatus = FTUTIL_List()) != FT_OK )
		return (int)ftStatus;

	#ifndef NO_DEVICE
	if ( (ftStatus = FTUTIL_Open(0, 9600, FT_BITS_8, FT_STOP_BITS_2, FT_PARITY_ODD, &ftHandle)) != FT_OK )
		return (int)ftStatus;
	#endif

	do
	{

		if (menu==menu_PLEASE)
		{
			char time_str[50];
			getTime(time_str);
			printf("---------------- %s\r\n", time_str);
			if (!working)
			{
				printf("%d) COMMAND1\r\n", menu_COMMAND1);
				printf("%d) COMMAND2\n", menu_COMMAND2);
				printf("%d) set StringValue1 <%s>\n", menu_SET_STRING_VALUE1, StringValue1);
				printf("%d) set IntValue1 <%d>\n", menu_SET_INT_VALUE1, IntValue1);
				printf("0) exit\n");
			}
			else
				printf("press SPACE to stop working\n");
			menu = -1;
			while (menu==-1)
			{
				int g = Getch();
				menu = g - '0';
				if (menu<0 || menu>9)
					menu = -1;
				if (working)
					menu = g==' ' ? menu_COMMAND3 : -1;
			}
		}

		if (!working && menu)
		{
			printf("purge USB buffer\n");
			#ifndef NO_DEVICE
			if ( (ftStatus = FT_Purge(ftHandle, FT_PURGE_RX | FT_PURGE_TX)) != FT_OK )
			{
				printf("ERROR FT_Purge(%d)\n", (int)ftStatus);
				return (int)ftStatus;
			}
			#endif
		}

		if (menu==menu_COMMAND1)
		{
			DWORD bytesAvailable;
			BYTE transmitData[256] = {0x01, 0x02, 0x03};

			if ((ftStatus = FTUTIL_WriteData(ftHandle, transmitData, 3)) != FT_OK)
				return ftStatus;

			if ((ftStatus = FTUTIL_WaitData(ftHandle, /*bytesWait=*/ 5, /*exactlyBytes=0/1*/ 1, &bytesAvailable, /*timeout=*/ 1000, /*verbose=0/1*/ 1)) != FT_OK)
				return ftStatus;

			if ((ftStatus = FTUTIL_ReadData(ftHandle, /*readData*/ ftReceivedBytes, /*bytesToRead=*/ 5, &bytesAvailable)) != FT_OK)
				return ftStatus;

			menu = menu_PLEASE;
		}

		else if (menu==menu_COMMAND2)
		{
			working = 1;
			sleep(1);
			menu = menu_PLEASE;
		}

		else if (menu==menu_COMMAND3)
		{
			working = 0;
			menu = menu_PLEASE;
		}

		else if (menu==menu_SET_STRING_VALUE1)
		{
			printf("Now enter string: ");
			fgets(StringValue1, 255, stdin);
			if ((strlen(StringValue1)>0) && (StringValue1[strlen(StringValue1)-1]=='\n'))
				StringValue1[strlen(StringValue1)-1] = '\0';
			printf("StringValue1 = %s\n", StringValue1);
			menu = menu_PLEASE;
		}

		else if (menu==menu_SET_INT_VALUE1)
		{
			char string[256] = "";
			printf("Now enter int value1: ");
			fgets(string, 255, stdin);
			if ((strlen(string)>0) && (string[strlen(string)-1]=='\n'))
				string[strlen(string)-1] = '\0';
			long value = atoi(string);
			IntValue1 = value;
			printf("IntValue1 = %d\n", IntValue1);
			menu = menu_PLEASE;
		}

		else
			menu = -1;
	}
	while (menu>=menu_PLEASE);

	#ifndef NO_DEVICE
	if ( (ftStatus = FT_Close(ftHandle)) != FT_OK )
	{
		printf("ERROR FT_Close(%d)\n", (int)ftStatus);
		return (int)ftStatus;
	}
	#endif

	printf("app stopped\n");
	return 0;
}
