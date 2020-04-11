# mailpile-docker
Custom Mailpile (https://www.mailpile.is) Docker Image based on Alpine 3.10.4

# docker-compose.yml
```yaml
version: '3.7'
services:
  mailpile:
    container_name: mailpile
    image: techzone/mailpile:1.0.0rc6
    volumes:
      - ${PWD}/Mailpile:/root/.local/share/Mailpile
      - ${PWD}/gnupg:/root/.gnupg
    ports:
      - 127.0.0.1:33411:33411
    restart: always
```

# run the container
```sh
docker-compose up -d
```

# access Mailpile
http://127.0.0.1:33411
