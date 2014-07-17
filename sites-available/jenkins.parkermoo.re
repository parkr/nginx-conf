server {
  listen 80;
  server_name jenkins.parkermoo.re;

  location / {
    proxy_pass        http://localhost:8080;
    proxy_set_header  X-Real-IP  $remote_addr;
    auth_basic "Restricted";
    auth_basic_user_file /opt/nginx/conf/.htpasswd;
  }
}
