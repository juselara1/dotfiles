from typing import Set
from decman import Module, Directory
from decman.plugins import pacman


class NiriPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="niri")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.config/niri": Directory(
                source_directory="./configs/niri/", owner=self.user
            )
        }

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"niri", "grim", "slurp", "wl-clipboard", "awww"}
