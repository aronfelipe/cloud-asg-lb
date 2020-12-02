##################################################################
# User data PostgreSQL EC2.
##################################################################

locals {
  user_data_database = <<EOF
#!/bin/bash
sudo apt update
sudo apt install postgresql postgresql-contrib -y
sudo -u postgres createuser -s aron
sudo -u postgres createdb aron
sudo -u postgres psql -c "ALTER USER aron WITH PASSWORD 'a87c2a44-e0bf-4b21-932e-8a8a93168383';"
sudo -u postgres psql -c "CREATE DATABASE webserver;"
sudo adduser --disabled-password --gecos "" aron
sudo sed -i "$ a listen_addresses='*'" /etc/postgresql/10/main/postgresql.conf
sudo sed -i '/127.0.0.1/c\host    all             all             all            md5' /etc/postgresql/10/main/pg_hba.conf
sudo service postgresql restart
EOF
}

##################################################################
# User data Auto Scalling Group Lauch Configuration web server.
##################################################################

locals {
  user_data = <<EOF
#!/bin/bash
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
cd home/ubuntu/
git clone https://e34676733fba490b4f5b8c0f41351e6a52521e8c@github.com/aronfelipe/nestjs-jwt-postgres
cd nestjs-jwt-postgres
yarn
yarn build
echo "[Unit]" >> /etc/systemd/system/webserver.service
echo "Description=NodeJSWebserver" >> /etc/systemd/system/webserver.service
echo "After=network.target" >> /etc/systemd/system/webserver.service
echo "[Service]" >> /etc/systemd/system/webserver.service
echo "Environment='DATABASE_HOST='${module.db.public_dns[0]}''" >> /etc/systemd/system/webserver.service
echo "Environment='DATABASE_PORT=5432'" >> /etc/systemd/system/webserver.service
echo "Environment='DATABASE_USERNAME='aron''" >> /etc/systemd/system/webserver.service
echo "Environment='DATABASE_PASSWORD='a87c2a44-e0bf-4b21-932e-8a8a93168383''" >> /etc/systemd/system/webserver.service
echo "Environment='DATABASE_NAME='webserver''" >> /etc/systemd/system/webserver.service
echo "Environment='PASSWORD='c4407209-5864-41aa-8bd3-55b02363d3c4''" >> /etc/systemd/system/webserver.service
echo "Environment='JWT='833696b6-7a48-473f-aa47-16fa0387eb54''" >> /etc/systemd/system/webserver.service
echo "Type=simple" >> /etc/systemd/system/webserver.service
echo "User=ubuntu" >> /etc/systemd/system/webserver.service
echo "ExecStart=/usr/bin/node /home/ubuntu/nestjs-jwt-postgres/dist/main.js" >> /etc/systemd/system/webserver.service
echo "Restart=on-failure" >> /etc/systemd/system/webserver.service
echo "[Install]" >> /etc/systemd/system/webserver.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/webserver.service
sudo systemctl enable webserver.service
sudo systemctl start webserver.service
EOF
}