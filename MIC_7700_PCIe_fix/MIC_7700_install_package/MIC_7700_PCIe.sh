#!/bin/sh -e
#
# Server machine: Advantech IPC MIC-7700
# This script is for enabling the GSI PCIe 64GB prefetchable.
# Detail information is recorded in redmine task #1070
# Jonathan Huang 2020/05/22


sudo apt-get update
sudo update-pciids
sudo apt install dialog
sudo apt install ssh
sudo apt install net-tools
mkdir ~/jonathan1
mkdir ~/jonathan1/GSI
cp host-pcie-tests-ver-1-1-13.tar.gz ~/jonathan1/GSI/
cd ~/jonathan1/GSI/
tar -zxvf host-pcie-tests-ver-1-1-13.tar.gz
sudo ~/jonathan1/GSI/release_ver/x86/install/host-test-installation-kit-x86-222.run
sudo chmod 755 /usr/local/bin/dialog-menu /usr/local/bin/dev_diagnostic-100_10_0_1


cd -
echo "sudo cp rc-local.service /etc/systemd/system/"
sudo cp rc-local.service /etc/systemd/system/
echo "sudo cp rc.local /etc/"
sudo cp rc.local /etc/
echo "sudo chmod +x /etc/rc.local"
sudo chmod +x /etc/rc.local
echo "sudo systemctl enable rc.local"
sudo systemctl enable rc.local
echo "star and check the service"
sudo systemctl start rc-local.service
sudo systemctl status rc-local.service
cat /usr/local/test.log
