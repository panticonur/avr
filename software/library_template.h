#ifndef LIBRARY_H
#define LIBRARY_H

#include "ft_utils.h"

#define HAND_SHAKE					0xAA
#define cmd_COMMAND1				0x01
#define cmd_GET_INT					0x02
#define cmd_GET_FLOAT				0x03

#define RET_OK						0
#define RET_ERROR					-1
#define RET_NOT_OPENED				-2
#define RET_OPENED					-3
#define RET_NOT_WORKING				-4
#define RET_WORKING					-5
#define YT_OFFSET_OUT_OF_DATA		-6
#define YT_NO_DATA					-7
#define YT_OPEN_FILE				-8
#define YT_WRITE_FILE				-9

#define RV_OK						(void*)0
#define RV_ERROR					(void*)1
#define RV_WAIT_DATA				(void*)2
#define RV_READ_DATA				(void*)3

//http://docencia.ac.upc.edu/FIB/USO/Bibliografia/unix-c-libraries.html

int list_devices(int* count, char* serials, char* descriptions);
int open_device(char* serialNumber);
int close_device();
int purge();
int start_work();
int is_working();
int stop_work();
int command1();

#endif