$domains = @("localhost", "example.com")
$friendlyName = "SelfSignedServerCertificate"

# Check if certificate exists and if so delete it
# Only use when friendlyName is not empty
Get-ChildItem cert: -recurse | Where-Object { $_.DnsName -like $domains } | Remove-Item

# create a self signed certificate for all supplied domains

$params = @{
    CertStoreLocation = "cert:\LocalMachine\My"
    DnsName           = $domains
    FriendlyName = $friendlyName
}
   
# generate new certificate and add it to certificate store
$cert = New-SelfSignedCertificate @params

# Exporting certificate
$privateKey = "$friendlyName.pfx"
$publicKey = "$friendlyName.cer"

# Export Public key, to share with other users
Export-Certificate -FilePath $publicKey -Cert $cert

$pass = ("P@ssword" | ConvertTo-SecureString -AsPlainText -Force)

# Export private key as PFX certificate, to use those Keys on different machine/user
Export-PfxCertificate -FilePath $privateKey -Cert $cert -Password $pass

# Copy the certificate to Root certificates stroe

$rootCert = Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath $publicKey;
$rootCert.FriendlyName = $friendlyName;

# Create a new https binding in IIS for supplied domain

ForEach ($domain in $domains) 
{
    Write-Host $domain;
    $binding = (Get-WebBinding -Name $domain -HostHeader $domain | where-object { $_.protocol -eq 'https' });

    if ($null -ne $binding) { Remove-WebBinding -Name $domain -Port 443 -Protocol https -HostHeader $domain };
  
    New-WebBinding -Name $domain -Port 443 -Protocol https -HostHeader $domain;
    (Get-WebBinding -Name $domain -Port 443 -Protocol https -HostHeader $domain).AddSslCertificate($cert.Thumbprint, 'my');
}
