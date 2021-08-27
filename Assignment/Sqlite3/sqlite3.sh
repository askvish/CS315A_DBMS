#!/bin/bash

echo "Hello and Welcome to the SQLite3..."

dataA=$1  # Data for table A
dataB=$2  # Data for table B
dbFile=$3 # database to store tables

# delete if exists
rm -f ./dbs/$dbFile

echo "Databse ./dbs/$dbFile is created..."
#SQLite3 begins here
sqlite3 ./dbs/$dbFile <<'END_SQL'

CREATE TABLE IF NOT EXISTS A (
                    A1 INT PRIMARY KEY NOT NULL,
                    A2 TEXT NOT NULL
                    );
CREATE TABLE IF NOT EXISTS B (
                    B1 INT PRIMARY KEY NOT NULL,
                    B2 INT NOT NULL, B3 TEXT NOT NULL
                    );

END_SQL

echo "Table A and B is created in $dbFile..."

# importing csv
sqlite3 ./dbs/$dbFile -csv ".import './data/$dataA' A"
echo "data/$dataA is imported to table A..."
sqlite3 ./dbs/$dbFile -csv ".import './data/$dataB' B"
echo "data/$dataB is imported to table B..."

echo "Query begins..."
start=$(date +%s%N)

sqlite3 ./dbs/$dbFile <<'EOF'
.header on
.mode column

SELECT * FROM A WHERE A1 <=50;
SELECT * FROM B ORDER BY B2;
SELECT B2, COUNT(*) FROM B GROUP BY B2;
SELECT A2, B1, B2, B3 FROM A, B WHERE A.A1 = B.B2;
EOF

end=$(date +%s%N)
echo "Elapsed time: $(($(($end - $start)) / 1000000000)) s"
echo "Bye"
