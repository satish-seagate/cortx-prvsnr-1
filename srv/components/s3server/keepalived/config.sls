Setup keepalived master config (sample, manually updated):
  file.managed:
    - name: /etc/keepalived/keepalived.conf.master
    - source: salt://components/s3server/files/keepalived/keepalived.conf.master
