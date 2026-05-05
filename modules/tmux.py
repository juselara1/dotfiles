from typing import Set, Dict
from decman import Module, Directory
from decman.plugins import pacman


class TmuxPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="tmux")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {f"/home/{self.user}/.config/tmux": Directory(
            source_directory="./configs/tmux/",
            owner=self.user,
            permissions=0o755
            )}

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"tmux"}
