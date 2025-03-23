#!/bin/bash
# Proxmox Ubuntu 20.04 Cloud Image Setup Script

# Variables (Change these before running)
VM_ID=3001
VM_NAME="my-vm.example.com"
MEMORY=1024
CORES=1
DISK_SIZE=20G
STATIC_IP="192.168.100.50"
GATEWAY="192.168.100.1"
USERNAME="cloudadmin"
PASSWORD="ChangeMe123!"
PROXMOX_SERVER="your-proxmox-server-ip"
STORAGE="local-lvm"

# SSH into the Proxmox server
ssh root@$PROXMOX_SERVER <<EOF

# Move to template storage and download Ubuntu 20.04 cloud image
cd /var/lib/vz/template/iso
wget -N https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# Create the VM
qm create $VM_ID --name $VM_NAME --memory $MEMORY --cores $CORES --net0 virtio,bridge=vmbr0

# Import Ubuntu 20.04 cloud image
qm importdisk $VM_ID focal-server-cloudimg-amd64.img $STORAGE

# Attach the imported disk
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$VM_ID-disk-0

# Resize the disk
qm resize $VM_ID scsi0 $DISK_SIZE

# Attach Cloud-Init drive
qm set $VM_ID --ide2 $STORAGE:cloudinit

# Set boot options
qm set $VM_ID --boot c --bootdisk scsi0 --serial0 socket --vga serial0

# Configure Cloud-Init: Set user, password, hostname, and DNS
qm set $VM_ID --ciuser $USERNAME --cipassword '$PASSWORD' --searchdomain example.com --nameserver 8.8.8.8

# Assign a static IP address
qm set $VM_ID --ipconfig0 ip=$STATIC_IP/24,gw=$GATEWAY

# Generate Cloud-Init configuration
qm cloudinit dump $VM_ID user

# Start the VM
qm start $VM_ID

EOF

echo "VM setup complete! You can now SSH into the VM: ssh $USERNAME@$STATIC_IP"
echo "Remember to change the default password after first login."
echo "Use the following command to access the VM console:"
echo "qm terminal $VM_ID"
echo "To access the Proxmox web interface, go to: https://$PROXMOX_SERVER:8006"
echo "Make sure to replace 'your-proxmox-server-ip' with the actual IP address of your Proxmox server."
echo "Enjoy your new Ubuntu 20.04 Cloud Image VM!"
echo "Note: This script assumes you have SSH access to your Proxmox server and the necessary permissions to create VMs."
echo "If you encounter any issues, please check the Proxmox logs for more information."
echo "For more details on Cloud-Init configuration, refer to the Proxmox documentation."
echo "You can also customize the Cloud-Init configuration further by modifying the script."
echo "For example
# - To add SSH keys, use the --sshkey option.
# - To set up additional users, use the --user option.
# - To configure network interfaces, use the --ipconfig option.
# - To set up custom scripts, use the --customize option.
