nginx_repo:
  pkgrepo.managed:
    - name: nginx
    - humanname: Nginx for CentOS
    - baseurl: http://nginx.org/packages/centos/$releasever/$basearch/
    - gpgcheck: 0
    - enable: 1
    
