
#include "tp2.h"

#define MIN(x,y) ( x < y ? x : y )
#define MAX(x,y) ( x > y ? x : y )

#define P 2

void mblur_c    (
    unsigned char *src,
    unsigned char *dst,
    int cols,
    int filas,
    int src_row_size,
    int dst_row_size)
{
    unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
    unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;
	
    int r1 = 0;
    int r2 = 0;
    int r3 = 0;
    int r4 = 0;
    int r5 = 0;
    int rd = 0;

    int g1 = 0;
    int g2 = 0;
    int g3 = 0;
    int g4 = 0;
    int g5 = 0;
    int gd = 0;

    int b1 = 0;
    int b2 = 0;
    int b3 = 0;
    int b4 = 0;
    int b5 = 0;
    int bd = 0;
    

	for (int i = 0; i < filas; i++)
    {
        for (int j = 0; j < (cols*4); j=j+4)
        {
            if((j>=8)&&(j<((cols*4)-8))&&(i>=2)&&(i<(filas-2))){
                r1 = src_matrix[i-2][j-8];
                r2 = src_matrix[i-1][j-4];
                r3 = src_matrix[i][j];
                r4 = src_matrix[i+1][j+4];
                r5 = src_matrix[i+2][j+8];

                g1 = src_matrix[i-2][j-7];
                g2 = src_matrix[i-1][j-3];
                g3 = src_matrix[i][j+1];
                g4 = src_matrix[i+1][j+5];
                g5 = src_matrix[i+2][j+9];

                b1 = src_matrix[i-2][j-6];
                b2 = src_matrix[i-1][j-2];
                b3 = src_matrix[i][j+2];
                b4 = src_matrix[i+1][j+6];
                b5 = src_matrix[i+2][j+10];

                rd = (r1+r2+r3+r4+r5)/5;
                gd = (g1+g2+g3+g4+g5)/5;
                bd = (b1+b2+b3+b4+b5)/5;
            }else{
                rd = 0;
                gd = 0;
                bd = 0;
                dst_matrix[i][j+3] = 255; 
            }
            dst_matrix[i][j] = rd;
            dst_matrix[i][j+1] = gd;
            dst_matrix[i][j+2] = bd;
            
        }
    }
 
}


