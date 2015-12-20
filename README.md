ansible-role-sopel-runit-debian
=========

Ansible role which deploys the sopel irc bot monitored by runit to a debian box. The motivation for this role was the new implementation of the [sopel-rss](https://github.com/RebelCodeBase/sopel-rss) rss2irc module.

Role Variables
--------------

* pname: program name
** This is the name which will be used to install the bot in the box. For instance, the users pname and pname-log will be created for runit.
** Defaults to sopel

* status: status of bot
** start: link, stop: absent
** Defaults to link

* homedir: home directory of the bot user <pname>
** Defaults to /home/<pname>

* botdir: bot directory
** Defaults to <homedir>/sopel

* moddir: module directory
** Defaults to <homedir>/modules

* configdir: configuration directory
** Defauts to <homedir>/.sopel

* custommoddir: configuration module directory
** Defaults to <configdir>/modules

* configfile: configuration file
** Defaults to default.cfg

* env_lang: runit environment language
** Ascii decoding errors occur if the LANG environment variable is not set to UTF-8
** Defaults to en_US.UTF-8

* Bot variables with default values
** auth_username: 'sopel'
** auth_password: ''
** auth_method: 'nickserv'
** channels: '#test-sopel-irc'
** default_timezone: ''
** enable: ''
** exclude: ''
** host: 'chat.freenode.net'
** log_raw: 'True'
** logging_level: 'INFO'
** nick: 'sopel'
** nick_blocks: ''
** owner: 'sopel-owner'
** port: '6667'
** prefix: '.'
** use_ssl: 'False'
** user: 'sopel'
** verbose: 'verbose'

Example Playbook
----------------

```
---
- hosts: all
  become: yes
  become_method: sudo
  roles:
    - role: ansible-role-sopel-runit-debian
```

License
-------

MIT
