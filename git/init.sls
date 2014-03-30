include:
{% if pillar.get('git', {}).get('install_from_source') %}  
  - git.source
{% else %}
  - git.package
{% endif %}

{% set config = pillar.get('git', {}).get('config') %}
{% if config is iterable %}
/etc/gitconfig:
  file.managed:
    - source: salt://git/gitconfig
    - template: jinja
    - context:
      config: {{ config }}
    - mode: 644
{% endif %}