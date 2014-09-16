
#include "tp2.h"


void sierpinski_c    (
	unsigned char *src,
	unsigned char *dst,
	int cols,
	int filas,
	int src_row_size,
	int dst_row_size)
{
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;

	double coef = 0;
	for(int i = 0; i < filas; i++){
		for(int j = 0; j < cols; j++){
			double i2 = i;
			double j2 = j;
			int num1 = ((255*i2)/filas);
			int num2 = ((255*j2)/cols);
			coef = (num1 ^ num2);
			coef = coef/255;
			dst_matrix[i][j*4] = src_matrix[i][j*4] * coef;
			dst_matrix[i][(j*4)+1] = src_matrix[i][(j*4)+1] * coef;
			dst_matrix[i][(j*4)+2] = src_matrix[i][(j*4)+2] * coef;
			dst_matrix[i][(j*4)+3] = src_matrix[i][(j*4)+3] * coef;
		}
	}
}


