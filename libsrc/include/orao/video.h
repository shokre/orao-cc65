#ifndef VIDEO_H__
#define VIDEO_H__

// fill screen with byte value
void orao_fill_screen(unsigned char);
// int as y * 256 + x, x:h, y:l
void orao_set_cursor_pos(unsigned int);
// clear screen and put cursor to 0,0
void orao_cls(void);

#endif VIDEO_H__
