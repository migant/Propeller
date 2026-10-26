{{
   Video_Osc.spin
}}

  
VAR
  long  cog
  

PUB Start : Okay

  stop
  okay := cog := cognew(@entry, 0) + 1


PUB Stop

  if cog
    cogstop(cog~ - 1)
    
    
DAT
                        org

entry
                        mov     dira, dira_data
                        mov     frqa, frqa_data
                        mov     ctra, ctra_data

                        mov     vscl, vscl_data
                        mov     vcfg, vcfg_data         

:superfield
                        mov     r0, VLines
                        mov     Colors, Palete

:hline                  cmp     r0, #3          wc                                                                              
              if_c      mov     SyncOn,  VS_HS
              if_c      mov     SyncOff, VS
              if_nc     mov     SyncOn,  HS
              if_nc     mov     SyncOff, #0

                        mov     r1, #8
:sync                   waitvid ColorsSync, SyncOn                              ' Horizontal Sync
                        djnz    r1, #:sync

                        waitvid ColorsSync, SyncOff                             ' Back Porch

                        mov     r1, #40
:pixelsloop   if_c      waitvid ColorsSync, SyncOff
              if_nc     waitvid Colors, Pixels
                        djnz    r1, #:pixelsloop

                        waitvid ColorsSync, SyncOff                             ' Front Porch

                        add     Colors, #4

                        djnz    r0, #:hline
                        
                        jmp     #:superfield


r0                      long    0
r1                      long    0
r2                      long    0
r3                      long    0



Palete                  long    %11111111_10101011_01010111_00000011
Colors                  long    0
Pixels                  long    %00000000_00000000_00000000_00000000

VLines                  long    521
SyncOn                  long    0
SyncOff                 long    0

ColorsSync              long    %00000000_00000001_00000010_00000011    ' VS+HS, HS, VS, No Sync 
HS                      long    %10101010_10101010_10101010_10101010
VS                      long    %01010101_01010101_01010101_01010101
VS_HS                   long    %11111111_11111111_11111111_11111111


dira_data               long    %00000000_11111111_00000000_00000000

ctra_data               long    %0_00001_101_00000000_011111_000_010000
frqa_data               long    335_544_320

{ VGA Mode, 4 color mode }
vscl_data               long    %000000000000_00000001_000000010000
vcfg_data               long    %0_01_1_0_0_000_00000000000_010_0_11111111

         