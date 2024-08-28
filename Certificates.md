#Certificates

## Adding secret to PFX
- when uploading a pfx to keyvault, you must add a password
- when downloading a pfx from keyvault, it never has a password
- so in some cases, you must add a password yourself
- in some tools, like openssl, a password is asked but you can simply leave it empty in those cases.

```
openssl pkcs12 -in cert.pfx -out temp.pem -nodes
openssl pkcs12 -export -out cert.pfx -in temp.pem
Enter Export Passord:
Verifying - Enter Export Password:
```

## Reviewing full chain

### If the certificate is uploaded to a webapp
https://www.sslshopper.com/ssl-checker.html

### If the certificate is local
- open openssl (on windows, you might have to look for the openssl tool in the search bar instead of via the terminal)
- Convert to PEM: openssl pkcs12 -in file.pfx -out file.pem -nodes
- open using a text editor. Here, you will should see intermediate certificates. Using the browser or your local certificate store wont work because it is "enriched" by those tools.

### Adding an intermediate certificate to your certificate
