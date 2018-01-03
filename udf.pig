su hdfs 
pig
cd hdfs:///
a = load 'pig_data/math.txt' as(number:float)
--dump a
register 'hdfs://nn.daowoo.com:8020/pig_data/square.py' using org.apache.pig.scripting.jytho
n.JythonScriptEngine as myfuncs;             
--没找到为什么不能直接register 'square.py' ........
b = foreach a generate myfuncs.square(*)
dump b
--结果显示为a各数字的平方    

--若a有5个数，则输入
b = foreach a generate myfuncs.square(3)
dump b
--结果显示5个9