from typing import Set, Dict
from decman import Module, Directory
from decman.plugins import pacman


class GitPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="git")
        self.user = user

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"git", "github-cli"}

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.config/git": Directory(
                source_directory="./configs/git/",
                owner=self.user,
            )
        }
