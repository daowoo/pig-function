su hdfs 
pig 
cd hdfs:///
ls pig_data

--copyFromLocal /home/hdfs/k222.txt hdfs://nn.daowoo.com:8020//user/hdfs/pig_data/
k22 = load 'pig_data/k222.txt' as(AAC001:chararray,AKC227:float);
describe k22;
groupk22 = group k22 by AAC001 ;
dump groupk22;
sumk22 = foreach groupk22 generate SUM(k22.AKC227) as(price:double);
--dump sumk22;

--Median
define Median datafu.pig.stats.StreamingMedian();
medk22 = foreach (group sumk22 all) generate Median(sumk22.price);
dump medk22;

--quantiles
define Quantile datafu.pig.stats.StreamingQuantile('0.3','0.5','0.9');
quank22 = foreach (group sumk22 all)generate Quantile(sumk22.price);
dump quank22;

--variance
define VAR datafu.pig.stats.VAR();
vark22 = foreach(group sumk22 all)generate VAR(sumk22.price);
dump vark22;