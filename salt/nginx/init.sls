include:
  - nginx.repo
  

nginx:
  pkg.installed:
    - name: nginx
    - require: 
      - pkgrepo: nginx_repo
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - pkg: nginx

nginx_test_page:
  file.managed:
    - name: /usr/share/nginx/html/test.html
    - source: salt://nginx/files/test.html
    - template: jinja
    - defaults:
        server: {{grains.id}}
    - require:
      - service: nginx
