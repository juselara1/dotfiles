from typing import Set
from decman import Module
from decman.plugins import pacman


class FontsPackages(Module):
    def __init__(self):
        super().__init__(name="fonts")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {
            "noto-fonts",
            "noto-fonts-emoji",
            "ttf-nerd-fonts-symbols-mono",
            "otf-monaspace",
        }
