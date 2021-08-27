#!/bin/bash

# Data for table A and B
data1=(A-100.csv B-100-3-1.csv)
data2=(A-100.csv B-100-5-0.csv)
data3=(A-100.csv B-100-10-1.csv)
data4=(A-1000.csv B-1000-5-0.csv)
data5=(A-1000.csv B-1000-10-0.csv)
data6=(A-1000.csv B-1000-50-0.csv)
data7=(A-10000.csv B-10000-5-1.csv)
data8=(A-10000.csv B-10000-50-0.csv)
data9=(A-10000.csv B-10000-500-1.csv)

# Databases Files
db1='cs315_1.db'
db2='cs315_2.db'
db3='cs315_3.db'
db4='cs315_4.db'
db5='cs315_5.db'
db6='cs315_6.db'
db7='cs315_7.db'
db8='cs315_8.db'
db9='cs315_9.db'

# For total execution time
start=$(date +%s%N)

./sqlite3.sh ${data1[@]} $db1
./sqlite3.sh ${data2[@]} $db2
./sqlite3.sh ${data3[@]} $db3
./sqlite3.sh ${data4[@]} $db4
./sqlite3.sh ${data5[@]} $db5
./sqlite3.sh ${data6[@]} $db6
./sqlite3.sh ${data7[@]} $db7
./sqlite3.sh ${data8[@]} $db8
./sqlite3.sh ${data9[@]} $db9

end=$(date +%s%N)
echo "Total execution time: $(($(($end - $start)) / 1000000000)) s"
