if not ngx.var.http_proxy_authorization then
    ngx.header["Proxy-Authenticate"] = "Basic realm=\"Access to internal site\""
    ngx.exit(407)
end

ngx.req.set_header("Authorization", ngx.var.http_proxy_authorization)
