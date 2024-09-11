
# CLOUD SQL

Cloud SQL offers fully managed relational databases, including MySQL, PostgreSQL, and SQL Server as a service
It supports automatic replication scenarios
Cloud SQL supports managed backups
Includes a network firewall, which controls network access to each database instance
When your application does not reside in the same VPC connected network and region as your Cloud SQL instance, use a proxy to secure its external connection.

The most secure way to connecting to Cloud SQL is Cloud SQL proxy, because use IAM permisions to the users o service accounts. Also, Cloud SQL Proxy handles sql authentication. This method excludes IP validation 

Read replicas reduce the load on the primary instance. There are different types: in-region, external, cross-region.
Read replica is a copy of the primary instance which is in read only mode. A read replica can be promoted to have write and read capabilities, but this cannot be undone. This new primary instance is disconnected with the previously primary instance. 

Standby Instance is the instance in the same region as the primary, where the traffic is directed when the primary instance is unavaible. That is the high availability arquitecture which requires a regional persistent disk along with a persistent disk for each instance primary and standby. 