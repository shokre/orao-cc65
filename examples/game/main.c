#include <orao.h>
#include "draw_slow.h"
#include "draw_asm.h"
#include "draw_asm_smc.h"
#include "draw_sprite_asm_smc.h"
#include "mem_utils.h"
#include "gfx.h"

#define DRAW_SPRITE_ASM

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
    orao_debug_timerx(1);
    draw_map_slow();
    orao_debug_timerx(1);

    invert_tiles();
    // draw asm - slow indirect addresing version
    orao_debug_timerx(2);
    draw_asm_set_map_pos(map_data_tiles);
    draw_asm_set_draw_pos(DRAW_POS);
    orao_debug_timerx(2);

    invert_tiles();
    orao_debug_timerx(3);
    draw_asm_map();
    orao_debug_timerx(3);

    invert_tiles();
    // draw asm - fast smc version
    orao_debug_timerx(4);
    draw_asm_smc_set_map_pos(map_data_tiles);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    orao_debug_timerx(4);

    orao_debug_timerx(5);
    draw_asm_smc_map();
    orao_debug_timerx(5);

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
    unsigned char spr_x = 2;
    unsigned char spr_y = 5;

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

    draw_asm_smc_set_map_pos(map_pos);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();

_loop:
orao_debug_timerx(1);
#ifdef DRAW_SPRITE_ASM
    draw_sprite_asm_smc_set_map_pos(map_pos + (spr_y*map_data_width + spr_x));
    draw_sprite_asm_smc_set_draw_pos((unsigned char*)(0x6000 + ((spr_y+4) * 0x100) + spr_x+1));
orao_debug_timerx(2);
    draw_sprite_asm_smc(0);
orao_debug_timerx(2);
    draw_sprite_asm_smc_map_advance();
    draw_sprite_asm_smc_set_draw_pos((unsigned char*)(0x6000 + ((spr_y+5) * 0x100) + spr_x+1));
    draw_sprite_asm_smc(2);
#else
    draw_sprite_slow(spr_x, spr_y, 0, map_pos);
    draw_sprite_slow(spr_x, spr_y+1, 2, map_pos);
#endif
orao_debug_timerx(1);

    switch (orao_getc()) {
        case 'W':
            if (spr_y <= 0)
                break;
            fix_map_slow(spr_x, spr_y+1, map_pos);
            fix_map_slow(spr_x+1, spr_y+1, map_pos);
            --spr_y;
            //map_pos -= map_data_width;
            break;
        case 'S':
            if (spr_y >= 20)
                break;
            fix_map_slow(spr_x, spr_y, map_pos);
            fix_map_slow(spr_x+1, spr_y, map_pos);
            ++spr_y;
            //map_pos += map_data_width;
            break;
        case 'A':
            if (spr_x <= 0)
                break;
            fix_map_slow(spr_x+1, spr_y, map_pos);
            fix_map_slow(spr_x+1, spr_y+1, map_pos);
            --spr_x;
            break;
        case 'D':
            if (spr_x >= 20)
                break;
            fix_map_slow(spr_x, spr_y, map_pos);
            fix_map_slow(spr_x, spr_y+1, map_pos);
            ++spr_x;
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
