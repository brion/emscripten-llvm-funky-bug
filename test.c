#include <stdlib.h>
#include <stddef.h>
#include <inttypes.h>
#include <memory.h>

#define pixel_copy memcpy
#define pixel_set memset
#define PXSTRIDE(x) (x)

typedef uint8_t pixel;

enum LrEdgeFlags {
    LR_HAVE_LEFT = 1 << 0,
    LR_HAVE_RIGHT = 1 << 1,
    LR_HAVE_TOP = 1 << 2,
    LR_HAVE_BOTTOM = 1 << 3,
};

// 256 * 1.5 + 3 + 3 = 390
#define REST_UNIT_STRIDE (390)

// TODO Reuse p when no padding is needed (add and remove lpf pixels in p)
// TODO Chroma only requires 2 rows of padding.
//__attribute__ ((optnone)) // this fixes it
void padding(pixel *dst, const pixel *p, const ptrdiff_t p_stride,
                    const pixel (*left)[4],
                    const pixel *lpf, const ptrdiff_t lpf_stride,
                    int unit_w, const int stripe_h, const enum LrEdgeFlags edges)
{
    const int have_left = !!(edges & LR_HAVE_LEFT);

    // Copy more pixels if we don't have to pad them
    pixel *dst_l = dst + 3 * !have_left;

    if (edges & LR_HAVE_TOP) {
        pixel_copy(dst_l, lpf, unit_w);
    } else {
        if (have_left) {
            pixel_copy(dst_l, &left[0][1], 3);
        }
    }
}

int main(int argc, char **argv) {
    unsigned char *src = malloc(1024);
    unsigned char *dst = malloc(1024);
    unsigned char *lpf = malloc(1024);
    pixel left[4];
    enum LrEdgeFlags edges = LR_HAVE_LEFT;

    padding(dst, src, 64,
            &left,
            lpf, 64,
            64, 64, edges);
}
