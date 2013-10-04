server {
  listen 80;
  server_name lists.jekyllrb.com;

  location / {
    proxy_pass        http://localhost:8888;
    proxy_set_header  X-Real-IP  $remote_addr;
  }
}
