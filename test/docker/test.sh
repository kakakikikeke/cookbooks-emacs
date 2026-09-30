#!/bin/sh
set -eu

cd /workspace

ansible-playbook --syntax-check -i localhost, playbook.yml
ansible-playbook -i localhost, -c local playbook.yml

emacs --version | grep -Eq '^GNU Emacs [0-9]+'

emacs_packages="$(python3 -c 'import yaml; print(" ".join(yaml.safe_load(open("vars.yml"))["emacs_packages"]))')"
emacs --batch -Q --eval "(progn (require 'package) (package-initialize) (let ((packages '(${emacs_packages}))) (dolist (package packages) (unless (package-installed-p package) (error \"Emacs package is not installed: %s\" package))) (message \"Verified %d configured Emacs packages\" (length packages))))"

test -f /root/.emacs
test -f /root/.emacs.d/site-lisp/common_ui/init.el
test -f /root/.emacs.d/snippets/ruby-mode/class-template.yasnippet
test -f /root/.emacs.d/snippets/python-mode/main.yasnippet

second_run="$(ansible-playbook -i localhost, -c local --diff playbook.yml)"
printf '%s\n' "$second_run"
printf '%s\n' "$second_run" | grep -Eq 'localhost[[:space:]]+:[[:space:]]+ok=.*changed=0.*failed=0'