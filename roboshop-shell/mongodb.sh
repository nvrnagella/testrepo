path_location=$(pwd)
echo -e "\e[36m copying mongodb repo file \e[0m"
cp ${path_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m installing mongodb\e[0m"
yum install mongodb-org -y
echo -e "\e[32m enabling mongodb \e[0m"
systemctl enable mongod
echo -e "\e[33m starting mongodb \e[0m"
systemctl start mongod
echo -e "\e[34m updating 127.0.0.1 to 0.0.0.0\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "\e[35m restarting mongodb \e[0m"
systemctl restart mongod

