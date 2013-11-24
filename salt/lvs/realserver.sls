# ignore arp
net.ipv4.conf.all.arp_ignore:
  sysctl.present:
    - value: 1

net.ipv4.conf.lo.arp_ignore:
  sysctl.present:
    - value: 1

net.ipv4.conf.all.arp_announce:
  sysctl.present:
    - value: 2

net.ipv4.conf.lo.arp_announce:
  sysctl.present:
    - value: 2


# config lvs vip
{% if 'lvs-realserver' in pillar %}
{% for each_lvs in pillar['lvs-realserver'] %}
lvs-vip:
  network.managed:
    - name: {{"lo" + ":" + each_lvs['name']}}
    - enable: True
    - type: eth
    - proto: none
    - ipaddr: {{each_lvs['vip']}}
    - netmask: 255.255.255.255
{% endfor %}
{% endif %}
