#ifndef ORAO_DEBUG_H__
#define ORAO_DEBUG_H__

// initialize debugging routines and print 'ORAO' to console
void orao_debug_init(void);

// start/stop timer
// void orao_debug_timer(void);

// more precise version of timer
#define orao_debug_timerx(x) asm("sta %w", (0xA000 + x))
#define orao_debug_timer() orao_debug_timerx(1)

#endif ORAO_DEBUG_H__
