# Container's image
FROM perl:5.32.1

LABEL maintainer="bedoshi <bedoshi@example.com>"

WORKDIR /app
# Execute with `docker build`
RUN cpanm Plack -n
RUN cpanm LINE::Bot::API -n
RUN cpanm Acme::CoC::Dice -n
ENV PORT 3000
EXPOSE 3000
EXPOSE 8080
# Execute with `docker run`
COPY synopsis.psgi /root/synopsis.psgi
COPY lib /root/lib
# Execute webserver with psgi file.
CMD plackup -Ilib --listen :$PORT synopsis.psgi

COPY . /app
