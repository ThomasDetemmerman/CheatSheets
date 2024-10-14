## use VSCode extention "rest client"

### LOGIN
POST https://login.microsoftonline.com/000000tenant00000/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default
&client_id=*********
&client_secret=*********



### delete user

delete https://graph.microsoft.com/v1.0/users/<objectid>
Content-Type: application/json
Authorization: Bearer ey
