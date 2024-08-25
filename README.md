# 🪀&ensp;Nginx Forward Proxy for Docker

How to set up on Digital Ocean:

1. Create the cheapest [Docker droplet.](https://marketplace.digitalocean.com/apps/docker)

2. On the droplet page, go to _Access_ and click on _Droplet Console_.

3. Copy this command and run it. It may take several of minutes to complete.

```shell
docker exec -it $(docker run --pull always -qdp 63235:8080 ghcr.io/smikhalevski/forward-proxy-docker:master) configure
```
