# Ryan's Dotfiles

This repository is a collection of Dotfiles that I use in my everyday development.
It uses [chezmoi](https://www.chezmoi.io/) to manage the dotfiles.

## Usage

Follow instructions in the chezmoi docs.

Or apply immediately with:
```
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply $GITHUB_USERNAME
```

Note:
- Add -n to dry-run first.
- Use chezmoi `diff` to check diference between target and destination state.

## Additional Configs

To switch to `fish` as the main shell, use:

```
chsh -s /usr/bin/fish
```

## Dependencies

- bat : https://github.com/sharkdp/bat
- ripgrep (rg): https://github.com/BurntSushi/ripgrep

