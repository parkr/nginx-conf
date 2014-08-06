server {
    listen 80;
    server_name byparker.com;
    return 302 https://parkermoo.re$request_uri;
}

server {
    listen 80;
    server_name www.byparker.com;
    return 302 https://parkermoo.re$request_uri;
}
