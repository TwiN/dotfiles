# dotfiles

Dotfiles (and more) for Archlinux on my Yoga C930


## Boot

Since my installation uses EFI, you have to mount the boot partition first:


```bash
lsblk
```

```
nvme0n1     259:0    0 238.5G  0 disk 
|-nvme0n1p1 259:1    0   512M  0 part <--- boot partition
`-nvme0n1p2 259:2    0   200G  0 part /
```

```bash
sudo mount /dev/nvme0n1p1 /mnt
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
      loader.conf
  initramfs-linux-fallback.img
  initramfs-linux.img
  vmlinuz-linux
```


##### loader.conf

```
default arch
timeout 4
```


##### arch.conf

```
title Archlinux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=8d118839-7d70-4e13-a9a1-753b844e222d rw acpi_backlight=video
```
