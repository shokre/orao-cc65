
#include "gfx.h"

unsigned char *tmp_gfx_tiles;
unsigned char *tmp_map_data;
unsigned char *video_mem_start;

#define DRAW_WIDTH 20
#define DRAW_HEIGHT 20-3

// C version of map drawing code

void draw_map_slow(void) {
    char x, y, my;
    // set video pointer to start of scanline
    //   start from x:1 y:3(*0xff)
    //   video_mem_start = $6301

    video_mem_start = (unsigned char*)0x6401;
    tmp_map_data = (unsigned char*)map_data_tiles;

    for (my = 0; my < DRAW_HEIGHT; my++) {
        // reset tile pointer
        tmp_gfx_tiles = (unsigned char*)gfx_data_tiles;

        // draw map row
        for (y = 0; y < 8; y++) {
            // draw scanline
            for (x = 0; x < DRAW_WIDTH; x++) {
                video_mem_start[x] = tmp_gfx_tiles[tmp_map_data[x]];
            }
            // advance tile scanline
            tmp_gfx_tiles += 0x100;
            // move video to new row
            video_mem_start += 32;
        }

        // advance map row
        tmp_map_data += map_data_width;
    }
}
