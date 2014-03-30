hub:
  archive.extracted:
    - name: /tmp
    - source: https://github.com/github/hub/archive/master.zip
    - archive_format: zip
    - if_missing: /tmp/hub-master
  cmd.run:
    - name: rake install
    - cwd: /tmp/hub-master
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