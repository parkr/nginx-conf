server {
  listen 80;
  server_name janky.parkermoo.re;
  root /var/www/janky/current/public;   # <--- be sure to point to 'public'!
  passenger_enabled on;
  error_log /var/www/janky/current/log/nginx.log;
  passenger_app_env development;
}
