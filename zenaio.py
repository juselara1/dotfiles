import decman
from decman.extras.users import User, UserManager
from modules.alacritty import AlacrittyPackages
from modules.bash import BashPackages
from modules.browser import BrowserPackages
from modules.command_line import CommandLinePackages
from modules.displaylink import DisplayLinkPackages
from modules.docker import DockerPackages
from modules.drivers import DriverPackages
from modules.file_formats import FileFormatsPackages
from modules.fonts import FontsPackages
from modules.git import GitPackages
from modules.goose import GoosePackages
from modules.lua import LuaPackages
from modules.multimedia import MultimediaPackages
from modules.niri import NiriPackages
from modules.nvim import NvimPackages
from modules.password import PasswordPackages
from modules.python import PythonPackages
from modules.shell import ShellPackages
from modules.system import SystemPackages
from modules.terraform_gcp import TerraformGCPPackages
from modules.tmux import TmuxPackages


USERNAME = "juselara"

decman.modules += [
        AlacrittyPackages(user=USERNAME),
        BashPackages(),
        BrowserPackages(),
        CommandLinePackages(),
        DisplayLinkPackages(),
        DockerPackages(),
        DriverPackages(),
        FileFormatsPackages(),
        FontsPackages(),
        GitPackages(user=USERNAME),
        GoosePackages(),
        LuaPackages(),
        MultimediaPackages(),
        NiriPackages(user=USERNAME),
        NvimPackages(user=USERNAME),
        PasswordPackages(user=USERNAME),
        PythonPackages(),
        ShellPackages(user=USERNAME),
        SystemPackages(),
        TerraformGCPPackages(),
        TmuxPackages(user=USERNAME),
        ]


um = UserManager()
um.add_user(User(
    username=USERNAME,
    groups=("docker", "wheel"),
    shell="/usr/bin/bash"
    ))
