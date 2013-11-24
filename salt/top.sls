base:
  'lvs':
    - lvs.loadblance
  'web*':
    - lvs.realserver
    - nginx
