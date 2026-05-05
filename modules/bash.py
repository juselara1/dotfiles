from typing import Set
from decman import Module
from decman.plugins import pacman


class BashPackages(Module):
    def __init__(self):
        super().__init__(name="bash")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"bash-language-server", "shellharden"}
