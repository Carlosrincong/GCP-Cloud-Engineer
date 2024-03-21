 
# BIGTABLE

Cloud Bigtable is Google's NoSQL Big data database service.
Bigtable is designed to handle massive workloads at consistent low latency and high throughput.
great choice:
- storage service that is compatible with the HBase API
- for both operational and analytical applications
- if they're working with more than one terabyte of semi-structured or structured data
- Data is fast with high throughput, or it's rapidly changing
- NoSQL
- Data is a time-series or has natural semantic ordering.
- Big data running asynchronous batch or synchronous real-time processing on the data running machine learning algorithms on the data.
- Bigtable is best for analytical data with heavy read and write events, like AdTech, financial, or IoT data.
- wide-column database
- ‘fast lookup’ non-relational database for datasets too large to store in memory
- If you don’t require transactional consistency (firestore)
- Great storage engine for machine learning applications

Features:
- The smallest Cloud Bigtable cluster you can create has three nodes and can handle 30,000 operations per second.
- Cloud Bigtable integrates easily with popular big data tools like Hadoop, Cloud Dataflow, and Cloud Dataproc.
- Cloud Bigtable stores data in massively scalable tables, each of which is a sorted key/value map.
- The table is composed of rows, each of which typically describes a single entity, and columns, which contain individual values for each row.
- Cloud Bigtable tables are sparse; if a cell does not contain any data, it does not take up any space.