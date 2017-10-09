all: configs
	$(MAKE) check

check:
	nginx check

configs: static-with-www-byparker.com \
  static-stash.byparker.com \
  static-with-www-parkermoo.re \
  static-stuff.parkermoore.de \
  proxy-8972-ping.parkermoo.re \
  proxy-7483-irc.parkermoo.re \
  proxy-7483-gossip.parkermoo.re \
  proxy-7523-pages.byparker.com \
  proxy-8291-radar.parkermakes.tools \
  additives-byparker.com

nginx-conf-gen:
	go get -u github.com/parkr/nginxconf/cmd/nginx-conf-gen

static-with-www-%: nginx-conf-gen
	nginx-conf-gen \
	  -domain=$(patsubst static-with-www-%,%,$@) \
	  -altDomains=$(patsubst static-with-www-%,www.%,$@) \
	  -webroot=$(patsubst static-with-www-%,/var/www/parkr/%,$@) \
	  -static -ssl > $(patsubst static-with-www-%,sites-available/%,$@)

static-%: nginx-conf-gen
	nginx-conf-gen \
	  -domain=$(patsubst static-%,%,$@) \
	  -webroot=$(patsubst static-%,/var/www/parkr/%,$@) \
	  -static -ssl > $(patsubst static-%,sites-available/%,$@)

proxy-%: nginx-conf-gen
	$(eval DOMAIN := $(shell echo $@ | cut -d- -f3))
	$(eval PORT := $(shell echo $@ | cut -d- -f2))
	nginx-conf-gen \
	  -domain=$(DOMAIN) \
	  -port=$(PORT) \
	  -proxy -ssl > sites-available/$(DOMAIN)

additives-byparker.com: static-with-www-byparker.com
	$(eval TMPCONF := "sites-available/byparker.com.tmp")
	@sed '$$ d' sites-available/byparker.com | sed '$$ d' | sed '$$ d' > $(TMPCONF)
	@echo '    # Allow go subpackages to be fetchable with "go get"' >> $(TMPCONF)
	@echo '    # Yoinked from willnorris.com, thanks Will!' >> $(TMPCONF)
	@echo '    location ~* ^/go/\w+/.+ {'                   >> $(TMPCONF)
	@echo '      if ($$arg_go-get) {'                       >> $(TMPCONF)
	@echo '        rewrite ^(/go/\w+) $$1? last;'           >> $(TMPCONF)
	@echo '      }' 										>> $(TMPCONF)
	@echo '      error_page 404 404.html;'                  >> $(TMPCONF)
	@echo '    }'                                           >> $(TMPCONF)
	@echo '}'                                               >> $(TMPCONF)
	@/bin/echo -n '# '                                              >> $(TMPCONF)
	@echo 'vim: syn=nginx'                                  >> $(TMPCONF)
	@mv $(TMPCONF) sites-available/byparker.com
