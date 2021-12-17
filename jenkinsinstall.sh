# STEP 1 - Install the EPEL REPO Packages, YUM and 
# Install WGET Package to download Jenkins file
sudo yum install epel-release
sudo -E yum -y update 
sudo yum -y install wget

# STEP 2 - Download and install JAVA 1.8.0 (Later we can update the stable and suitable version for jenkins)
# Marking path variables for Java
sudo yum -y install java-1.8.0-openjdk.x86_64
java -version
sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

# STEP 3 - Download jenkins repo into yum repo here
# Install Jenkins
# Start the Jenkins service
sudo -E wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo -E rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo -E yum -y install jenkins
sudo chkconfig jenkins on
sudo service jenkins restart

# STEP 4 - We need FirewallD Service enabled and running
# Jenking runs on 8080 port for need to add tcp rule in firewalld
# Restart Firewalld service
systemctl enable firewalld
systemctl start firewalld
sudo -E firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all

# FINAL STEP - Get the ADMIN Initnal Password from below command
#sudo cat /var/lib/jenkins/secrets/initialAdminPassword
