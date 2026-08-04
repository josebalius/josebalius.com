# A tiny static site image. BusyBox's httpd is enough for this site and keeps
# deployments independent from the separate thoughts generator repository.
FROM alpine:3.20

COPY public /var/www

EXPOSE 8080

CMD ["/bin/busybox", "httpd", "-f", "-p", "8080", "-h", "/var/www"]
