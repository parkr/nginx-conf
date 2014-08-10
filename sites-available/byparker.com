server {
    listen 80;
    server_name byparker.com;
    return 302 https://byparker.com$request_uri;
}

server {
    listen 80;
    server_name www.byparker.com;
    return 302 https://byparker.com$request_uri;
}

server {
    listen 443;
    server_name www.byparker.com;
    return 302 https://byparker.com$request_uri;

    # required: path to certificate and private key
    ssl_certificate /etc/prosody/certs/byparker.com.ssl.crt;
    ssl_certificate_key /etc/prosody/certs/byparker.com.ssl.key;

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

server {
    listen 443 ssl;
    server_name byparker.com;

    root /var/www/parkermoore.de;
    error_page 404 = /404.html;

    #lua_need_request_body on;
    #access_by_lua_file "/opt/nginx/etc/access.lua";

    # required: path to certificate and private key
    ssl_certificate /etc/prosody/certs/byparker.com.ssl.crt;
    ssl_certificate_key /etc/prosody/certs/byparker.com.ssl.key;

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
