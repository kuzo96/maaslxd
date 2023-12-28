# syntax=docker/dockerfile:1
FROM repo.cpt.gov.vn/staging/librenms-dist-poller:latest
COPY ./docker-php-entrypoint.sh /

ENTRYPOINT ["/docker-php-entrypoint.sh"]

STOPSIGNAL SIGQUIT

# EXPOSE 80
CMD ["bash"]
