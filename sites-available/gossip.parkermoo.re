server {
  listen 80;
  server_name gossip.parkermoo.re;

  location / {
    proxy_pass        http://localhost:7483;
    proxy_set_header  X-Real-IP  $remote_addr;
  }
}
