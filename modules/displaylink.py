from typing import Set
from decman import Module
from decman.plugins import aur, systemd


class DisplayLinkPackages(Module):
    def __init__(self):
        super().__init__(name="displaylink")

    @aur.packages
    def aurpkgs(self) -> Set[str]:
        return {"evdi-dkms", "displaylink"}

    @systemd.units
    def units(self) -> Set[str]:
        return {"displaylink.service"}
