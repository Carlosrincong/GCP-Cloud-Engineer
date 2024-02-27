
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

Storage classes:
- Standard storage is considered best for frequently accessed or hot data
- Nearline storage is for infrequently accessed data (once a month or less)
- Coldline storage is for infrequently accessed data (once every 90 days)
- Archive storage is for data that you plan to access less than once a year (lowest cost)