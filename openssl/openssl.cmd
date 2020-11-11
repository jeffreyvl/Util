openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout {domain}.key -out {domain}.crt 

openssl pkcs12 -export -out {domain}.pfx -inkey {domain}.key -in {domain}.crt 
