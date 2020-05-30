#include "types.h"

void entry(void)
{
  uint16_t *video_buffer = (uint16_t *)0xb8000;

  for (int i = 0; i < 80 * 25; i++)
  {
    video_buffer[i] = (video_buffer[i] & 0xff00) | ' ';
  }

  video_buffer[0] = 0x0700 | 'l';
  video_buffer[1] = 0x0700 | 'a';
  video_buffer[2] = 0x0700 | 'o';
  video_buffer[3] = 0x0700 | 'l';
  video_buffer[4] = 0x0700 | 'i';
  video_buffer[5] = 0x0700 | '!';
}
