This function extracted & pared down from the dav1d AV1 video codec library fails at -O1 and higher with the LLVM webassembly backend mode with emscripten upstream 3441.

The broken function creates shadowy flickering in the image during the loop filter restoration phase by misinterpreting the parameter which specifies which edges are present on a block to be filtered.

Offending line of code is:

```c
    const int have_left = !!(edges & LR_HAVE_LEFT);

    // Copy more pixels if we don't have to pad them
    pixel *dst_l = dst + 3 * !have_left;
```

when have_left gets used again later.

Part of this compiles down to

```wast
  (local.set $0
   (i32.add
    (local.get $0)
    (select
     (i32.const 0)
     (i32.const 3)
     (local.get $8)
    )
   )
  )
```

which is roughly taking `3 * !have_left`, but `!have_left` is acting as though no other values of `edges` are possible -- it is a bitfield flag and may have multiple edges, so we may not have_left when we have something else.

llvm ir has something like this

```ll
  %and = and i32 %edges, 1, !dbg !55
  %tobool = icmp ne i32 %and, 0, !dbg !56
  %mul = select i1 %tobool, i32 0, i32 3, !dbg !57
```

which would be correct.

I can fix the code by replacing the `(local.get $8)` with an `(int32.and (local.get $8) (i32.const 1))`.


