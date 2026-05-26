from typing import Set, Dict
from decman import Module, Directory
from decman.plugins import pacman


class PasswordPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="password")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.config/gnupg": Directory(
                source_directory="./configs/gnupg/", owner=self.user, permissions=0o700
            )
        }

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"pass"}
