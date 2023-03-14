# Generate-CSR
Use this script to quickly create a new certificate request based on a .INF file using some common parameters found in your exchange environment

# Usage
Save this script to a folder you wish to operate from, this same folder will contain the generated .INF and .REQ files

Run this script from the Exchange Management Shell (or from ISE/Powershell, just make sure to run add-psssnapin '*'exchange'*' first)

Navigate to the folder containing the script and execute (.\Generate-CSR.ps1)

It will then collect some basic information from your Exchange environment, create a .INF (template) file, then generate a CSR against that template.

# Examples

(From Powershell),

Add-PssSnapin **Exchange**

SL C:\Certificates

.\Generate-CSR.ps1

Once run navigate to the c:\Certificates folder and open the .req file (then complete through your CA/PKI team)
