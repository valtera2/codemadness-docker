FROM alpine:3.20.3

# Install frontends
RUN apk update && apk add codemadness-frontends lighttpd

# Copy project files
COPY . /app

# Set working directory
WORKDIR /app

COPY ./lighttpd.conf /etc/lighttpd/
RUN mkdir -p /var/www/localhost/cgi-bin
#COPY /usr/bin/youtube-cgi /var/www/localhost/cgi-bin/
COPY ./youtube-cgi /var/www/localhost/cgi-bin/
RUN chgrp -R lighttpd /var/www/localhost/cgi-bin/
RUN chmod -R 775 /var/www/localhost/cgi-bin/
# Expose port 8000
EXPOSE 8000

# Start the lighttpd server
#CMD ["php", "-S", "0.0.0.0:8000", "-t", "."]
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
