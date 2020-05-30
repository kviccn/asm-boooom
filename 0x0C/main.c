/* filename - main.c */

void printf(const char *message);

void bootmain(void)
{
  char *message = "Hello, laoli!";
  printf(message);

  while (1)
    ;
}

void printf(const char *message)
{
  unsigned short *video_buffer = (unsigned short *)0xb8000;
  for (int i = 0; i < 80 * 25; i++)
  {
    video_buffer[i] = (video_buffer[i] & 0xff00) | ' ';
  }

  for (int i = 0; message[i] != '\0'; i++)
  {
    video_buffer[i] = (video_buffer[i] & 0xff00) | message[i];
  }
}
