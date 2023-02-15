path_location=$(pwd)
echo -e "\e[31m installing nginx \e[0m"
yum install nginx -y
echo -e "\e[32m enabling nginx \e[0m"
systemctl enable nginx
echo -e "\e[33m starting nginx \e[0m"
systemctl start nginx
echo -e "\e[34m downloading frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[35m removing old existing content\e[0m"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
echo -e "\e[36m extracting frontend contents \e[0m"
unzip /tmp/frontend.zip
echo -e "\e[31m copying reverse proxy\e[0m"
cp ${path_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[32m restarting nginx\e[0m"
systemctl restart nginx