import os
from typing import Set
from decman import Module
from decman.plugins import aur
from decman.plugins.aur import CustomPackage



class GoosePackages(Module):
    def __init__(self):
        super().__init__(name="goose")

    @aur.custom_packages
    def aurpkgs(self) -> Set:
        return {
                CustomPackage(pkgname="goose", pkgbuild_directory=f"{os.getcwd()}/build/goose")
                }
