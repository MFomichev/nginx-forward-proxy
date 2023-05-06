# nginx-forward-proxy

## About

The 'nginx-foward-proxy' is a HTTP and HTTPS proxy server using the nginx.

## How to use

```
docker run -d --restart=always -p 3128:3128 -v ./.htpasswd_nginx:/usr/local/nginx/conf/.htpasswd --name nginx_proxy mfomichev/nginx-forward-proxy:latest
```

## Authentication

For authentication use [apache2-utils]{https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/}.

For example `htpasswd -c ./.htpasswd my-user`

## The project is based on:

- [ngx_http_proxy_connect_module]{https://github.com/chobits/ngx_http_proxy_connect_module}
 
- [Issue 42]{https://github.com/chobits/ngx_http_proxy_connect_module/issues/42}

- [Nginx forward proxy by hinata]{https://github.com/hinata/nginx-forward-proxy}

