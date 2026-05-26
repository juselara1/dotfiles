from typing import Set
from decman import Module
from decman.plugins import pacman


class LuaPackages(Module):
    def __init__(self):
        super().__init__(name="lua")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"lua-language-server", "stylua", "luacheck"}
