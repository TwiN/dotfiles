# dotfiles scripts

A collection of scripts for setting up a fresh environment.

## wifi.sh

Enable the wifi. 

If you plan on using `wifi-menu` when prompted, then you can leave the script as-is, otherwise, you can either replace
`$WIFI_SSID` and `$WIFI_PASSWORD` for their literal value, or you can `export WIFI_SSID=myssid` and 
`export WIFI_PASSWORD=mywifipwd` before running the script.

Honestly, this script is overkill. All you have to do is

```
rfkill unblock all
wifi-menu
```

If `wifi-menu` doesn't work or you forgot to install `dialog` when you `chroot`'d from the archiso, 
then you need to do it manually:

```
sudo ip link set wlp107s0 up
wpa_supplicant -i wlp107s0 -c <(wpa_passphrase "$WIFI_SSID" "$WIFI_PASSWORD") -B
iw dev wlp107s0 link
sudo dhcpcd wlp107s0
```

To **enable wifi on boot**, use `netctl enable WIFI_PROFILE`. 
To find the name of your wifi profile, use `netctl list`.


## create-user.sh

Create a user named `twin` with the group `wheel` and the shell `bash`.
Then, the package sudo will be installed (unless it's already installed) and the group `wheel` 
will be added to the list of sudoers.


## reinstall-arch.sh

This is specific to the Yoga C930, and assumes that you already had a working configuration before.
You must be booted on a Arch iso USB before running this script, and wifi must already be working.

It will
- Mount `/dev/nvme0n1p2` on `/mnt`: In my case, `/dev/nvme0n1p2` is my Linux partition whereas`/dev/nvme0n1p1` 
is my boot partition. This assumes that your boot partition is working properly.
- Delete everything in `/mnt`
- Reinstall Arch Linux on `/mnt` using pacstrap
- Change the root to `/mnt` so we can install the following packages before rebooting into Arch:
    - vim
    - iw
    - wget
    - git
    - dialog
    - wpa_supplicant

And the script stops here. You can install more packages if you wish, but when you're done, run `exit` and then `reboot`.

