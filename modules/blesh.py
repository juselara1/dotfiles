from typing import Set, Dict
from decman import Module, File
from decman.plugins import aur


class BleshPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="blesh")
        self.user = user


    def files(self) -> Dict[str, File]:
        return {f"/home/{self.user}/.blerc": File(
            source_file="./configs/blesh/blerc",
            owner=self.user
            )}


    @aur.packages
    def aurpkgs(self) -> Set[str]:
        return {"blesh-git"}
