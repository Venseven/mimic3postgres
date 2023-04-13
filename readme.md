# Setting up PostgreSQL Docker container for MIMIC-III

This guide will show you how to set up a PostgreSQL Docker container for MIMIC-III, a public database of de-identified electronic health record data for over 45,000 ICU patients.

## Prerequisites

Before you start, make sure you have Docker installed on your machine.

## Steps

1. Run the following command to build the Docker image:

   ```bash
   docker build -t my-postgres-db ./
    ```
2. Spin up the PostgreSQL container using the following command:

   ```bash
   docker run --name mimic3 -p 5432:5432 my-postgres-db
    ```
3. You can now access the database from localhost:5432. 
Alternatively, you can bash into the Docker container to interact with the database by running the following commands:

    ```bash
    docker exec -it mimic3 bash
    ```
    ```bash
    psql -U postgres
    ```