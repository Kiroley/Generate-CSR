$getdate = Get-Date
$nameexchsvr = Get-ExchangeServer
$accepteddomains = Get-AcceptedDomain
$template = New-Object -TypeName System.Collections.ArrayList

$template.Add("[NewRequest]")
$template.add('Subject = "CN=' + ($NAMEEXCHSVR.Fqdn) + '"')

$template.Add('Friendlyname = "ExchangeCert'+($getdate.Year)+'"')
$template.Add("Exportable = FALSE")
$template.Add("KeyLength = 2048")
$template.Add("MachineKeySet = True")
$template.Add('ProviderName = "Microsoft Software Key Storage Provider"')
$template.Add("RequestType = PKCS10") 
$template.Add("[Extensions]")
$template.Add('2.5.29.17 = "{text}" ; SAN - Subject Alternative Name')
$template.Add('_continue_ = "dns=' + ($nameexchsvr.Domain) + '&"')
$template.Add('_continue_ = "dns=mail.' + ($nameexchsvr.Domain) + '&"')
$template.Add('_continue_ = "dns=' + ($nameexchsvr.Fqdn) + '&"')

If ($accepteddomains.count -gt 1) 
{
        foreach ($domain in $accepteddomains)
        {
            If ($domain.default -eq $false)
            {
                $template.Add('_continue_ = "dns=' + ($domain.Name) + '&"')
            }
        }    
}
$template.Add('_continue_ = "dns=autodiscover.' + ($nameexchsvr.Domain) + '"')
$template | Out-File .\request.inf

certreq -new .\request.inf ('.\' + ($nameexchsvr.Fqdn) + '.req')
