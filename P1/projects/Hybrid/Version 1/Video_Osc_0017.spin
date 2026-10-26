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

:Sync                   mov     SyncOn,  VS_HS
                        mov     SyncOff, VS
                        call    #BlankLine
                        call    #BlankLine
                        mov     SyncOn,  HS
                        mov     SyncOff, #0
                        mov     r0, #29
:BackPorch              call    #BlankLine
                        djnz    r0, #:BackPorch
                                                              
                        mov     r0, #480
                        mov     ry, #0
                        mov     rx, #0
:Line                   call    #Line
                        djnz    r0, #:Line

                        mov     r0, #10
:FrontPorch             call    #BlankLine
                        djnz    r0, #:FrontPorch                                      

                        add     ROM, #1
                        jmp     #:superfield

                        
Line                    mov     r1, #8
:linesync               waitvid ColorsSync, SyncOn
                        djnz    r1, #:linesync
                        waitvid ColorsSync, SyncOff                             ' Back Porch
                        mov     r1, #40
:visline                call    #VisibleLine
                        add     rx, #1
                        djnz    r1, #:visline
                        add     ry, #1
                        waitvid ColorsSync, SyncOff                             ' Front Porch
Line_Ret                ret                             
                             

BlankLine               mov     r1, #8
:sync                   waitvid ColorsSync, SyncOn                              ' Horizontal Sync
                        djnz    r1, #:sync
                        waitvid ColorsSync, SyncOff                             ' Back Porch
                        mov     r1, #40
:pixelsloop             waitvid ColorsSync, SyncOff
                        djnz    r1, #:pixelsloop
                        waitvid ColorsSync, SyncOff                             ' Front Porch
BlankLine_Ret           ret                             


{ Display Visible Line. rx - line tile; ry - line }
VisibleLine             mov     t0, ry
                        and     t0, #%111111
                        shl     t0, #2
                        or      t0, SyncMask
                        waitvid t0, #0
VisibleLine_Ret         ret


ROM                     long    $9000

SyncOn                  long    0
SyncOff                 long    0
ry                      long    0
rx                      long    0

r0                      long    0
r1                      long    0
r2                      long    0
r3                      long    0

t0                      long    0
t1                      long    0
t2                      long    0
t3                      long    0

Colors1                 long    %00000011_10101011_01010111_11111111
Colors2                 long    %01010111_00001111_00110011_10001011
Pixels                  long    0

SyncMask                long    %00000011_00000011_00000011_00000011
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


                        fit     $100