# PostgreSQL Migration Service

This template repo was built to facilitate a data migration from a standalone Postgres instance to a Postgres Cluster running in [Railway](https://docs.railway.app/).

Optionally, by setting an environment variable, it can also set up replication between the standalone instance and the Cluster.  More info on this below.

## How to use this template

Deploy this service into your Railway project and configure the required variables:

- `PRIMARY_URL` - URL of the primary node in your cluster.  
*If you've just deployed the Postgres cluster from the [template in Railway](https://railway.app/template/ha-postgres), the primary node should be `pg-0`.*
- `STANDALONE_URL` - URL of the standalone Postgres instance.
- `RAILWAY_API_TOKEN` - Your [Railway API token](https://docs.railway.app/reference/public-api#authentication).

**It is highly recommended to deploy these services into the same Railway project, to take advantage of the private network.**

When setting the URLs, you can either hardcode the values, or use [reference variables](https://docs.railway.app/guides/variables#reference-variables).  An example of both is shown in the image below.

![screenshot](/images/variables.png)

Once deployed, the script will connect to the standalone instance and dump each database within.  It will then restore each of them to the Primary node in the cluster to be replicated among the standby nodes.

## Optional: Set up replication

This script can also set up replication between the standalone Postgres instance and cluster, to maintain a data sync after the initial migration.

This is useful for those who wish to test the cluster prior to moving traffic from their application.

To set up replication, simply update the value of the pre-configured environment variable:
- `SETUP_REPLICATION=true`

**WARNING**: This will restart your standalone Postgres instance in order to apply the wal_level configuration required to replicate data.