Vector
=========

Эта роль утсановит Vector

Requirements
------------

None

Role Variables
--------------

- `vector_version`: Версия Vector, которая будет установлена. (например, `0.14.0`).
- `vector_config_dir`: Директория с файлом конфигурации vector

Dependencies
------------

None

Example Playbook
----------------

```
---
- name: vector
  hosts: vector
  roles:
    - vector-role
```

License
-------

MIT

