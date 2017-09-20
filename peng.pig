/*
data = load '/user/hdfs/peng/11.txt' as (
     record:chararray
);
split_data = foreach data generate STRSPLIT(record, ':',2);

split_data = foreach split_data generate $0.$0 as AB, REPLACE(TRIM($0.$1), '\\.', '');

SPLIT split_data into data_a IF AB == 'A', data_b IF AB == 'B';

rmf /user/hdfs/peng/11_a
store data_a into '/user/hdfs/peng/11_a';

rmf /user/hdfs/peng/11_b
store data_b into '/user/hdfs/peng/11_b';

data = load '/user/hdfs/peng/21.txt' as (
     record:chararray
);
split_data = foreach data generate STRSPLIT(record, ':',2);

split_data = foreach split_data generate $0.$0 as AB, REPLACE(TRIM($0.$1), '\\.', '');

SPLIT split_data into data_a IF AB == 'A', data_b IF AB == 'B';

rmf /user/hdfs/peng/21_a
store data_a into '/user/hdfs/peng/21_a';

rmf /user/hdfs/peng/21_b
store data_b into '/user/hdfs/peng/21_b';
*/

a11 = load '/user/hdfs/peng/11_a' as (
         labela:chararray,
         numbera:long
);

a21 = load '/user/hdfs/peng/21_a' as (
         labela:chararray,
         numberb:long
);

join_data = CROSS a11, a21;

cross_data = foreach join_data generate $1 - $3 as diff;

gp_data = GROUP cross_data by diff;

ct_data = foreach gp_data generate group, COUNT(cross_data) as number;

result = ORDER ct_data by number DESC;

result = limit result 500;

store result into '/user/hdfs/peng/11_21_result';

