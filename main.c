#include "linux.h"
#include <GLES3/gl3.h>

int
main(void) {
  plt_init_gles2_static("window", 1600, 900);

  while (plt_poll_events()) {

    if (plt_keyboard()->current[KEY_ESCAPE]) {
      return 0;
    }

    glClear(GL_COLOR_BUFFER_BIT);

    plt_gl_swap_buffers();
  }

  plt_quit();
  return 0;
}

// vim: sw=2
