## Give azure ad user read permissions 
```
Create user [t@t.com] from external provider;
exec sp_addrolemember 'db_datareader', [t@t.com];
```
https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-powershell#create-contained-database-users-in-your-database-mapped-to-azure-ad-identities
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
