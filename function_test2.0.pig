su hdfs
pig
cd hdfs:///
mkdir hdfs://nn.daowoo.com:8020/pig_data;
ls

copyFromLocal /home/hdfs/killers.txt hdfs://nn.daowoo.com:8020/pig_data/
copyFromLocal /home/hdfs/us.txt hdfs://nn.daowoo.com:8020/pig_data/
copyFromLocal /home/hdfs/student.txt hdfs://nn.daowoo.com:8020/pig_data/
copyFromLocal /home/hdfs/oppostudent.txt hdfs://nn.daowoo.com:8020/pig_data/
copyFromLocal /home/hdfs/math.txt hdfs://nn.daowoo.com:8020/pig_data/

killer = load 'pig_data/killers.txt' as(decade:chararray,men:int,women:int);
dump killer
killerUS = load 'pig_data/us.txt' as (decade:chararray,menUS:int,womenUS:int); 
--dump killerUS;      --（仅美国连环杀手的个数）
student = load 'pig_data/student.txt' using PigStorage(',') as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray, gpa:int)
--dump student;       --（学生信息 firstname,lastname）
oppostudent = load 'pig_data/oppostudent.txt'using PigStorage(',') as (id:int,name:chararray,age:int,city:chararray);
--dump oppostudent;   --(学生信息 name）
math = load 'pig_data/math.txt' as (no:float);

--AVG
killer_group = group killer all;
killer_menavg = foreach killer_group generate (killer.decade,killer.men),AVG(killer.men);
killer_womenavg = foreach killer_group generate (killer.decade,killer.women),AVG(killer.women);
dump killer_menavg;
dump killer_womenavg;

--DIFF
cokiller = cogroup killer by decade,killerUS by decade;
dump cokiller;
diffkiller = cokiller generate DIFF(killer,killerUS);
dump diffkiller;

--CONCAT(用于连接两个或多个相同类型的表达式)
student_concat = foreach student generate CONCAT(firstname,lastname);
dump student_concat;

--SUM
groupkillerall = group killer all;
killer_sum_men = foreach groupkillerall generate (killer.decade,killer.men),SUM(killer.men);
killer_sum_women = foreach groupkillerall generate (killer.decade,killer.women),SUM(killer.women);
dump killer_sum_men;
dump killer_sum_women;

--TOKENIZE（用于分割）
token_oppostudent = foreach oppostudent generate TOKENIZE(name);
dump token_oppostudent;

--SUBSTRING(给定字符串返回子字符串）
substring_student = foreach student generate (id,age) SUBSTRING(lastname,0,4);
dump substring_student;

--RANDOM
random_math = foreach math generate (no),RANDOM(no);
dump random_math;

--INDEXOF（返回字符串中第一个出现的字符，从开始索引向前搜索）
indexof_student = foreach student generate (firstname),INDEXOF(lastname,'r',1);
dump indexof_student;

--TOTUPLE(转换为元祖）
totuple_student = foreach student generate TOTUPLE(id,lastname,firstname,age);
dump totuple_student;

--ENDSWITH(验证结尾）
endwith_student = foreach student generate (id,firstname,lastname), ENDSWITH(lastname,'e');
dump endwith_student;