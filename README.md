<p align="center">
  <a href="#readme"><img src="./assets/logo.png" alt="Foxhole" width="500"></a>
</p>

Foxhole is a Docker container that streamlines the setup of HTTPS forward proxy.

How to set up a Foxhole proxy server on Digital Ocean (you can use any other provider of your choice):

1. Create the cheapest [Docker droplet.](https://marketplace.digitalocean.com/apps/docker)

2. On the droplet page, go to "Access" and click on "Droplet Console".

3. Copy this command and run it. It may take several minutes before a Foxhole configurator shows up.

```shell
PROXY_HTTP_PORT=65050 PROXY_HTTPS_PORT=65051 sh <(wget -qO- https://raw.githubusercontent.com/smikhalevski/foxhole/master/install)
```

4. In configurator, you're asked several questions.

    - **Configure HTTPS?**

      If you have a registered domain name (you can register one with
      [Cloudflare](https://www.cloudflare.com/products/registrar/) for example), Foxhole can issue SSL certificates for
      your domain and enable HTTPS to send CONNECT requests to your proxy.

      Regardless of whether you enable HTTPS for Foxhole or not, all traffic that passes through the Foxhole proxy is
      still encrypted when you connect to any HTTPS-enabled website. Enabling HTTPS for the Foxhole proxy is nice to
      have if you want to set up proxy authentication, so your login and password won't be transmitted unencrypted when
      you connect to the proxy.

    - **Configure authentication?**

      Set up a list of usernames and passwords to connect to your proxy.

    - **Configure IP whitelist?**

      Set up a list of IP addresses allowed to connect to your proxy.
      [Here you can find your IP address.](https://whatismyipaddress.com/)

   You can answer "no" to all of these questions and have a perfectly working proxy. To have al least some level of
   security, enable IP whitelist to prevent bad actors from using your proxy and stealing your traffic.

5. After the server is successfully started, you should configure a proxy in your browser or OS (see below).

6. If you want to change the proxy configuration, re-run the command from step 3.

# Configuring iOS

1. Navigate to "Settings" → "Wi-Fi".
2. Click on the ⓘ symbol near the network for which you want to configure a proxy.
3. Click "Configure Proxy".
4. Select "Manual".
5. Enter the server, port for the HTTP proxy you were provided. Unfortunately, iOS doesn't support HTTPS proxies.
6. If you configured authentication for your server, check "Authentication" and provide your username and password.

# Configuring Mac

1. Navigate to "System Preferences" → "Network" → "Wi-Fi".
2. Click "Advanced".
3. Go to the "Proxies" tab and enable "Automatic Proxy Configuration".
4. Use the "Configuration URL" for the HTTP or HTTPS proxy that you obtained after Foxhole was set up.

# Configuring Firefox

If you don't want to configure a system-wide proxy, you can change a Firefox-only proxy configuration.

1. Open Firefox and go to `about:preferences#privacy`.
2. Find "Network Settings" section and click "Settings…"
3. Enable "Automatic proxy configuration URL".
4. Use the "Configuration URL" for the HTTP or HTTPS proxy that you obtained after Foxhole was set up.
