#  Citrix License Usage Reporting

## Description
Script allowing you to retrieve information about the status of your Citrix licenses server.

- Report in html
- Local storage of reports and possibility to send them by email
- Configurable Usage Percentage Rang

## Configuration 

he entire configuration is done in the configuration file 
"MyScriptPath\Config\config.xml"


## Variables in config.xml

### Date Format
- Date Format
  - Key="DATEFOR"
    - https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7

### Report Directory And Name
- Report Directory Name
  - Key="REPDIR" 
- Report Name
  - Key="REPNAME"

### Client Information
- Client Name Information
  - Key="CLIENTNAME"

### Email Configuration
- Enable Email
  - Key="EMAILSEND"
    - 0 = Disabled / 1 = Enabled
- Email TO Address
  - Key="EMAILTO"      
- Email FROM Address
  - Key="EMAILFROM"    
- Email Subject
  - Key="EMAILSUBJ"    
- Email Body
  - Key="EMAILBODY"    
- Email Server
  - Key="EMAILSERVER"  
- Email Server Port
  - Key="EMAILPORT"    
     
### License Use Threshold
- License Treshold Minimum For Ok Status
  - Key="LICTREMIOK"
- License Treshold Maximum For Ok Status
  - Key="LICTREMAOK"
- License Treshold Minimum For Warning Status
  - Key="LICTREMIWA"
- License Treshold Maximum For Warning Status
  - Key="LICTREMAWA"
- License Treshold Minimum For Critical Status
  - Key="LICTREMIKO"
- License Treshold Maximum For Critical Status 
  - Key="LICTREMAKO" 

# Change Log 
V1.00 - 03/10/2020 - Initial version 

