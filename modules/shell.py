from typing import Dict
from decman import Module, Directory, File


class ShellPackages(Module):
    def __init__(self, user: str):
        super().__init__(name="shell")
        self.user = user

    def directories(self) -> Dict[str, Directory]:
        return {
            f"/home/{self.user}/.utilsh": Directory(
                source_directory="./configs/shell/utilsh/",
                owner=self.user,
                permissions=0o755,
            )
        }

    def files(self) -> Dict[str, File]:
        return {
            f"/home/{self.user}/.bashrc": File(
                source_file="./configs/shell/bashrc", owner=self.user
            ),
            f"/home/{self.user}/.inputrc": File(
                source_file="./configs/shell/inputrc", owner=self.user
            ),
        }
