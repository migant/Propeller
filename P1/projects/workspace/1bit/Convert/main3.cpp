#include <stdio.h>

FILE *in, *in2;
FILE *out;


void Seek(int line)
{
     int r0, r1, r2, r3;
     int seek;
     
     r0 = line;
     r1 = line & 0x07;
     r2 = (line >> 3) & 0x07;
     r3 = (line >> 6);
     seek = (r3 * 0x800) + (r2 * 32) + (r1 * 0x100);
     fseek(in, seek, SEEK_SET);
     
     r0 = line;
     r1 = line >> 3;
     seek = r1 * 32;
     fseek(in2, seek, SEEK_SET);
}



int main(int argc, char *argv[])
{
    //in  = fopen("BruceLee.scr", "rb");
    in  = fopen("DaleyThompsonsSupertest.scr", "rb");
    in2 = fopen("DaleyThompsonsSupertest.scr", "rb");
    //in  = fopen("EnduroRacer.scr", "rb");
    //in  = fopen("TirNaNog.scr", "rb");
    
    out = fopen("screen.bin", "wb");
    
    
    int i,j,k;
    char d1, d2, d3;
    unsigned long rout;
    
    for (i=0; i<192; i++)
    {
        Seek(i);

        for (j=0; j<16; j++)
        {
                rout = 0;

                fread(&d1, 1, 1, in);
                fread(&d2, 1, 1, in2);
                //d2 = (d2 >> 6) & 0x01;
                d3 = d2;
                d2 = (d2 >> 4) & 3;
                d3 = (d3 >> 1) & 3;
                for (k=0; k<8; k++)
                {
                    char bit;
                    //bit = ((d1 & 128) >> 7) * 3;
                    bit = ((d1 & 128) >> 7);
                    //rout = (rout >> 2) | ((bit) << 30);
                    if (bit)
                       rout = (rout >> 2) | ((d3) << 30);
                    else
                       rout = (rout >> 2) | ((d2) << 30);
                       
                    d1 = d1 << 1;
                }

                fread(&d1, 1, 1, in);
                fread(&d2, 1, 1, in2);
                //d2 = (d2 >> 6) & 0x01;
                d3 = d2;
                d2 = (d2 >> 4) & 3;
                d3 = (d3 >> 1) & 3;

                for (k=0; k<8; k++)
                {
                    char bit;
                    //bit = ((d1 & 128) >> 7) * 3;
                    bit = ((d1 & 128) >> 7);
                    //rout = (rout >> 2) | ((bit) << 30);
                    if (bit)
                       rout = (rout >> 2) | ((d3) << 30);
                    else
                       rout = (rout >> 2) | ((d2) << 30);

                    d1 = d1 << 1;
                }
        
                fwrite(&rout, 1, 4, out);
        }
    }
    
    fclose(out);
    fclose(in2);
    fclose(in);

    
    return 0;
}
