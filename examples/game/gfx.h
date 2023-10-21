#ifndef GFX_DATA_H__
#define GFX_DATA_H__

#define SCREEN_POS(x, y) (unsigned char*)(0x6000 + ((y) * 0x100) + x)

extern const unsigned char gfx_data_tiles[];
extern const unsigned char map_data_tiles[];
extern const unsigned char map_data_width;
extern const unsigned char map_data_height;
extern const unsigned char sprite_gfx_data[];
extern const unsigned char sprite_mask_data[];

#endif
