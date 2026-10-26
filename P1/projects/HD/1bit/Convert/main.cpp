#include <stdio.h>



int main(int argc, char *argv[])
{
    
    FILE *in;
    FILE *out;
    
    in = fopen("TirNaNog.scr", "rb");
    out = fopen("TirNaNog.bin", "wb");
    
    int i,j;
    char d;
    unsigned long rout;
    
    for (i=0; i<6144/2; i++)
    {
        rout = 0;

        fread(&d, 1, 1, in);

        for (j=0; j<8; j++)
        {
            char bit;
            bit = ((d & 128) >> 7) * 3;
            rout = (rout << 2) | bit;
            d = d << 1;
        }

        fread(&d, 1, 1, in);

        for (j=0; j<8; j++)
        {
            char bit;
            bit = ((d & 128) >> 7) * 3;
            rout = (rout << 2) | bit;
            d = d << 1;
        }
        
        fwrite(&rout, 1, 4, out);
    }
    
    fclose(out);
    fclose(in);

    
    return 0;
}
