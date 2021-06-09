#-------------------------------------------------------------------------------------
# Create Self signed root certificate
# -dnsname -DnsName domain.example.com,anothersubdomain.example.com
# -Subject "CN=Patti Fuller,OU=UserAccounts,DC=corp,DC=contoso,DC=com" 
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=P2SRootCert" `
-KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 4096 `
-CertStoreLocation "Cert:\CurrentUser\My" `
-KeyUsageProperty Sign `
-KeyUsage CertSign `
-NotAfter (Get-Date).AddYears(5)

# Generate certificates from root (For Client Authentication only) (Not for web server)
New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=P2SChildCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-NotAfter (Get-Date).AddMonths(24) `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")

# Generate certificate from root for web service
New-SelfSignedCertificate -Type Custom `
-Subject "CN=P2SChildCertWeb" -KeyExportPolicy Exportable `
-DnsName "sub.domain.com","www.domain.com","192.168.1.1" `
-HashAlgorithm sha256 -KeyLength 2048 `
-KeyUsage "KeyEncipherment", "DigitalSignature" `
-NotAfter (Get-Date).AddMonths(24) `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert

# if not on the same powershell session (Take note of the thumbprint)

Get-ChildItem -Path "Cert:\CurrentUser\My"
$cert = Get-ChildItem -Path "Cert:\CurrentUser\My\THUMBPRINT"

# Delete Certificate with key
Remove-Item -Path "cert:\LocalMachine\CA\THUMBPRINT" -DeleteKey

# Export as PFX
$PFXPass = ConvertTo-SecureString -String "MyPassword" -Force -AsPlainText

Export-PfxCertificate -Cert cert:\CurrentUser\My\THUMBPRINT `
-Password $PFXPass `
-FilePath C:\TEMP\Service-adatum-local.pfx

# Export Normal
# Exports a certificate to the file system as a DER-encoded .cer file without its private key.
Export-Certificate -Cert $cert -FilePath c:\certs\user.cer

# Exports a certificate to the file system as a PKCS#7-fomatted .p7b file without its private key.
Export-Certificate -Cert $cert -FilePath c:\certs\user.p7b -Type p7b



#-----------------------------------------------------------
# Certificate Types 
# https://docs.microsoft.com/en-us/powershell/module/pkiclient/new-selfsignedcertificate?view=win10-ps
# EKU TYPES (Enhanced Key Usage) (2.5.19.37)

# Signing Software (1.3.6.1.5.5.7.3.3)
-KeySpec "Signature"
-KeyUsage "DigitalSignature"

# Normal Web Server Usage (1.3.6.1.5.5.7.3.1) (1.3.6.1.5.5.7.3.2)
# FOR  "Server Authentication", "Client authentication"
-KeyUsage "KeyEncipherment, DigitalSignature"

# Email (1.3.6.1.5.5.7.3.4 )"
-KeyUsage "KeyEncipherment, DigitalSignature"

#Timestamping (1.3.6.1.5.5.7.3.8 )


#---------------------------------------------------------------
# Text Extension for the ROOT CA (2.5.29.19 Basic Constraint)
-TextExtension @("2.5.29.19 ={critical} {text}ca=1&pathlength=3")
# Where ca=1 defines the cert as a signing CA and pathlength=3 is arbitrary- it defines how many SubCa's can be present

# For the Subordinate certificate
-TextExtension @("2.5.29.19 = {critical} {text}ca=1&pathlength=0")
# Where ca=1 defines the cert as a signing CA and pathlength=0 defines that there is no other signing CA'a below this one.

# -------------------------------------------------------

# Purpose of Certificate 			Required Key Usage Bit
CA Signing							keyCertSign
									cRLSign
										
Certificate Signing					keyCertSign
										
SSL Client							digitalSignature
SSL Server							keyEncipherment
	
Object Signing						digitalSignature
	
S/MIME Signing						digitalSignature
S/MimE Encryption					keyEncipherment