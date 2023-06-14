## Give azure ad user read permissions 
```
Create user [t@t.com] from external provider;
exec sp_addrolemember 'db_datareader', [t@t.com];
```
https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-powershell#create-contained-database-users-in-your-database-mapped-to-azure-ad-identities

## How to create a read-only SQL user
1. create a connection in your local "microsoft SQL server management studio"
2. select **master** database

```
CREATE LOGIN myUserName   
    WITH PASSWORD = 'replaceMe';  
GO
```
3. Select database
```
CREATE USER myUserName FOR LOGIN myUserName ;  
GO
ALTER ROLE [db_datareader] ADD MEMBER myUserName
```
https://stackoverflow.com/questions/2777422/in-sql-azure-how-can-i-create-a-read-only-user
## Show users
```
SELECT * FROM sys.sysusers;
```
