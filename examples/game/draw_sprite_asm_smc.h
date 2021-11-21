
#ifndef DRAW_SPRITE_ASM_SMC_H__
#define DRAW_SPRITE_ASM_SMC_H__

void draw_sprite_asm_smc_set_sprite_pos(const void *);
void debug_sprite_struct(const void *);
void draw_sprite_asm_smc_row_advance(void);
void draw_sprite_asm_smc(unsigned char ix);

// LUT ptr to start of map for each row
extern unsigned char * map_row_ptr[];
// LUT ptr to start of drawpos for each row
extern unsigned char * draw_row_ptr[];

#endif DRAW_SPRITE_ASM_SMC_H__
