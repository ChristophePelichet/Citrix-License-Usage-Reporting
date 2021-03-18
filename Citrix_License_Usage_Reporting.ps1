<#
 ██████╗██╗████████╗██████╗ ██╗██╗  ██╗    ██╗     ██╗ ██████╗███████╗███╗   ██╗███████╗███████╗    ██╗   ██╗███████╗ █████╗  ██████╗ ███████╗    ██████╗ ███████╗██████╗  ██████╗ ██████╗ ████████╗██╗███╗   ██╗ ██████╗ 
██╔════╝██║╚══██╔══╝██╔══██╗██║╚██╗██╔╝    ██║     ██║██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝    ██║   ██║██╔════╝██╔══██╗██╔════╝ ██╔════╝    ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝ 
██║     ██║   ██║   ██████╔╝██║ ╚███╔╝     ██║     ██║██║     █████╗  ██╔██╗ ██║███████╗█████╗      ██║   ██║███████╗███████║██║  ███╗█████╗      ██████╔╝█████╗  ██████╔╝██║   ██║██████╔╝   ██║   ██║██╔██╗ ██║██║  ███╗
██║     ██║   ██║   ██╔══██╗██║ ██╔██╗     ██║     ██║██║     ██╔══╝  ██║╚██╗██║╚════██║██╔══╝      ██║   ██║╚════██║██╔══██║██║   ██║██╔══╝      ██╔══██╗██╔══╝  ██╔═══╝ ██║   ██║██╔══██╗   ██║   ██║██║╚██╗██║██║   ██║
╚██████╗██║   ██║   ██║  ██║██║██╔╝ ██╗    ███████╗██║╚██████╗███████╗██║ ╚████║███████║███████╗    ╚██████╔╝███████║██║  ██║╚██████╔╝███████╗    ██║  ██║███████╗██║     ╚██████╔╝██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝
 ╚═════╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝    ╚══════╝╚═╝ ╚═════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝     ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝  ╚═╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
Version 1.0
                                                                                                                                                              
.SYNOPSIS
Citrix_License_Usage_Report.ps1 - Simple script to check Citrix license usage.

.DESCRIPTION
Script allowing you to retrieve information about the status of your Citrix licenses server.

- Report in html
- Local storage of reports and possibility to send them by email
- Configurable Usage Percentage Range

.INPUTS
N/A

.OUTPUTS
Report in html format

.CONFIGURATION

the entire configuration is done in the configuration file 
"MyScriptPath\Config\config.xml"

Show the Readme.md in the github repository for all variables explanation (https://github.com/ChristophePelichet/Citrix-License-Usage-Reporting/blob/main/README.md)

.LINK
N/A

.EXAMPLE
N/A

.NOTES
Written by: Christophe Pelichet (c.pelichet@gmail.com)
 
Find me on: 
 
* LinkedIn:     https://linkedin.com/in/christophepelichet
* Github:       https://github.com/ChristophePelichet
 
Change Log 
V1.00 - 03/10/2020 - Initial version 
#>



########################################################
######################## Path ##########################
########################################################

$MyScriptPath    = split-path -parent $MyInvocation.MyCommand.Definition
$MYFunctionPath  = $MyScriptPath + "\Functions"
$MyConfPath      = $MyScriptPath + "\Config\config.xml"

########################################################
###################### Functions #######################
########################################################

# Load Configuration 
$MyLoadConf = $MYFunctionPath +"\"+ "Get_LoadConfig.ps1"
	. $MyLoadConf
	Get_LoadConfig -path $MyConfPath

# Load Css Design Function
$MyLoadConf = $MYFunctionPath +"\"+ "Get_DesignCss.ps1"
. $MyLoadConf 

#######################################################
###################### Variables ######################
#######################################################


## Date Format
$DATEFOR = $appSettings["DATEFOR"]
$DATE    = (Get-Date -UFormat "$DATEFOR")

## Report Directory And Name
$REPDIR     = $appSettings["REPDIR"]
$REPNAME    = $appSettings["REPNAME"]
$REPFULL    = $MyScriptPath +"\"+ $REPDIR +"\"+ $REPNAME +"_"+ $DATE +".html"

## Client Information
$CLIENTNAME = $appSettings["CLIENTNAME"]

## License Use Threshold
$LICTREMIOK = $appSettings["LICTREMIOK"]
$LICTREMAOK = $appSettings["LICTREMAOK"]
$LICTREMIWA = $appSettings["LICTREMIWA"]
$LICTREMAWA = $appSettings["LICTREMAWA"]
$LICTREMIKO = $appSettings["LICTREMIKO"]
$LICTREMAKO = $appSettings["LICTREMAKO"]

## Email Configuration
$EMAILSEND = $appSettings["EMAILSEND"]
$EMAILTO   = $appSettings["EMAILTO"]
$EMAILFROM = $appSettings["EMAILFROM"]
$EMAILSUBJ = $appSettings["EMAILSUBJ"]
$EMAILBODY = $appSettings["EMAILBODY"]
$EMAILPORT = $appSettings["EMAILPORT"]
$EMAILSERVER = $appSettings["EMAILSERVER"]

#######################################################
######################## Code #########################
#######################################################

## HTML Report (Start)
$htmlReport = ""                                 # Reset Report
$htmlReport = $htmlReport + $Head                # Add $Head from Get_DesignCss.ps1"
$htmlReport = $htmlReport +
"<table>" +
"<colgroup><col/><col/></colgroup>" +
"<tr><td class='blank_line'></td></tr>" +
"<tr><th>" + "CLIENT" + "</th>" + "<th>" + "DATE" + "</th>" +
"<tr><td>" + "$CLIENTNAME" + "</td>" + "<td>" + $DATE + "</td></tr>" +
"<tr><td class='blank_line'></td></tr>" +
"<tr><th>" + "License Server" + "</th>" + "<th>" + "License Type" + "</th>" + "<th>" + "Number Of License" + "</th>" + "<th>" + "License Used" + "</th>"  + "<th>" + "Percentage Of Use" + "</th></tr>"


## Get License Usage 
$CTXLICDATA = Get-WmiObject -class "Citrix_GT_License_Pool" -namespace "ROOT\CitrixLicensing"

## Start Loop For Get Information
$CTXLICDATA | Select-Object pld -Unique | ForEach-Object {
    $CTXLICINFO = "" | Select-Object License, Count, Usage, Used, Alert, PSComputerName, SubscriptionDate

    ## Get All Report Informations

    # Get License Type
    $CTXLICINFO.License = $_.pld

    # Get License Count By License Type
    $CTXLICINFO.Count = ($CTXLICDATA | Where-Object {$_.pld -eq $CTXLICINFO.License } | Measure-Object -Property Count -sum).sum

    # Get License Usage By License Type 
    $CTXLICINFO.Usage = ($CTXLICDATA | Where-Object {$_.pld -eq $CTXLICINFO.License } | Measure-Object -Property InUseCount -sum).sum
    
    # Get % License Used
    $CTXLICINFO.Used = [Math]::Round($CTXLICINFO.Usage / $CTXLICINFO.Count * 100)

    # Get License Server Hostname
    $CTXLICINFO.PSComputerName = ($CTXLICDATA | Where-Object {$_.pld -eq $CTXLICINFO.License }).PSComputerName

    ## Data modification
    # License User Color By Treshold
    if ($CTXLICINFO.Used -ge $LICTREMIOK -and $CTXLICINFO.Used -le $LICTREMAOK) {
        $CTXLICINFO.Used = "<td class='green_answer'>" + $CTXLICINFO.Used
    } elseif ($CTXLICINFO.Used -ge $LICTREMIWA -and $CTXLICINFO.Used -le $LICTREMAWA) {
        $CTXLICINFO.Used = "<td class='orange_answer'>" + $CTXLICINFO.Used
    } elseif ($CTXLICINFO.Used -ge $LICTREMIKO -and $CTXLICINFO.Used -le $LICTREMAKO) {
        $CTXLICINFO.Used = "<td class='red_answer'>" + $CTXLICINFO.Used
    }

    # License Name More Understanding
    # Citrix License Server Diagnostics
    if ($CTXLICINFO.License -match "CTXLSDIAG" ) { $CTXLICINFO.License = "Citrix License Server Diagnostics"}

    # Citrix Virtual Apps and Desktops Premium
    if ($CTXLICINFO.License -match "XDT_PLT_UD" ) { $CTXLICINFO.License = "Citrix Virtual Apps and Desktops Premium"}

    # Citrix Gateway Advanced Edition (VPN)|simultanés
    if ($CTXLICINFO.License -match "CAG_AAC_CCU" ) { $CTXLICINFO.License = "Citrix Gateway Advanced"}

    # Citrix Gateway Standard Edition
    if ($CTXLICINFO.License -match "CAG_SSLVPN_CCU" ) { $CTXLICINFO.License = "Citrix Gateway Standard Edition"}

    # Citrix Gateway Advanced Edition (VPN)|simultanés
    if ($CTXLICINFO.License -match "CNS_SSLVPN_CCU" ) { $CTXLICINFO.License = "Citrix Gateway Advanced Edition (VPN)"}

    
    ## Add Information To Report
    $htmlReport = $htmlReport +
    "<tr><td>" + $CTXLICINFO.PSComputerName + "</td>" + "<td>" + $CTXLICINFO.License + "</td>" + "<td>" + $CTXLICINFO.Count + "</td>" + "<td>" + $CTXLICINFO.Usage  + "</td>" + $CTXLICINFO.Used + "%" +"</td></tr>"
}

## HTML Report (End)
$htmlReport= $htmlReport +
"<tr><td class='blank_line'></td></tr>" +
"</table>" +
"<br>" +
"<p><strong><u> License Treshold Usage</u></p></strong>"+
"<p>Treshold Ok       : $LICTREMIOK to $LICTREMAOK % - (Green Color)</p>"+
"<p>Treshold Warning  : $LICTREMIWA to $LICTREMAWA % - (Orange Color)</p>"+
"<p>Treshold Critical : $LICTREMIKO to $LICTREMAKO % - (Red Color)</p>"+
"</body></html>"

## Write Report 
$htmlReport | Out-File -FilePath $REPFULL

## Reportin Email
if ($EMAILSEND -eq "1") {
    Send-MailMessage -From $EMAILFROM To $EMAILTO.split(';') -Subject "$EMAILSUBJ - $DATE" -Body "$EMAILBODY $CLIENTNAME" -Attachments $REPFULL  -SmtpServer $EMAILSERVER -Port $EMAILPORT
}

#######################################################
###################### End Code #######################
#######################################################
