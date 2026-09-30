# cookbooks-emacs

Install and configure Emacs with Ansible.

## Supported platforms

* Ubuntu 22.04 and 24.04
* macOS with Homebrew

Ansible Core 2.15 or later is required. Install it with your platform's package manager or Python environment manager.

## Run

Clone this repository, then run the playbook from its directory:

```bash
ansible-playbook -i localhost, -c local playbook.yml --ask-become-pass
```

On Linux, Ansible uses privilege escalation to install build dependencies and Emacs under `/usr/local`. On macOS, Emacs is installed with Homebrew and no become password is needed; run without `--ask-become-pass`:

```bash
ansible-playbook -i localhost, -c local playbook.yml
```

The playbook installs Emacs 30.1 by default, configured Emacs Lisp packages, the files under `files/`, and the Ruby and Python yasnippet snippets. Override defaults with extra variables or environment variables:

```bash
VERSION=30.1 ansible-playbook -i localhost, -c local playbook.yml -K
ansible-playbook -i localhost, -c local playbook.yml -K \
  -e 'emacs_version=30.1 emacs_packages=[] emacs_put_snippets=false'
```

Use `--check --diff` to preview supported changes.

## Validate

```bash
ansible-playbook --syntax-check -i localhost, playbook.yml
```
