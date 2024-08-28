if not ngx.var.http_proxy_authorization then
    ngx.header["Proxy-Authenticate"] = "Basic realm=\"Foxhole\""
    ngx.exit(407)
end

ngx.req.set_header("Authorization", ngx.var.http_proxy_authorization)
