from typing import Set
from decman import Module
from decman.plugins import pacman, aur, systemd


class SystemPackages(Module):
    def __init__(self):
        super().__init__(name="system")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"base", "linux", "linux-firmware", "linux-headers", "base-devel", "networkmanager", "btrfs-progs", "grub", "efibootmgr"}

    @aur.packages
    def aurpkgs(self) -> Set[str]:
        return {"decman"}

    @systemd.units
    def units(self) -> Set[str]:
        return {"NetworkManager.service"}
