# 🐳&ensp;Forward Proxy for Docker

How to set up forward proxy server on Digital Ocean:

1. Create the cheapest [Docker droplet.](https://marketplace.digitalocean.com/apps/docker)

2. On the droplet page, go to _Access_ and click on _Droplet Console_.

3. Copy this command and run it. It may take several of minutes to complete.

```shell
docker exec -it $(docker rm -f forward-proxy >/dev/null 2>&1 && docker run --pull always --name forward-proxy -qdp 65050:8080 ghcr.io/smikhalevski/forward-proxy-docker:master) configure
```

4. Follow instructions on the screen: setup username/password credentials and specify IPs that are allowed to use proxy.

5. After the server is successfully started, you should configure a proxy in your browser or OS (see below).

6. If you want to change proxy configuration, re-run the command from step 3.

# Configuring iOS

1. Navigate to Settings → Wi-Fi.
2. Click on the ⓘ symbol near the network for which you want to configure a proxy.
3. Click "Configure Proxy".
4. Select "Manual".
5. Enter the server and port you were provided on step 3.
6. If you configured authentication for your server, check "Authentication" and provide your username and password.

# Configuring Mac

1. Navigate to System preferences → Network → Wi-Fi.
2. Click "Advanced".
3. Go to "Proxies" tab and select "Web proxy (HTTP)".
4. Enter the server and port you were provided on step 3.
5. If you configured authentication for your server, check "Authentication" and provide your username and password.
