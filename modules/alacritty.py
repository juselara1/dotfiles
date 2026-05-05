from typing import Set
from decman import Module, Directory
from decman.plugins import pacman


class AlacrittyPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="alacritty")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {f"/home/{self.user}/.config/alacritty": Directory(
            source_directory="./configs/alacritty/",
            owner=self.user
            )}

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"alacritty"}
