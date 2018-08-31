/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdlib.h>
#include "xparameters.h"
#include "xgpio.h"
#include "platform.h"
#include "xil_printf.h"
#include "xintc.h"
#include "xtmrctr.h"
#include "xaxidma.h"
#include "stim.h"
#include "fft.h"
#include "xuartlite_l.h"
#include "user.h"

void which_fft_param(fft_t* p_fft_inst);
extern int sig_two_sine_waves[FFT_MAX_NUM_PTS];
int sig_two_sine_import[FFT_MAX_NUM_PTS];
extern int s2mm_risingedge;
extern int mm2s_risingedge;

int main()
{
	int 			status;
	char         	c;
	fft_t*       	p_fft_inst;
	cplx_data_t* 	stim_buf;
	cplx_data_t* 	result_buf;
	char*			c_array;
	int 			import_ii;
	int 			ii = 0;

	init_platform();

	/* Create FFT object */
	p_fft_inst = fft_create
	(
		XPAR_GPIO_0_DEVICE_ID,
		XPAR_AXIDMA_0_DEVICE_ID,
		INTC_DEVICE_ID,
		TIMER_DEVICE_ID,
		DMA_RX_INT_ID,
		DMA_TX_INT_ID,
		TIMER_INT_ID
	);
    if (p_fft_inst == NULL)
    {
    	xil_printf("ERROR! Failed to create FFT instance.\n\r");
    	return -1;
    }


    // Allocate data buffers
	result_buf = (cplx_data_t*) malloc(sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);
    if (result_buf == NULL)
    {
    	xil_printf("ERROR! Failed to allocate memory for the result buffer.\n\r");
    	return -1;
    }

    stim_buf = (cplx_data_t*) malloc(sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);
	if (stim_buf == NULL)
	{
		xil_printf("ERROR! Failed to allocate memory for the stimulus buffer.\n\r");
		return -1;
	}

	// Allocate UART buffers
	c_array = (char*) malloc(sizeof(char)*15);

    // Fill stimulus buffer with some signal
    memcpy(stim_buf, sig_two_sine_waves, sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);

    // Main control loop
    while(1){

    	// Get command
    	xil_printf("What would you like to do?\n\r");
    	xil_printf("0: Print current FFT parameters\n\r");
    	xil_printf("1: Change FFT length\n\r");
    	xil_printf("2: Perform FFT using current parameters\n\r");
    	xil_printf("3: Import stimulus FFT operation\n\r");
    	xil_printf("4: Export results of previous FFT operation\n\r");
    	xil_printf("5: Export stimulus FFT operation\n\r");
    	xil_printf("6: Quit\n\r");
    	Listen:
    	c = XUartLite_RecvByte(UART_LITE_BASE);
    	if (c == '0'){
    		xil_printf("---------------------------------------------\n\r");
    		fft_print_params(p_fft_inst);
    		xil_printf("---------------------------------------------\n\r");
    	}else if (c == '1'){ // Change parameters
    		which_fft_param(p_fft_inst);
    	}else if (c == '2'){ // Run FFT
    		// Make sure the buffer is clear before we populate it (this is generally not necessary and wastes time doing memory accesses, but for proving the DMA working, we do it anyway)
			memset(result_buf, 0, sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);

			status = fft(p_fft_inst, (cplx_data_t*)stim_buf, (cplx_data_t*)result_buf);
			if (status != FFT_SUCCESS)
			{
				xil_printf("ERROR! FFT failed.\n\r");
				return -1;
			}
    		xil_printf("---------------------------------------------\n\r");
			xil_printf("Conducting time is roughly below than %d (us) with clock of %d (MHz).\n\r", (s2mm_risingedge - mm2s_risingedge)*10, (XPAR_MICROBLAZE_CORE_CLOCK_FREQ_HZ/1000000));
//			xil_printf("Transfer cycles: %d (cycles).\n\r", (s2mm_risingedge - mm2s_risingedge)*NO_CYCLES_PER_US);
			xil_printf("FFT complete!\n\r");
    		xil_printf("---------------------------------------------\n\r");
    	}else if (c == '3'){
    		import_ii = 0;
    		while(1){
    			c_array[ii] = XUartLite_RecvByte(UART_LITE_BASE);
    			if (c_array[ii]== '\r')
    				goto Exit;
    			else if (c_array[ii] == '\n'){
    				sig_two_sine_import[import_ii++] = atoi(c_array);
    				free(c_array);
					ii = 0;
    			}
    			else
    				ii++;
    		}
    		Exit:
//				xil_printf("%d \r",sig_two_sine_import[2]);
				memcpy(stim_buf, sig_two_sine_import, sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);

    	}else if (c == '4'){
    		fft_export_result_buf(p_fft_inst);
    		goto Listen;
    	}else if (c == '5'){
    		fft_export_sine_import(sig_two_sine_import);
			goto Listen;
    	}else if (c == '6'){
    		xil_printf("Okay, exiting...\n\r");
    		break;
    	}else {
    		xil_printf("Invalid character. Please try again.\n\r");
    	}
    }
    free(stim_buf);
    free(result_buf);
    fft_destroy(p_fft_inst);
    return 0;

}// end int main


/*****************************************************************************/
/*
*
* This function is used to export and import information through UART
* @param	p_fft_inst is a pointer to the instance of the FFT.
* @note		None.
*
******************************************************************************/

void which_fft_param(fft_t* p_fft_inst)
{
	// Local variables
	char c;

//	xil_printf("Okay, which parameter would you like to change?\n\r");
//	xil_printf("0: Point length\n\r");
//	xil_printf("1: Exit\n\r");
//	while (1)
//	{
//		c = XUartLite_RecvByte(UART_LITE_BASE);
//		if (c == '0')
//		{
			xil_printf("What would you like to set the FFT point length to? Type:\n\r");
			xil_printf("0: FFT point length = 16\n\r");
			xil_printf("1: FFT point length = 32\n\r");
			xil_printf("2: FFT point length = 64\n\r");
			xil_printf("3: FFT point length = 128\n\r");
			xil_printf("4: FFT point length = 256\n\r");
			xil_printf("5: FFT point length = 512\n\r");
			xil_printf("6: FFT point length = 1024\n\r");
			xil_printf("7: Exit\n\r");
			c = XUartLite_RecvByte(UART_LITE_BASE);
			while (1)
			{
				if (c == '0')
				{
					xil_printf("Okay, setting the core to perform a 16-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 16);
					break;
				}
				else if (c == '1')
				{
					xil_printf("Okay, setting the core to perform a 32-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 32);
					break;
				}
				else if (c == '2')
				{
					xil_printf("Okay, setting the core to perform a 64-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 64);
					break;
				}
				else if (c == '3')
				{
					xil_printf("Okay, setting the core to perform a 128-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 128);
					break;
				}
				else if (c == '4')
				{
					xil_printf("Okay, setting the core to perform a 256-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 256);
					break;
				}
				else if (c == '5')
				{
					xil_printf("Okay, setting the core to perform a 512-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 512);
					break;
				}
				else if (c == '6')
				{
					xil_printf("Okay, setting the core to perform a 1024-point FFT.\n\r");
					fft_set_num_pts(p_fft_inst, 1024);
					break;
				}
				else if (c == '7'){
					return;
				}
				else
		    		xil_printf("Invalid character. Please try again.\n\r");
			}
//			break;
//		}
//		else if (c == '1')
//		{
//			return;
//		}
//		else
//		{
//			xil_printf("Invalid character. Please try again.\n\r");
//		}
//	}
}
