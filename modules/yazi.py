from typing import Set, Dict
from decman import Module, Directory
from decman.plugins import pacman


class YazyPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="yazi")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.config/yazi": Directory(
                source_directory="./configs/yazi/",
                owner=self.user,
            )
        }

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"yazi"}
