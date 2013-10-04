server {
  listen 80;
  server_name prose.parkermoo.re;
  root /var/www/prose;
  error_log /var/www/prose/log/error.log;
  access_log  /var/www/prose/log/access.log  main;
}
