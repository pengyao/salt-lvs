lvs-loadblance:
  - name: lvstest
    vip: 192.168.36.33
    vip-nic: eth1
    port: 80
    protocol: tcp
    scheduler: wlc
    realservers:
      - name: web-01
        ip: 192.168.36.11
        port: 80
        packet_forward_method: dr
        weight: 10 
      - name: web-02
        ip: 192.168.36.12
        port: 80
        packet_forward_method: dr
        weight: 30 
        
