#!/bin/bash

echo "Hello and Welcome to the mariadb..."

dataA=$1  # Data for table A
dataB=$2  # Data for table B
dbFile=$3 # database to store tables

echo "Existing databases..."
echo "show databases" | sudo mariadb

# drop if already exists
sudo mariadb -e "DROP DATABASE $dbFile"

echo "Current databases..."
echo "show databases" | sudo mariadb

sudo mariadb -e "CREATE DATABASE IF NOT EXISTS $dbFile"

echo "Creating $dbFile database..."

sudo mariadb $dbFile <<EOF

CREATE TABLE IF NOT EXISTS A (
                    A1 INT PRIMARY KEY NOT NULL,
                    A2 TEXT NOT NULL
                    );
CREATE TABLE IF NOT EXISTS B (
                    B1 INT PRIMARY KEY NOT NULL,
                    B2 INT NOT NULL, B3 TEXT NOT NULL
                    );

EOF

echo "Table A and B is created in $dbFile..."

# importing csv

sudo mariadb $dbFile <<EOF
    LOAD DATA LOCAL INFILE './data/$dataA'
    INTO TABLE A
    FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (A1, A2)

EOF
echo "./data/$dataA is imported to table A..."

sudo mariadb $dbFile <<EOF
    LOAD DATA LOCAL INFILE './data/$dataB'
    INTO TABLE B
    FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (B1, B2, B3)

EOF
echo "./data/$dataB is imported to table B..."

echo "Query begins..."
start=$(date +%s%N)

sudo mariadb $dbFile <<EOF
    
    SELECT * FROM A WHERE A1 <=50;
    SELECT * FROM B ORDER BY B2;
    SELECT B2, COUNT(*) FROM B GROUP BY B2;
    SELECT A2, B1, B2, B3 FROM A, B WHERE A.A1 = B.B2;

EOF

end=$(date +%s%N)
echo "Elapsed time: $(($(($end - $start)) / 1000000000)) s"
echo "Bye"
