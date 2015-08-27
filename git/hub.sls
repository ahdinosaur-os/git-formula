{% set version = "2.2.1" %}
{% set sha256sum = "9350aba6a8e3da9d26b7258a4020bf84491af69595f7484f922d75fc8b86dc10" %}
hub:
  archive.extracted:
    - name: /tmp
    - source: https://github.com/github/hub/archive/v{{ version }}.tar.gz
    - archive_format: tar
    - source_hash: sha256={{ sha256sum }}
    - if_missing: /tmp/hub-{{ version }}
  cmd.run:
    - name: rake install
    - cwd: /tmp/hub-{{ version }}
    - unless: "test -x /usr/local/bin/hub || test $(hub --version | grep hub | cut -d ' ' -f 3) != {{ version }}"
    - require:
      - archive: hub
      - pkg: ruby
      - pkg: rake
  file.managed:
    - name: /usr/local/bin/hub
    - mode: 755
    - require:
      - cmd: hub

ruby:
  pkg.installed

rake:
  pkg.installed
