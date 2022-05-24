# docker-ghost
A custom Ghost Docker image with the Imgur storage adapter and Disqus comments installed.

Set your Disqus shortname with the `DISQUS_SHORTNAME` environment variable at runtime.

```sh
docker run -p 2368:2368 \
    -e DISQUS_SHORTNAME=yourshortname \
    kotatsuclub/ghost:{version}
```

If you do not wish to use the Imgur storage adapter, but still want Disqus, set the storage adapter back to the default by setting the `storage__active` environment variable to `local-file-store`. 

```sh
docker run -p 2368:2368 \
    -e DISQUS_SHORTNAME=yourshortname \
    -e storage__active=local-file-store \
    kotatsuclub/ghost:{version}
```