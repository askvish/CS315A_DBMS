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

# Database Files
db1='cs315_1'
db2='cs315_2'
db3='cs315_3'
db4='cs315_4'
db5='cs315_5'
db6='cs315_6'
db7='cs315_7'
db8='cs315_8'
db9='cs315_9'

# For total time
start=$(date +%s%N)

./mongodb.sh ${data1[@]} $db1
./mongodb.sh ${data2[@]} $db2
./mongodb.sh ${data3[@]} $db3
./mongodb.sh ${data4[@]} $db4
./mongodb.sh ${data5[@]} $db5
./mongodb.sh ${data6[@]} $db6
./mongodb.sh ${data7[@]} $db7
./mongodb.sh ${data8[@]} $db8
./mongodb.sh ${data9[@]} $db9

# echo show dbs; | mongo --quiet
# cs315_1  0.000GB
# cs315_2  0.000GB
# cs315_3  0.000GB
# cs315_4  0.000GB
# cs315_5  0.000GB
# cs315_6  0.001GB
# cs315_7  0.002GB
# cs315_8  0.010GB
# cs315_9  0.089GB

end=$(date +%s%N)
echo "Elapsed time: $(($(($end - $start)) / 1000000000)) s"
