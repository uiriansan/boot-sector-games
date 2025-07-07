### Dependencies:
- [fasm](https://flatassembler.net/)

### Build:
```bash
git clone --depth=1 https://github.com/uiriansan/boot-sector-games.git
cd boot-sector-games/
make
```

### Run:
```bash
qemu-system-i386 -fda build/<game>.bin
```
