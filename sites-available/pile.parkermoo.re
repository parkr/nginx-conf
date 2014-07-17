server { 
	listen 80; 
	server_name pile.parkermoo.re;
    location / {
        proxy_pass        http://localhost:33411;
        proxy_set_header  X-Real-IP  $remote_addr;
    }
}
