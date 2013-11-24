# installed ipvsadm
ipvsadm:
  pkg.installed

# config lvs
{% if 'lvs-loadblance' in pillar %}
{% for each_lvs in pillar['lvs-loadblance'] %}
# config lvs vip
{{each_lvs['name']}}-vip:
  network.managed:
    - name: {{each_lvs['vip-nic'] + ":" + each_lvs['name']}}
    - enable: True
    - type: eth
    - proto: none
    - ipaddr: {{each_lvs['vip']}}
    - netmask: 255.255.255.255

{% set service_address = each_lvs['vip'] + ":" + each_lvs['port']|string() %}
{{each_lvs['name']}}-service:
  lvs_service.present:
    - protocol: {{each_lvs['protocol']}}
    - service_address: {{service_address}}
    - scheduler: {{each_lvs['scheduler']}}

{% for each_rs in each_lvs['realservers'] %}
{% set server_address = each_rs['ip'] + ":" + each_rs['port']|string() %}
{{each_rs['name']}}-server:
  lvs_server.present:
    - protocol: {{each_lvs['protocol']}}
    - service_address: {{service_address}}
    - server_address: {{server_address}}
    - packet_forward_method: {{each_rs['packet_forward_method']}}
    - weight: {{each_rs['weight']}}
{% endfor %}
{% endfor %}
{% endif %}
