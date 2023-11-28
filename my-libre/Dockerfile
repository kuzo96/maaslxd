# syntax=docker/dockerfile:1
FROM repo.cpt.gov.vn/staging/librenms-28-11:1.3
COPY docker-php-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-php-entrypoint.sh"]

STOPSIGNAL SIGQUIT

EXPOSE 80
CMD ["bash"]
