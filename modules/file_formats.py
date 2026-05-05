from typing import Set
from decman import Module
from decman.plugins import pacman


class FileFormatsPackages(Module):
    def __init__(self):
        super().__init__(name="file_formats")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"jq", "tombi"}
