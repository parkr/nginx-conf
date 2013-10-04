server {
  listen 80;
  server_name monit.parkermoo.re;

  location / {
    proxy_pass        http://localhost:2812;
    proxy_set_header  X-Real-IP  $remote_addr;
  }
}
