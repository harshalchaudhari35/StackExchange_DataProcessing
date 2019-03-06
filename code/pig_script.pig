REGISTER '/home/hduser/pig/pig-0.17.0/lib/piggybank.jar';
REGISTER '/home/hduser/hive/apache-hive-3.1.1-bin/hcatalog/share/hcatalog/hive-hcatalog-core-3.1.1.jar'
define CSVLoader org.apache.pig.piggybank.storage.CSVLoader();


data_stack = LOAD 'R_2.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE') AS(Id:int, PostTypeId:int, AcceptedAnswerId:int, ParentId:int, CreationDate:datetime, DeletionDate:datetime, Score:int, ViewCount:int, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName:chararray, LastEditDate:datetime, LastActivityDate:datetime, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:datetime, CommunityOwnedDate:datetime);

-- We are going to select only the required fields
A = foreach data_stack generate Id, Score, ViewCount, OwnerUserId, OwnerDisplayName, Title, Tags;

STORE A INTO 'output' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','NOCHANGE','WRITE_OUTPUT_HEADER');





------------------Ignore below script--------------



--store data_stack into 'new_stack' USING org.apache.hive.hcatalog.pig.HCatStorer();

-------- Top 10 posts by Score
--C = order data_stack by Score DESC;
--B = foreach C generate Score, Title;
--A = limit B 50;
--dump A;

--X = order data_stack by Score DESC;
--Y = foreach X generate Score, OwnerUserId, OwnerDisplayName;
--Z = limit Y 10;
--Store Z into 'out' using org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','NOCHANGE','WRITE_OUTPUT_HEADER');

--W = foreach data_stack generate OwnerUserId, Tags;
--K = distinct W;
--Q = filter K by (Tags matches '.*hadoop*.');
--M = group Q by OwnerUserId;
--T = COUNT(M);
--dump T; 




--D = filter data_stack by (Tags matches '.*hadoop*.');
--E = foreach D {
--	unique= Distinct data_stack.OwnerUserId; 
--	generate group, COUNT(unique) as cnt;
-- };
--J = DISTINCT E;
--F = GROUP J all;
--G = foreach F generate count(E);
--dump E;



--C = foreach data_stack generate Score;
-- org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE')
--define Excel org.apache.pig.piggybank.storage.CSVExcelStorage();

--rm new_posts
--store A into 'new_posts' using PigStorage(','); 

--sorted = ORDER data_stack BY Score DESC;
--top10 = LIMIT sorted 10;
--title = foreach top10 generate Title;
--store title into 'new_posts' using PigStorage(',');

