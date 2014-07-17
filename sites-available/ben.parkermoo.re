server {
    listen 80;
    server_name benbalter.parkermoo.re;

    root /tmp/benbalter.github.com/_site;
    error_page 404 = /404.html;
    location ~*  \.(jpg|jpeg|png|gif|ico|css|js)$ {
         expires 3s;
    }
}
