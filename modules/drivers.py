from typing import Set
from decman import Module
from decman.plugins import pacman


class DriverPackages(Module):
    def __init__(self):
        super().__init__(name="driver")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"pulsemixer", "pipewire", "wireplumber"}
