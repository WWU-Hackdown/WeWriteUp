## I AM MANY
#### challenge
```
```

### resources
[hackover.png](hackover.png)

### idea
The title implies some sort of hidden files, so we used ```binwalk hackover.png```:
```
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 331 x 52, 8-bit/color RGB, non-interlaced
56            0x38            Zlib compressed data, compressed
4662          0x1236          PNG image, 800 x 76, 8-bit/color RGBA, non-interlaced
4724          0x1274          Zlib compressed data, compressed
```
And we get the png files with ```binwalk -D 'png image:png' hackover.png```. One of the extracted images has the flag.

### flag
hackover18{different_Fl4g_for_3arly_ch33tahz}

[more write-ups](../../)
