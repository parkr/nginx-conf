server {
  listen 80;
  server_name camli.parkermoo.re;
  return 301 https://$host$request_uri;
}

server {
  listen 443;
  server_name camli.parkermoo.re;

  client_max_body_size 12M;

  location / {
    proxy_pass        http://localhost:3179;
    proxy_set_header  X-Real-IP  $remote_addr;
  }

  # required: path to certificate and private key
  ssl_certificate /opt/nginx/ssl/camli.parkermoo.re/unified.crt;
  ssl_certificate_key /opt/nginx/ssl/camli.parkermoo.re/my-private-decrypted.key;

  # optional: tell browsers to require SSL (warning: difficult to change your mind)
  add_header Strict-Transport-Security max-age=31536000;

  # optional: prefer certain ciphersuites, to enforce Perfect Forward Secrecy and avoid known vulnerabilities.
  # done in consultation with:
  #   http://ggramaize.wordpress.com/2013/08/02/tls-perfect-forward-secrecy-support-with-apache/
  #   https://www.ssllabs.com/ssltest/analyze.html
  ssl_prefer_server_ciphers on;
  ssl_ciphers ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:RC4-SHA:AES256-GCM-SHA384:AES256-SHA256:CAMELLIA256-SHA:ECDHE-RSA-AES128-SHA:AES128-GCM-SHA256:AES128-SHA256:AES128-SHA:CAMELLIA128-SHA;

  # optional: turn on session resumption, using a 10 min cache shared across nginx processes
  # as recommended by http://nginx.org/en/docs/http/configuring_https_servers.html
  ssl_session_cache   shared:SSL:10m;
  ssl_session_timeout 10m;
  keepalive_timeout   70;
}
