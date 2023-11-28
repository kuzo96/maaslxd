# syntax=docker/dockerfile:1
FROM repo.cpt.gov.vn/staging/librenms-28-11:1.7
# COPY ./docker-php-entrypoint.sh /

ENTRYPOINT ["/docker-php-entrypoint.sh"]

STOPSIGNAL SIGQUIT

EXPOSE 80
CMD ["bash"]
