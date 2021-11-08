## How to create a read-only syst user
1. create a connection in your local "microsoft SQL server management studio"
2. select master database

```
CREATE LOGIN [abc] WITH PASSWORD='*****'
ALTER ROLE [db_datareader] ADD MEMBER [abc]
CREATE USER [abc] FROM LOGIN [abc]
```
3. Select database
```
CREATE USER [abc] FROM LOGIN [abc]
```
https://stackoverflow.com/questions/2777422/in-sql-azure-how-can-i-create-a-read-only-user
## Show users
```
SELECT * FROM sys.sysusers;
```
