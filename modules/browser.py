from typing import Set
from decman import Module
from decman.plugins import pacman, aur


class BrowserPackages(Module):
    def __init__(self):
        super().__init__(name="browser")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"firefox"}

    @aur.packages
    def aurpkgs(self) -> Set[str]:
        return {"google-chrome"}
