LightHouse
=========

Эта роль утсановит Lighthouse

Requirements
------------

None

Role Variables
--------------

- `lighthouse_vcs`: URL git-репозитория.
- `lighthouse_location`: - директория lighthouse

Dependencies
------------

None

Example Playbook
----------------

```
  - name: lighthouse
    hosts: lighthouse
    roles:
      - lighthouse-role
```

License
-------

MIT