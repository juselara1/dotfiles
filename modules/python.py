from typing import Set
from decman import Module
from decman.plugins import pacman


class PythonPackages(Module):
    def __init__(self):
        super().__init__(name="python")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"pyenv"}
