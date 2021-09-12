#include <orao.h>
#include "draw_slow.h"
#include "draw_asm.h"
#include "draw_asm_smc.h"
#include "mem_utils.h"
#include "gfx.h"

#define ORAO_MEM_VIDEO ((unsigned char*)0x6000)
#define DRAW_POS (const void *)0x6401

void invert_tiles(void) {
    mem_invert_bank(gfx_data_tiles);
    mem_invert_bank(gfx_data_tiles+0x100);
    mem_invert_bank(gfx_data_tiles+0x200);
    mem_invert_bank(gfx_data_tiles+0x300);
    mem_invert_bank(gfx_data_tiles+0x400);
    mem_invert_bank(gfx_data_tiles+0x500);
    mem_invert_bank(gfx_data_tiles+0x600);
    mem_invert_bank(gfx_data_tiles+0x700);
}

void bench_draw(void) {
    invert_tiles();
    // draw slow
    orao_debug_timer();
    draw_map_slow();
    orao_debug_timer();

    invert_tiles();
    // draw asm - slow indirect addresing version
    orao_debug_timer();
    draw_asm_set_map_pos(map_data_tiles);
    draw_asm_set_draw_pos(DRAW_POS);
    orao_debug_timer();

    invert_tiles();
    orao_debug_timer();
    draw_asm_map();
    orao_debug_timer();

    invert_tiles();
    // draw asm - fast smc version
    orao_debug_timer();
    draw_asm_smc_set_map_pos(map_data_tiles);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    orao_debug_timer();

    orao_debug_timer();
    draw_asm_smc_map();
    orao_debug_timer();

    draw_asm_smc_set_map_pos(map_data_tiles+34);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();

    draw_asm_smc_set_map_pos(map_data_tiles);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();

    draw_asm_smc_set_map_pos(map_data_tiles+34);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();

    draw_asm_smc_set_map_pos(map_data_tiles);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();
}

unsigned char * map_pos;

void main() {

    orao_cls();
    orao_puts("ORAO cc65 == Game example\r\n");
    orao_puts("GFX:$");
    orao_print_addr(gfx_data_tiles);
    orao_puts(" MAP:$");
    orao_print_addr(map_data_tiles);
    orao_print_newline();
    // draw grid
    orao_puts("\n ");
    orao_puts("1234567890");
    orao_puts("1234567890");
    orao_puts("1234567890");
    orao_puts("\r\n1\r\n2\r\n3\r\n4\r\n5\r\n6\r\n7\r\n8\r\n9\r\n0");
    orao_puts("\r\n1\r\n2\r\n3\r\n4\r\n5\r\n6\r\n7\r\n8\r\n9\r\n0");
    orao_print_newline();
    orao_print_newline();


    orao_puts("Use <WSAD> keys to move\r\n");
    orao_puts("- <B>enchmark\r\n");
    orao_puts("- <I>nvert tiles\r\n");
    orao_puts("- <Q>uit");

    map_pos = (unsigned char *)map_data_tiles;

_loop:
    draw_asm_smc_set_map_pos(map_pos);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();

    switch (orao_getc()) {
        case 'W':
            map_pos -= map_data_width;
            break;
        case 'S':
            map_pos += map_data_width;
            break;
        case 'A':
            --map_pos;
            break;
        case 'D':
            ++map_pos;
            break;
        case 'Q':
            goto _exit;
        case 'B':
            bench_draw();
            break;
        case 'I':
            invert_tiles();    
            break;
    }
    goto _loop;

_exit:
    orao_puts("Exiting\r\n");
}
