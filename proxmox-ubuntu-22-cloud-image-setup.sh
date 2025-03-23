```bash
# Proxmox Ubuntu 22.04 Cloud Image Setup Script

# Variables
VM_ID=3002  # Change this as needed
VM_NAME="ubuntu22-cloud"
STORAGE="local-lvm"
MEMORY=2048   # 2GB RAM
CORES=2       # 2 CPU cores
DISK_SIZE=20G # 20GB disk space

# Step 1: Download Ubuntu 22.04 Cloud Image
cd /var/lib/vz/template/iso
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# Step 2: Create a new VM
qm create $VM_ID --name $VM_NAME --memory $MEMORY --cores $CORES --net0 virtio,bridge=vmbr0

# Step 3: Import the Cloud Image as a Disk
qm importdisk $VM_ID jammy-server-cloudimg-amd64.img $STORAGE

# Step 4: Attach the Disk to the VM
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$VM_ID-disk-0
qm set $VM_ID --ide2 $STORAGE:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID --serial0 socket --vga serial0

# Step 5: Set Up Cloud-Init
qm set $VM_ID --ciuser ubuntu --cipassword 'SecurePass123!'  # Change the password
qm set $VM_ID --ipconfig0 ip=dhcp  # Change to static IP if needed
qm set $VM_ID --sshkeys ~/.ssh/id_rsa.pub  # Ensure you have an SSH key

# Step 6: Resize the Disk (Optional)
qm resize $VM_ID scsi0 +10G  # Adds 10GB more to the disk

# Step 7: Start the VM
qm start $VM_ID

# Step 8: Find VM IP and SSH into it
qm guest exec $VM_ID -- ip a
ssh ubuntu@<VM-IP>
```

