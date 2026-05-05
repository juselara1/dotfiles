import decman
from decman.extras.users import User, UserManager
from modules.system import SystemPackages
from modules.drivers import DriverPackages
from modules.command_line import CommandLinePackages
from modules.python import PythonPackages
from modules.lua import LuaPackages
from modules.bash import BashPackages
from modules.terraform_gcp import TerraformGCPPackages
from modules.file_formats import FileFormatsPackages
from modules.fonts import FontsPackages
from modules.niri import NiriPackages
from modules.multimedia import MultimediaPackages
from modules.docker import DockerPackages
from modules.displaylink import DisplayLinkPackages
from modules.tmux import TmuxPackages
from modules.alacritty import AlacrittyPackages
from modules.blesh import BleshPackages
from modules.shell import ShellPackages
from modules.nvim import NvimPackages
from modules.browser import BrowserPackages
from modules.git import GitPackages
from modules.password import PasswordPackages


USERNAME = "juselara"

decman.modules += [
        SystemPackages(),
        DriverPackages(),
        CommandLinePackages(),
        PythonPackages(),
        LuaPackages(),
        BashPackages(),
        TerraformGCPPackages(),
        FileFormatsPackages(),
        FontsPackages(),
        MultimediaPackages(),
        DockerPackages(),
        DisplayLinkPackages(),
        BrowserPackages(),
        BleshPackages(user=USERNAME),
        PasswordPackages(user=USERNAME),
        TmuxPackages(user=USERNAME),
        NiriPackages(user=USERNAME),
        AlacrittyPackages(user=USERNAME),
        ShellPackages(user=USERNAME),
        NvimPackages(user=USERNAME),
        GitPackages(user=USERNAME),
        ]


um = UserManager()
um.add_user(User(
    username=USERNAME,
    groups=("docker", "wheel"),
    shell="/usr/bin/bash"
    ))
