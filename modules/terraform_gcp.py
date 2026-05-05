from typing import Set
from decman import Module
from decman.plugins import pacman, aur


class TerraformGCPPackages(Module):
    def __init__(self):
        super().__init__(name="terraform_gcp")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"terraform"}

    @aur.packages
    def aurpkgs(self) -> Set[str]:
        return {"google-cloud-cli"}
