from typing import Set
from decman import Module
from decman.plugins import pacman


class MultimediaPackages(Module):
    def __init__(self):
        super().__init__(name="multimedia")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"imv", "zathura", "zathura-pdf-poppler", "zathura-djvu", "zathura-ps", "mpv", "inkscape", "obs-studio"}
