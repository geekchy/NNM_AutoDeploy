#!/bin/sh
trafficbuild=$1
nnmihost=$2
trafficmaster=$3
trafficleaf=$4
npshost=$5
if [ -d "/opt/OV/Uninstall/HPOvTRMiSPI" ]; then
	/opt/OV/Uninstall/HPOvTRMiSPI/setup.bin -i silent -uninstall
fi
mkdir -p /Traffic
rm -rf /Traffic/*
mkdir -p /Traffic/auto-deploy
chmod 777 /Traffic/auto-deploy
#cp ./silentInstallMaster.properties ./silentInstallExt.properties ./silentInstallLeaf.properties /Traffic/auto-deploy
cd /Traffic/auto-deploy
wget -r -nd -np -A "NMC-NNMi-Perf-Traffic-Lin*.tar.gz" ${trafficbuild}
#BUILD_ID=DONTKILLME
chmod a+x *
tar -xvf *.tar.gz
cp ./Traffic_Master/silentInstallMaster.properties /tmp
sed -i "s/PRIMARY.NNM.HOSTNAME.*$/PRIMARY.NNM.HOSTNAME=${nnmihost}/g" /tmp/silentInstallMaster.properties
sed -i "s/TRAFFIC.MASTER.HOSTNAME.*$/TRAFFIC.MASTER.HOSTNAME=${trafficmaster}/g" /tmp/silentInstallMaster.properties
sed -i "s/NPS.HOST.NAME.*$/NPS.HOST.NAME=${npshost}/g" /tmp/silentInstallMaster.properties
./Traffic_Master/Installer.Linux2.6_64/setup.bin -i silent
/opt/OV/traffic-master/bin/nmstrafficmasterstart.ovpl
/opt/OV/traffic-master/bin/nmstrafficmasterstatus.ovpl