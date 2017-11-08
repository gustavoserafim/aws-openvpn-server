# aws-openvpn-server

Create an OpenVPN Server on AWS to access your VPC

## Create an EC2

Launch an Instance with an Ubuntu Server 16.04 LTS AMI
Select Micro or small ??
Select the network you are using for your VPC instances
Create a Security Group with ports TCP 22 and UDP 1194 open
From the list of instances, select the VPN instance and then Networking->Change Source/Dest. Check from the drop down menu. Then click Yes, Disable. This is needed as otherwise, your VPN server will not be able to connect to your other EC2 instances.
Create an Elastic IP Address

## Set up

    $ sudo su -
    $ git clone https://github.com/gustavoserafim/aws-openvpn-server.git
    $ chmod -R 700 aws-openvpn-server
    $ nano aws-openvpn-server/config.sh
    Update config.sh and fill in your own config
    $ ./aws-openvpn-server/update.sh
    $ ./aws-openvpn-server/openvpn.sh
    $ vim  /etc/openvpn/server.conf
    Add this:
    push "route 172.16.0.0 255.255.0.0"
    $ systemctl restart openvpn@server


## Add a client

The following should be repeated for each new client/user for whom you wish to grant access to your VPN. Replace client-name with a unique name.

    $ sudo su -
    $ ./aws-openvpn-server/add-client.sh client-name

You will then find a file like the following that you should provide to the individual who will be connecting to your VPN. This ovpn file can then be used with your VPN Client.

    ~/client-configs/files/client-name.ovpn


## Revoke client certificate

If you ever need to revoke access, simply execute:

    $ sudo su -
    $ ./aws-openvpn-server/revoke-full.sh client-name

## Copy configuration file to your local machine

Download the ovpn file to your local device, on your terminal type:
sftp -i ~/.ssh/YOUR_PEM.pem ubuntu@SERVER_IP:client-configs/files/CLIENT-NAME.ovpn ~/


## TODO

- line 46 on openvpn.sh don't work with sed
- Revoke is not working correctly
- Improve paths
- Update it to a CloudFormation Script


## Extra Info

* See [How To Set Up an OpenVPN Server on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-16-04)
* See [Using a VPN Server to Connect to Your AWS VPC for Just the Cost of an EC2 Nano Instance](https://hackernoon.com/using-a-vpn-server-to-connect-to-your-aws-vpc-for-just-the-cost-of-an-ec2-nano-instance-3c81269c71c2)
