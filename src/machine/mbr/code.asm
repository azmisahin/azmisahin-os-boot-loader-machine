;   ████████████████████████████████████████████████████████████████████████████████████████████████████
;   Machine: Machine.asm v0.0.0.1
;   http://azmisahin.com
;   ════════════════════════════════════════════════════════════════════════════════════════════════════
;   Copyright bilgi@azmisahin.com
;   Licence (https://github.com/azmisahin)
;   ████████████████████████████████████████████████████████████████████████████████████████████████████

org 0x7c00
    xor ax, ax                  ;   ax  :   0
    mov ds, ax                  ;   ds  :   0
    jmp Initalize               ;   Go Initalize
    
;   Define
;   ----------------------------------------------------------------------------------------------------
Define:
    message db  'Machine', 13, 10, 0    

;   Initalize
;   ----------------------------------------------------------------------------------------------------
Initalize:
    call Screen                 ;   Scrreen Initalize
    call Welcome                ;   Welcome Intalize

;   Main
;   ----------------------------------------------------------------------------------------------------
Main:  
    call Keypress
    
    jmp Main  
    
;   Scrreen Initalize
;   ----------------------------------------------------------------------------------------------------
Screen:
    mov ah, 06h                 ;   Scroll up function.
    xor al, al                  ;   Clear entire screen.
    xor cx,cx                   ;   Upper left corner CH=row, CL=column
    mov dx, 184fh               ;   lower right corner DH=row, DL=column
    mov bh,1eh                  ;   Yellow On Blue
    int 10h                     ;
    ret      

;   Welcome Initalize
;   ----------------------------------------------------------------------------------------------------
Welcome:
    mov si, message             ;   Set Source Index Message
    call Bios_Print    
    ret
    
;   Print Function
;   ----------------------------------------------------------------------------------------------------
Bios_Print:
    lodsb                       ;   Load Memory Byte [ AL ]
    or al, al                   ;
    jz Call_Done                ;
    mov ah, 0x0E                ;
    int 0x10                    ;
    jmp Bios_Print              ;

;   Progress Done Signal
;   ----------------------------------------------------------------------------------------------------
Call_Done:
    ret

;   Keypres
;   ----------------------------------------------------------------------------------------------------
Keypress:
    mov ah, 1                   ;   
    int 16h                     ;
    jz Keypress                 ;
    mov ah, 0                   ;
    int 16h                     ;
    call    Keypress_Control    ;
    ret                         ;
    
;   Keypres Control Sub Function
;   ----------------------------------------------------------------------------------------------------
    Keypress_Control:
    call Keypress_Escape    
    call Keypress_Print
    ret

;   Keypress_Escape
;   ----------------------------------------------------------------------------------------------------
    Keypress_Escape:
    cmp	al, 1bh                 ;   Escape    
    jz Exit                     ;   Exit
    ret                         ;   

;   Keypress_Enter
;   ----------------------------------------------------------------------------------------------------
    Keypress_Enter:
    ;cmp	al, 1C0Dh       ;   Enter    
                                ;   Nothing progress
    ret                         ;  
            
;   Keypres Print Sub Function
;   ----------------------------------------------------------------------------------------------------
    Keypress_Print:
    mov ah, 0eh                 ;   Key Write
    int	10h
    ret   
    
;   Page_Down Sub Function
;   ----------------------------------------------------------------------------------------------------
    Page_Down:
    add	dh, 1                   ;   Page Position
    mov	ah, 02h                 ;   Page Change
    int	10h  
    ret      

;   Exit
;   ----------------------------------------------------------------------------------------------------                      
Exit:
    ret

;   Zero
;   ----------------------------------------------------------------------------------------------------
db 0

;   Sector Done
;   ----------------------------------------------------------------------------------------------------
db 0x55
db 0xAA