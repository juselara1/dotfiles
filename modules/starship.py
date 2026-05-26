from typing import Set, Dict
from decman import Module, Directory
from decman.plugins import pacman


class StarshipPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="starship")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.config/starship": Directory(
                source_directory="./configs/starship/", owner=self.user
            )
        }

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"starship"}
