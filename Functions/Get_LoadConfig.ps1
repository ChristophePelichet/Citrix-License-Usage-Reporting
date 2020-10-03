Function Get_LoadConfig () 
{
<#

███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗████████╗     ██╗      ██████╗  █████╗ ██████╗  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔════╝ ██╔════╝╚══██╔══╝     ██║     ██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
█████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║    ██║  ███╗█████╗     ██║        ██║     ██║   ██║███████║██║  ██║██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║    ██║   ██║██╔══╝     ██║        ██║     ██║   ██║██╔══██║██║  ██║██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╔╝███████╗   ██║███████╗███████╗╚██████╔╝██║  ██║██████╔╝╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝   ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
Version 1.1                                                                                                                                                                                     

.SYNOPSIS 
Get_LoadConfig.ps1 - Simple function to load a variable configuration file external to the script.

.DESCRIPTION
Simple function to load a variable configuration file external to the script.

.INPUTS
N/A

.OUTPUTS
N/A

.CONFIGURATION
N/A

.LINK
N/A

.EXAMPLE
Before you can load your external configuration file, you must add these 2 lines at the beginning of your script before the code to execute.

$MYFunctionPath  = $MyScriptPath + "\Functions"
$MyConfPath      = $MyScriptPath + "\Config\config.xml"

You can change the variable name and the path if you want.

After adding this 2 line you can lot you configuration with this code 

# Load Configuration 
$MyLoadConf = $MYFunctionPath +"\"+ "Get_LoadConfig.ps1"
	. $MyLoadConf
	Get_LoadConfig -path $MyConfPath

.NOTES
Written by: Christophe Pelichet (c.pelichet@gmail.com)
 
Find me on: 
 
* LinkedIn:     https://linkedin.com/in/christophepelichet
* Github:       https://github.com/ChristophePelichet
 
Change Log 
V1.01 - 03.10.2020 - Update Information and clean code
V1.00 - 03/10/2020 - Initial version
#>

########################################################
######################## Path ##########################
########################################################

# No Path

########################################################
###################### Functions #######################
########################################################

# No Functions

#######################################################
###################### Variables ######################
#######################################################

# No variables

#######################################################
######################## Code #########################
#######################################################


	Param 
	(
		[Parameter(Mandatory=$true)][string]$Path
	)


	$global:appSettings = @{}
	$config = [xml](get-content $path)

		foreach ($addNode in $config.configuration.appsettings.add) {
			if ($addNode.Value.Contains(‘,’)) 
			{
			# Array case
				$value = $addNode.Value.Split(‘,’)
				for ($i = 0; $i -lt $value.length; $i++) 
				{ 
				$value[$i] = $value[$i].Trim() 
				}
			}
			else 
			{
			# Scalar case
				$value = $addNode.Value
			}
				$global:appSettings[$addNode.Key] = $value
		}
}

#######################################################
###################### End Code #######################
#######################################################