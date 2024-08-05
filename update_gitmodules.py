import os
import shutil
from subprocess import run, DEVNULL
from pathlib import Path


def find_git_repositories(dir_path):
    """Find all Git repositories in the given directory."""

    for root, dirs, files in os.walk(dir_path):
        if root == "/home/common/dotfiles":
            continue
        if ".git" in dirs:
            repo_dir = Path(root)
            remote_url = git_remote_from_config(repo_dir)
            relative_url = str(repo_dir.relative_to(dir_path))

            print("git rm --cached", relative_url)
            print("git submodule add", remote_url, relative_url)


def git_remote_from_config(repo_dir):
    """Get the remote URL from the Git repository configuration."""

    git_config = repo_dir / ".git" / "config"

    try:
        with open(git_config, encoding="utf-8") as f:
            for line in f.readlines():
                if "url =" in line:
                    return line.split("=")[1].strip().strip(" \t\n")
    except (OSError, FileNotFoundError):
        print(f"Failed to find git remote for {repo_dir}")
        return None


if __name__ == "__main__":
    current_directory = Path(__file__).parent
    current_directory.resolve()  # make sure we're not dealing with symbolic links
    find_git_repositories(current_directory)
