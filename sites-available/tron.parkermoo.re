server {
  listen 80;
  server_name tron.parkermoo.re;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://127.0.0.1:9292;
  }

  location /faye {
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://127.0.0.1:9292/faye;
  }
}
