#include <orao.h>
#include "draw_slow.h"
#include "draw_asm.h"
#include "draw_asm_smc.h"
#include "draw_sprite_asm_smc.h"
#include "mem_utils.h"
#include "gfx.h"

#define DRAW_SPRITE_ASM

#define ORAO_MEM_VIDEO ((unsigned char*)0x6000)
#define DRAW_POS (unsigned char*)0x6401

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

void video_blt(unsigned char *pos, unsigned char *tmp_gfx_tiles, unsigned char nTiles) 
{
    char x, y;

    for (y = 0; y < 8; ++y) {
        // draw scanline
        for (x = 0; x < nTiles; ++x) {
            pos[x] = tmp_gfx_tiles[x];
        }
        // advance tile scanline
        tmp_gfx_tiles += 0x100;
        // move video to new row
        pos += 32;
    }
}

#define DEBUG_TILES_PER_ROW 16
#define DEBUG_TILES_CNT DEBUG_TILES_PER_ROW

void debug_tiled_data(unsigned char* cpos)
{
    unsigned char i;

    orao_puts("\r\n     0123456789ABCDEF\r\n");

    for (i = 0; i < 16; i++) {
        orao_print_addr(cpos);
        orao_puts("\r\n");
        video_blt(SCREEN_POS(5,i+3), cpos, DEBUG_TILES_CNT);

        cpos += DEBUG_TILES_CNT;
    }

    orao_getc();
}

void debug_tiles()
{
    orao_cls();
    orao_puts("Tiles =======\r\n");

    debug_tiled_data((unsigned char*)gfx_data_tiles);
}

void debug_sprites()
{
    orao_cls();
    orao_puts("Sprites =======\r\n");

    debug_tiled_data((unsigned char*)sprite_gfx_data);
}

unsigned char * map_pos;

typedef struct {
    unsigned char y, x;
} TSpriteInfo;


#define MAX_SPRITES 3
TSpriteInfo sprites[MAX_SPRITES];

#define MAX_ROW_PTRS 20

void init_map_row_ptrs(void) {
    unsigned char i;
    unsigned char *ptr = map_pos;

    for (i=0; i < 32; ++i) {
        map_row_ptr[i] = ptr;
        ptr += 32;
    }

    ptr = DRAW_POS;
    for (i=0; i < 20; ++i) {
        draw_row_ptr[i] = ptr;
        ptr += 0x100;
    }
}

void draw_map_area() {
    map_pos = (unsigned char *)map_data_tiles;

    init_map_row_ptrs();

    draw_asm_smc_set_map_pos(map_pos);
    draw_asm_smc_set_draw_pos(DRAW_POS);
    draw_asm_smc_map();
}

init_map_screen() {
    orao_cls();
    orao_puts("ORAO cc65 == Game example\r\n");
    orao_puts("GFX:$");
    orao_print_addr(gfx_data_tiles);
    orao_puts(" MAP:$");
    orao_print_addr(map_data_tiles);
    orao_puts(" PTR:$");
    orao_print_addr(map_row_ptr);
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
    orao_puts("- <G> debug tiles\r\n");
    orao_puts("- <H> debug sprites\r\n");
    orao_puts("- <Q>uit");

    draw_map_area();
}

void main() {
    unsigned char sp_ix;

    sprites[0].x = 2;
    sprites[0].y = 5;

    sprites[1].x = 8;
    sprites[1].y = 7;

    init_map_screen();

_loop:
orao_debug_timerx(1);
    for (sp_ix = 0; sp_ix < 1; ++sp_ix) {
#ifdef DRAW_SPRITE_ASM
    draw_sprite_asm_smc_set_sprite_pos((void *)sprites[sp_ix]);
    draw_sprite_asm_smc(0);
    draw_sprite_asm_smc_row_advance();
    draw_sprite_asm_smc(2);
#else
    draw_sprite_slow(sprites[sp_ix].x, sprites[sp_ix].y, 0, map_pos);
    draw_sprite_slow(sprites[sp_ix].x, sprites[sp_ix].y+1, 2, map_pos);
#endif
    }
orao_debug_timerx(1);

    switch (orao_getc()) {
        case 'W':
            if (sprites[0].y <= 0)
                break;
            fix_map_slow(sprites[0].x, sprites[0].y+1, map_pos);
            fix_map_slow(sprites[0].x+1, sprites[0].y+1, map_pos);
            --sprites[0].y;
            //map_pos -= map_data_width;
            break;
        case 'S':
            if (sprites[0].y >= 20)
                break;
            fix_map_slow(sprites[0].x, sprites[0].y, map_pos);
            fix_map_slow(sprites[0].x+1, sprites[0].y, map_pos);
            ++sprites[0].y;
            //map_pos += map_data_width;
            break;
        case 'A':
            if (sprites[0].x <= 0)
                break;
            fix_map_slow(sprites[0].x+1, sprites[0].y, map_pos);
            fix_map_slow(sprites[0].x+1, sprites[0].y+1, map_pos);
            --sprites[0].x;
            break;
        case 'D':
            if (sprites[0].x >= 20)
                break;
            fix_map_slow(sprites[0].x, sprites[0].y, map_pos);
            fix_map_slow(sprites[0].x, sprites[0].y+1, map_pos);
            ++sprites[0].x;
            break;
        case 'Q':
            goto _exit;

        case 'B':
            bench_draw();
            break;
        case 'I':
            invert_tiles();    
            draw_map_area();
            break;
        case 'G':
            debug_tiles();
            init_map_screen();
            break;
        case 'H':
            debug_sprites();
            init_map_screen();
            break;
    }
    goto _loop;

_exit:
    orao_puts("Exiting\r\n");
}
