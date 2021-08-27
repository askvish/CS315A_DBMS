#!/bin/bash

echo "Hello and Welcome to the MongoDB..."

dataA=$1  # Data for table A
dataB=$2  # Data for table B
dbFile=$3 # database to store tables

echo "Existing databases..."
echo "show dbs;" | mongo --quiet

# drop if already exists
mongo $dbFile --quiet <<EOF
    db;
    db.dropDatabase(); 
EOF

echo "Database $dbFile is dropped..."

# Show present databses
mongo $dbFile --quiet <<EOF
    print("Databases present...")
    show dbs;
EOF
echo "Creating and using database, ${dbFile}..."

# importing csv files to collections
mongoimport -d $dbFile -c A --type csv --file ./data/$dataA --headerline
echo "data/$dataA is inserted in table A..."
mongoimport -d $dbFile -c B --type csv --file ./data/$dataB --headerline
echo "data/$dataB is inserted in table B..."

# Show the collection presents
mongo $dbFile --quiet <<EOF
    print("Collections present...")
    show collections;
EOF

echo "Query begins..."
start=$(date +%s%N)

mongo $dbFile --quiet <<\EOF
    db.A.find().pretty();
    db.B.find().pretty();
    db.A.find( { 'A1':{$lte:50} } );
    db.B.find().sort( {'B3':1} );
    db.B.find( { B3: /^a/ } ).count();
EOF

end=$(date +%s%N)
echo "Elapsed time: $(($(($end - $start)) / 1000000)) ms"
echo "Bye"