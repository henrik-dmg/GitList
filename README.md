# GitList

## Installation
### Manual
Clone the repository:
```bash
git clone https://github.com/henrik-dmg/GitList.git
sh GitList/install.sh
```
The binary will be installed into `/usr/local/bin/git-list`. After the installation finishes, please re-open or source your terminal
### [Mint](https://github.com/yonaskolb/mint)
```
$ mint install henrik-dmg/GitList
```

## Usage
GitList is designed to work as a git subcommand. It will be available as `git list`
- Checking out a branch: `git list -c`
- Deleting a branch: `git list -d` (or `git list -d -f` to force delete)

For help, you can also call `git-list --help`
