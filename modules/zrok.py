from typing import Set
from decman import Module
from decman.plugins import aur


class ZrokPackages(Module):
    def __init__(self):
        super().__init__(name="zrok")

    @aur.packages
    def aurpkgs(self) -> Set[str]:
        return {"zrok-bin"}
