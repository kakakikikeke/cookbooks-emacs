# cookbooks-emacs on macOS

Install and configure Emacs on macOS with Ansible and Homebrew.

## Requirements

* macOS 15 or later
* Homebrew
* Ansible Core 2.15 or later

## Install

Clone this repository and run the playbook:

```bash
ansible-playbook -i localhost, -c local playbook.yml
```

On Apple Silicon, the playbook uses `/opt/homebrew`; on Intel Macs, it uses `/usr/local`. Set `HOMEBREW_BIN` and `EMACS_INSTALL_DIR` when Homebrew uses a custom prefix.

The default Emacs Lisp package list, version, and snippet installation can be overridden with Ansible extra variables. For example:

```bash
ansible-playbook -i localhost, -c local playbook.yml \
  -e 'emacs_version=30.1 emacs_packages=[] emacs_put_snippets=false'
```

Run `ansible-playbook --syntax-check -i localhost, playbook.yml` to validate the playbook without applying changes.
