from typing import Set, Dict
from decman import Module, Directory
from decman.plugins import pacman


class NvimPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="nvim")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.config/nvim": Directory(
                source_directory="./configs/nvim/",
                owner=self.user,
            )
        }

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"tree-sitter-cli", "neovim"}
