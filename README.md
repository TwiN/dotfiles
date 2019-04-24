# dotfiles

Dotfiles (and more) for Archlinux on my Yoga C930

**Current configuration:** i3-gaps, rofi, polybar, urxvt, nvim


## Table of contents

- [NeoVim instead of Vim](#neovim-instead-of-vim)
- [Boot](#boot)


##  NeoVim instead of Vim

My love for Vim is nothing new, however, there's always been one thing about Vim that I hated: its codebase.

NeoVim took everything I loved about Vim, extended it, refactored a big part of its codebase, improved
Vim's performance, and even more. That's why I picked NeoVim over Vim.


## Boot
 
Since my installation uses EFI, you have to mount the boot partition first:


```bash
lsblk
```

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0 238.5G  0 disk 
|-nvme0n1p1 259:1    0   512M  0 part <--- boot partition
├─nvme0n1p2 259:2    0   200G  0 part /
└─nvme0n1p3 259:3    0    16G  0 part [SWAP]
```

If the boot partition is already mounted, you should see `/boot` as the mountpoint.
If it isn't mounted, then mount it like so:

```bash
sudo mount /dev/nvme0n1p1 /boot
```

I use `systemd-boot` rather than `grub2`, and the boot partition should look like this:

```
  EFI/
      BOOT/
          BOOTX64.EFI
      systemd/
          systemd-bootx64.efi
  loader/
      entries/
           arch.conf
           arch-microcode.conf
      loader.conf
  initramfs-linux-fallback.img
  initramfs-linux.img
  vmlinuz-linux
```


##### loader.conf
 
```
default arch
timeout 10
```


##### arch.conf

```
title Archlinux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=8d118839-7d70-4e13-a9a1-753b844e222d rw acpi_backlight=video resume=/dev/nvme0n1p3
```

 
##### arch-microcode.conf
 
```
title Archlinux (load microcode first)
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=PARTUUID=8d118839-7d70-4e13-a9a1-753b844e222d rw acpi_backlight=video resume=/dev/nvme0n1p3
```

**NOTE**: `resume=/dev/nvme0n1p3` is for hibernate support.
