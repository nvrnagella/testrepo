path_location=$(pwd)
echo -e "\e[31m downloading nodejs rpm vendor provided\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m installing nodejs \e[0m"
yum install nodejs -y
echo -e "\e[33m adding roboshop user\e[0m"
useradd roboshop
echo -e "\e[34m creating app directory\e[0m"
mkdir /app
echo -e "\e[35m downloading catalogue content\e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m extracting catalogue content \e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[32m installing dependencies for nodejs\e[0m"
npm install
echo -e "\e[33m copying service file\e[0m"
cp ${path_location}/files/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[34m loading catalogue service file\e[0m"
systemctl daemon-reload
echo -e "\e[31m enabling and starting catalogue\e[0m"
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[35m copying repo file to load schema\e[0m"
cp ${path_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m installing mongodb client for loading the schema\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[31m loading schema\e[0m"
mongo --host 172.31.55.71 </app/schema/catalogue.js