from typing import Set
from decman import Module
from decman.plugins import pacman


class CommandLinePackages(Module):
    def __init__(self):
        super().__init__(name="command_line")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {
            "git",
            "make",
            "unzip",
            "zip",
            "ripgrep",
            "zoxide",
            "bat",
            "fzf",
            "tree",
            "openssh",
        }
