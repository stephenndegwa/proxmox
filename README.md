# Proxmox Automation Scripts

This repository contains **Proxmox automation scripts** for deploying virtual machines using **Cloud-Init** and Ubuntu cloud images. These scripts help streamline VM creation, configuration, and management in a **Proxmox Virtual Environment (PVE).**

## 📌 Features
- **Automated VM Creation** – Quickly set up Ubuntu cloud images on Proxmox.
- **Cloud-Init Configuration** – Automatically configures user credentials, networking, and boot options.
- **Customizable Parameters** – Easily modify VM specs, storage, and network settings.
- **Static IP Addressing** – Preconfigure VMs with a static IP for easy access.

---

## 📂 Available Scripts
| Script Name | Description |
|-------------|------------|
| `proxmox-ubuntu-20-cloud-image-setup.sh` | Creates and configures an Ubuntu 20.04 Cloud Image VM on Proxmox using Cloud-Init. |
| `proxmox-ubuntu-22-cloud-image-setup.sh` | Similar to the above but for Ubuntu 22.04. |
| More coming soon... | Additional scripts for VM automation, backups, and optimizations. |

---

## ⚡ Getting Started

### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/stephenndegwa/proxmox.git
cd proxmox
```

### **2️⃣ Choose a Script**
Modify the script variables as needed (`nano script-name.sh`) before running.

### **3️⃣ Run the Script**
Make it executable:
```bash
chmod +x script-name.sh
```
Execute:
```bash
./script-name.sh
```

---

## 🖥️ Example: Ubuntu 20.04 Cloud Image Setup
```bash
./proxmox-ubuntu-20-cloud-image-setup.sh
```
This will:
1. **Download the Ubuntu 20.04 cloud image** (if not already present).
2. **Create a VM with Cloud-Init support.**
3. **Assign static IP, hostname, and user credentials.**
4. **Start the VM, making it ready for SSH access.**

---

## 📌 Notes
- Ensure **Proxmox VE** is installed and running.
- Modify script variables (`VM_ID`, `MEMORY`, `CORES`, etc.) to fit your environment.
- Cloud-Init **requires a DHCP or manually assigned IP** for first boot.

---

## 🛠️ Contributions
Want to contribute? Feel free to **fork**, improve, or submit issues.

---

## 📜 License
This project is **MIT Licensed**. You’re free to use and modify it.

---

## 👤 Author
Stephen Ndegwa
[[Stephen Ndegwa](https://github.com/stephenndegwa/)]

