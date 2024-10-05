# FILESTORE

Filestore is a managed file storage service for applications that require a **file system interface and a shared file system** for data. offers full **NFSV3** support. 

Uses cases:

- Application migration, for applications wich require a file system interface to data.
- Media rendering, using shared file system
- Electronic Design Automation
- Data analytics workloads include Compute complex financial models or analysis of environmental data.
- Web content management and WordPress hosting.

To know:
- configure firewall rules to enable NFS file locking.
- its necessary to mount the file system to the VM before the set the firewall rules (ingress/egress)
- mount the file system using : ip-address:/file-share mount-point-directory in the VM. where ip-address:/file-share was defined at the file sytem´s creation time. 
- mount-point-directory is the path where you want to map the Filestore file share to.