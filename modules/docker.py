from typing import Set
from decman import Module
from decman.plugins import pacman, systemd


class DockerPackages(Module):
    def __init__(self):
        super().__init__(name="docker")

    @pacman.packages
    def pkgs(self) -> Set[str]:
        return {"docker", "docker-compose"}

    @systemd.units
    def units(self) -> Set[str]:
        return {"docker.service"}
