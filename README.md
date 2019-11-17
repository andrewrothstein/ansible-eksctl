andrewrothstein.eksctl
=========
[![Build Status](https://travis-ci.org/andrewrothstein/ansible-eksctl.svg?branch=master)](https://travis-ci.org/andrewrothstein/ansible-eksctl)

Installs [eksctl](https://eksctl.io/).

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.eksctl
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
