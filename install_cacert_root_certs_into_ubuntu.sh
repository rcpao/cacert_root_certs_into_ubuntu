#!/bin/bash -vx


# Test cases:
# wget https://www.cacert.org/certs/root_X0F.crt
curl https://www.cacert.org/certs/root_X0F.crt


# sudo apt-get install -y ca-certificates

[ -f root_X0F.crt ] && rm root_X0F.crt
wget --no-check-certificate https://www.cacert.org/certs/root_X0F.crt

[ -f CAcert_Class3Root_x14E228.crt ] && rm CAcert_Class3Root_x14E228.crt 
wget --no-check-certificate https://www.cacert.org/certs/CAcert_Class3Root_x14E228.crt

sudo cp *.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

CACERTSFILE=/etc/ssl/certs/ca-certificates.crt
# for CRTFILE in root_X0F.crt CAcert_Class3Root_x14E228.crt; do
for CRTFILE in *.crt; do
    CRTLINE2=$(sed -n '2p' $CRTFILE)
    grep $CRTLINE2 $CACERTSFILE
    RC=$?
    [ $RC -ne 0 ] && echo "error $0:$LINENO: $CRTFILE was _not_ found in $CACERTSFILE"
done


# Test cases:
# wget https://www.cacert.org/certs/root_X0F.crt
curl https://www.cacert.org/certs/root_X0F.crt
