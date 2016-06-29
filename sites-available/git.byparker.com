server {
  listen 80;
  server_name git.byparker.com;

  location / {
    proxy_pass        http://localhost:7904;
    proxy_set_header  X-Real-IP  $remote_addr;
  }
}
