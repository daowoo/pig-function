su hdfs 
pig 
cd hdfs:///
ls 

--copyFromLocal /home/hdfs/math.py hdfs://nn.daowoo.com:8020/pig_data/ ;
--copyFromLocal /home/hdfs/math.txt hdfs://nn.daowoo.com:8020/pig_data/
--ls pig_data
--cat pig_data/math.py

math = load'pig_data/math.txt'as(number:int)
--dump math
describe math 

REGISTER 'pig_data/math.py' USING jython AS mathfuncs;
whatmath = foreach math generate mathfuncs.square(number) as squareSchema