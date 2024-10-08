  #!/bin/bash

  # Function to generate a random password
  generate_password() {
    openssl rand -base64 12
  }

  # CREATE WORDPRESS DIRECTORY
  DIR="/home/olli/data/wordpress"
  if [ -d "$DIR" ]; then
    rm -fr "$DIR"
    echo -e "\e[33m✔\e[0m Directory $DIR removed."
  fi
  mkdir -p "$DIR"
  echo -e "\e[32m✔\e[0m Directory $DIR created."

  # CREATE MARIADB DIRECTORY
  DIR="/home/olli/data/mariadb"
  if [ -d "$DIR" ]; then
    rm -fr "$DIR"
    echo -e "\e[33m✔\e[0m Directory $DIR removed."
  fi
  mkdir -p "$DIR"
  echo -e "\e[32m✔\e[0m Directory $DIR created."

  # CREATE SECRETS DIRECTORY AND GENERATE PASSWORDS
  DIR="./secrets"
  if [ -d "$DIR" ]; then
    rm -fr "$DIR"
    echo -e "\e[33m✔\e[0m Directory $DIR removed."
  fi
  mkdir -m 775 "$DIR"
  echo -e "\e[32m✔\e[0m Directory $DIR created."
  generate_password > "$DIR/wp_user_password.txt"
  generate_password > "$DIR/wp_root_password.txt"
  generate_password > "$DIR/db_password.txt"
  generate_password > "$DIR/db_root_password.txt"
  echo -e "\e[32m✔\e[0m Secrets created."

  # CREATE SSL CERTIFICATES
  if [ ! -f "$DIR/inception.crt" ] || [ ! -f "$DIR/inception.key" ]; then
    openssl req -x509 -nodes -out "$DIR/inception.crt" -keyout "$DIR/inception.key" -subj "/C=DE/ST=IDF/L=BERLIN/O=42/OU=42/CN=okrahl.42.fr/UID=okrahl.42.fr" 2> /dev/null
    echo -e "\e[32m✔\e[0m SSL certificates created."
  else
    echo -e "\e[33m✔\e[0m SSL certificates already exist."
  fi

  # SET PERMISSIONS FOR SSL CERTIFICATES
  chmod 644 "$DIR/inception.crt"
  chmod 644 "$DIR/inception.key"

  # CREATE ENV VARIABLES
  if [ -f "srcs/.env" ]; then
    rm -fr "srcs/.env"
    echo -e "\e[33m✔\e[0m .env file removed."
  fi
  echo "DOMAIN_NAME=okrahl.42.fr" >> "srcs/.env"
  echo "#mariadb" >> "srcs/.env"
  echo "MDB_USER=okrahl" >> "srcs/.env"
  echo "MDB_DB_NAME=database" >> "srcs/.env"
  echo "#wordpress" >> "srcs/.env"
  echo "WP_TITLE=inception" >> "srcs/.env"
  echo "WP_ADMIN_NAME=okrahl" >> "srcs/.env"
  echo "WP_ADMIN_EMAIL=okrahl@gmail.com" >> "srcs/.env"
  echo "WP_USER_NAME=user" >> "srcs/.env"
  echo "WP_USER_EMAIL=user@gmail.com" >> "srcs/.env"
  echo "WP_USER_ROLE=author" >> "srcs/.env"
  echo -e "\e[32m✔\e[0m .env file created."