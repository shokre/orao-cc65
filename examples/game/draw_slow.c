#include "gfx.h"

unsigned char *tmp_gfx_tiles;
unsigned char *tmp_map_data;
unsigned char *video_mem_start;

#define DRAW_WIDTH 20
#define DRAW_HEIGHT 20

// C version of map drawing code

#define DRAW_POS(x, y) (unsigned char*)(0x6000 + ((y+4) * 0x100) + x+1)
#define MAP_POS(x, y) (unsigned char*)(map_data_tiles + (y * 32) + x)

void draw_map_slow(void) {
    char x, y, my;
    // set video pointer to start of scanline

    video_mem_start = DRAW_POS(0, 0);
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

// 19774 cy for 2x2 byte sprite
void draw_sprite_slow(unsigned char sx, unsigned char sy, unsigned char ix, unsigned char *map_pos) {
    register unsigned char x, y, mask;
    unsigned char *tmp_sprite_gfx =  (unsigned char*)sprite_gfx_data + ix;
    unsigned char *tmp_sprite_mask =  (unsigned char*)sprite_mask_data + ix;

    // set screen pos
    video_mem_start = DRAW_POS(sx, sy);
    // set gfx data
    tmp_gfx_tiles = (unsigned char*)gfx_data_tiles;

    tmp_map_data = map_pos + (sy*map_data_width + sx);

    for (y = 0; y < 8; y++) {
        // draw scanline
        for (x = 0; x < 2; x++) {
            mask = tmp_map_data[x];
            video_mem_start[x] = (tmp_gfx_tiles[mask] & tmp_sprite_mask[x]) | tmp_sprite_gfx[x];
        }
        // advance tile scanline
        tmp_gfx_tiles += 0x100;
        tmp_sprite_gfx += 0x100;
        tmp_sprite_mask += 0x100;
        // move video to new row
        video_mem_start += 32;
    }
}

// 3621 cy
void fix_map_slow(unsigned char sx, unsigned char sy, unsigned char *map_pos) {
    register unsigned char y;

    // set screen pos
    video_mem_start = DRAW_POS(sx, sy);
    // set gfx data
    tmp_gfx_tiles = (unsigned char*)gfx_data_tiles;

    tmp_map_data = map_pos + (sy*map_data_width + sx);

    for (y = 0; y < 8; y++) {
        *video_mem_start = tmp_gfx_tiles[*tmp_map_data];
        // advance tile scanline
        tmp_gfx_tiles += 0x100;
        // move video to new row
        video_mem_start += 32;
    }
}
