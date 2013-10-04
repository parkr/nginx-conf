server {
  listen 80;
  server_name irc.parkermoo.re;
  root /var/www/chat-log-server/public;   # <--- be sure to point to 'public'!
  passenger_enabled on;
  error_log /var/www/chat-log-server/log/error.log;
}
