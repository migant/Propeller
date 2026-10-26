{{
   Video.spin
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
              mov       dira, dira_data
              mov       outa, #1
              
              mov       ctra, #0
              mov       phsa, #0
              mov       frqa, frqa_data
              mov       ctra, ctra_data

              mov       vscl, vscl_data
              mov       vcfg, vcfg_data
              
entryloop     waitvid   ColorsSync, pix
              jmp       #entryloop

pix           long      %00010001_00010001_00010001_00010001


:superfield
              mov       HS_On,  VS_HS
              mov       HS_Off, VS
              call      #BlankLine              ' VSync Line
              call      #BlankLine              ' VSync Line

              mov       dy, #29                 ' 29 front porch lines
:backporch    mov       HS_On,  HS
              mov       HS_Off, #0
              call      #BlankLine
              djnz      dy, #:backporch

              mov       dy, #480                ' 480 visible Lines

:lines        mov       dx, #8                  ' 8 frames for sync (128 pixels)
:prevideo     waitvid   ColorsSync, HS
              djnz      dx, #:prevideo
              waitvid   ColorsSync, #0          ' 1 frame for Backporch (16 pixels)
              
              mov       dx, #40                 ' 40 frames for video data = 640 pixels
:video        waitvid   Palete, #0
              djnz      dx, #:video
              
:postvideo    waitvid   ColorsSync, #0          ' 1 frame for Frontporch (16 Pixels)

              djnz      dy, #:lines      

              mov       dy, #10                 ' 10 front porch lines
:frontporch   mov       HS_On,  HS
              mov       HS_Off, #0
              call      #BlankLine
              djnz      dy, #:frontporch

              jmp       #:superfield




BlankLine     mov       dx,#8
:sync         waitvid   ColorsSync, HS_On
              djnz      dx,#:sync

              waitvid   ColorsSync, HS_Off     ' Back Porch
              
              mov       dx,#40
:line         waitvid   ColorsSync, HS_Off     ' Horizontal Video              
              djnz      dx, #:line         

              waitvid   ColorsSync, HS_Off     ' Front Porch
BlankLine_Ret ret



r0            res       1
r1            res       1
r2            res       1
r3            res       1

Palete        long      %00000011_01010111_10101011_11111111
Pixels        long      0

dx            long      0
dy            long      0

HS_On         long      0
HS_Off        long      0

ColorsSync    long      %00000000_00000001_00000010_00000011  ' VS+HS, HS, VS, No Sync 
HS            long      %10101010_10101010_10101010_10101010
VS            long      %01010101_01010101_01010101_01010101
VS_HS         long      %11111111_11111111_11111111_11111111

{ VGA Mode, 4 color mode }
vscl_data     long      %000000000000_00000001_000000100000
vcfg_data     long      %0_01_1_0_0_000_00000000000_010_0_11111111

frqa_data     long      335_544_320
ctra_data     long      %0_00001_110_00000000_011111_000_000000

dira_data     long      %00000000_11111111_00000000_00000001
outa_data     long      %00000000_00000000_00000000_00000001

                