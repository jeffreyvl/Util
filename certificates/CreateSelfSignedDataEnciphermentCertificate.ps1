$name = "signingcert.local"
$friendlyName = "SigningCert"
$store = "cert:\CurrentUser\My"

# Check if certificate exists and if so delete it
# Only use when friendlyName is not empty
Get-ChildItem cert: -recurse | Where-Object { $_.Subject -like "CN=$name" } | Remove-Item

$params = @{
 CertStoreLocation = $store
 FriendlyName = $friendlyName
 Subject = "CN=$name"
 KeyLength = 2048
 KeyAlgorithm = "RSA" 
 KeyUsage = "DataEncipherment"
 Type = "DocumentEncryptionCert"
}

# generate new certificate and add it to certificate store
$cert = New-SelfSignedCertificate @params

# list all certs 
# Get-ChildItem -path $store

# Encryption / Decryption

$message = "My secret message"

$cipher = $message  | Protect-CmsMessage -To "CN=$name" 
Write-Host "Cipher:" -ForegroundColor Green
$cipher

Write-Host "Decrypted message:" -ForegroundColor Green
$cipher | Unprotect-CmsMessage

# Exporting/Importing certificate

$pass = ("P@ssword" | ConvertTo-SecureString -AsPlainText -Force)
$privateKey = "$friendlyName.pfx"
$publicKey = "$friendlyName.cer"

# Export private key as PFX certificate, to use those Keys on different machine/user
Export-PfxCertificate -FilePath $privateKey -Cert $cert -Password $pass

# Export Public key, to share with other users
Export-Certificate -FilePath $publicKey -Cert $cert

#Remove certificate from store
$cert | Remove-Item

# Add them back:

# Add private key on your machine
Import-PfxCertificate -FilePath $privateKey -CertStoreLocation $store -Password $pass

# This is for other users (so they can send you encrypted messages)
Import-Certificate -FilePath $publicKey -CertStoreLocation $store