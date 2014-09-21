#include "tp2.h"

void bandas_c (
	unsigned char *src,
	unsigned char *dst,
	int m,
	int n,
	int src_row_size,
	int dst_row_size
) {
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;


	int total;
	int final;
	for(int i = 0; i < n; i++){
		for(int j = 0; j < m; j++){
			total = src_matrix[i][j*4] + src_matrix[i][(j*4)+1] + src_matrix[i][(j*4)+2];

			final = 255;		//caso default
			if(total < 672){final = 192;}
			if(total < 480){final = 128;}
			if(total < 288){final = 64;}
			if(total < 96){final = 0;}

			dst_matrix[i][j*4] = final;
			dst_matrix[i][(j*4)+1] = final;
			dst_matrix[i][(j*4)+2] =final;
		}
	}
}
