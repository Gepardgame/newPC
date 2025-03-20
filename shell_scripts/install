passwd
fdisk -l
read DRIVE
read USER
fdisk "${DRIVE}" <<FDISK_CMDS
g
n
1

+1G
t
1
n
2


w
FDISK_CMDS
cryptsetup luksFormat -s 512 -y "${DRIVE}2"
cryptsetup open "${DRIVE}2" cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate MyVolGroup /dev/mapper/cryptlvm
lvcreate -L 4G -n swap MyVolGroup
lvcreate -l 100%FREE -n root MyVolGroup
lvreduce -L -256M MyVolGroup/root
mkfs.ext4 /dev/MyVolGroup/root
mkfs.fat -F32 "${DRIVE}1"
mkswap /dev/MyVolGroup/swap
swapon /dev/MyVolGroup/swap
mount /dev/MyVolGroup/root /mnt
mount --mkdir "${DRIVE}1" /mnt/efi
pacstrap -K /mnt base base-devel linux-hardened linux-firmware neovim man lvm2 networkmanager efibootmgr git cryptsetup sddm wayland xorg-server xorg-xwayland xfce4
genfstab -U /mnt >>/mnt/etc/fstab
arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
nvim /etc/locale.gen # Uncomment de_DE
locale-gen
echo "LANG=de_DE.UTF-8" >/etc/locale.conf
echo "KEYMAP=de-latin1" >/etc/vconsole.conf
echo "test" >/etc/hostname
useradd -m "${USER}"
usermod -aG wheel "${USER}"
EDITOR=nvim visudo # Uncomment wheel group
passwd "${USER}"
passwd
su "${USER}" -

cd
mkdir aur_builds
cd aur_builds
git clone https://aur.archlinux.org/bdf-unifont.git
cd bdf-unifont
gpg --recv-keys 1A09227B1F435A33
makepkg -sic
cd ..
git clone https://github.com/lbatuska/grub-improved-luks2-git.git
cd grub-improved-luks2-git
makepkg -sic
exit

dd bs=512 count=4 if=/dev/random iflag=fullblock | install -m 0600 /dev/stdin /etc/cryptsetup-keys.d/cryptlvm.key
cryptsetup -v luksAddKey "${DRIVE}2" /etc/cryptsetup-keys.d/cryptlvm.key
UUID=$(cryptsetup luksDump "${DRIVE}2" | grep "UUID" | awk '{ print $2 }')
GRUB_CMDLINE_LINUX="GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=${UUID}:cryptlvm cryptkey=rootfs:/etc/cryptsetup-keys.d/cryptlvm.key\""
GRUB_PRELOAD_MODULES='GRUB_PRELOAD_MODULES="cryptodisk part_gpt part_msdos"'
HOOKS="HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)"
FILES="FILES=(/etc/cryptsetup-keys.d/cryptlvm.key)"
sed -i "s|^GRUB_CMDLINE_LINUX=.*$|$GRUB_CMDLINE_LINUX|" /etc/default/grub
sed -i "s|^GRUB_PRELOAD_MODULES=.*$|$GRUB_PRELOAD_MODULES|" /etc/default/grub
sed -i 's/^#\s*\(GRUB_ENABLE_CRYPTODISK=y\)/\1/' /etc/default/grub
sed -i "s|^HOOKS=.*$|$HOOKS|" /etc/mkinitcpio.conf
sed -i "s|^FILES=.*$|$FILES|" /etc/mkinitcpio.conf

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --recheck
mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg
exit

umount -R /mnt
reboot
