
# Google Cloud Storage

durable and highly available object storage.
Object storage is a computer data storage architecture that manages data as “objects”
These objects are stored in a packaged format which contains the binary form of the actual data itself, and metadata and unique id.
Object storage interacts well with web technologies
binary large-object (BLOB)
Cloud Storage files are organized into buckets (unique name and zone)
Objects are immutable and have versions with each change
To Control the access and If you need finer control (than with IAM), you can create access control lists.
The access control list define: who can access and perform an action, and what actions can be performed.
Lifecycle management policies
Auto-class moves data that is not access to colder storage classes to reduce storage costs
Storage transfer service enables you to import large amounts of online data into Cloud storage quickly and cost effectively.
Cloud Storage also offers directory synchronization so that you can sync a VM directory with a bucket.
versioning, wher each version is charged as file. when versioning is off the bucket stop accumulating new versions. 
The Autoclass feature automatically transitions objects in your bucket to appropriate storage classes based on the access pattern of each object.

Storage classes:
- Standard storage is considered best for frequently accessed or hot data
- Nearline storage (low-cost) is for infrequently accessed data (once a 30 days or less)
- Coldline storage (very-low-cost) is for infrequently accessed data (once every 90 days)
- Archive storage (lowest-cost) is for data that you plan to access less than once a year (lowest cost)

There are three services that allows you to upload terabytes of data: 
- Transfer Appliance
- Storage Transfer Service, enables high-performance imports of online data
- Offline Media Import is a third party service where physical media (such as storage arrays, hard disk drives, tapes, and USB flash drives) is sent to a provider who uploads the data
