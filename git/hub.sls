{% set version = "1.12.0" %}
{% set sha256sum = "fb45c3777fb1b16fd07bfd7a66fb986b3582713555128e8118782072682374d1" %}
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
    - unless: "test -x /usr/local/bin/hub"
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