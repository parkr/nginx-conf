server {
    listen 80;
    server_name pkrmr.com;
    return 301 http://cl.ly$request_uri;
}

server {
    listen 80;
    server_name www.pkrmr.com;
    return 301 http://cl.ly$request_uri;
}
