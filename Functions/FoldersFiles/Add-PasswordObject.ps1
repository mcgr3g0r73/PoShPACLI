﻿Function Add-PasswordObject {

	<#
    .SYNOPSIS
    	Stores a password object in the specified safe.

    .DESCRIPTION
    	Exposes the PACLI Function: "STOREPASSWORDOBJECT"

    .PARAMETER vault
        The name of the Vault where the password object is stored.

    .PARAMETER user
        The Username of the User who is carrying out the task.

    .PARAMETER safe
        The name of the Safe where the password object is stored

    .PARAMETER folder
        The name of the folder where the password object is stored.

    .PARAMETER file
        The name of the password object.

    .PARAMETER password
        The password being stored in the password object.

    .PARAMETER sessionID
    	The ID number of the session. Use this parameter when working
        with multiple scripts simultaneously. The default is ‘0’.

    .EXAMPLE
    	A sample command that uses the function or script, optionally followed
    	by sample output and a description. Repeat this keyword for each example.

    .NOTES
    	AUTHOR: Pete Maan
    	LASTEDIT: July 2017
    #>

	[CmdLetBinding()]
	param(
		[Parameter(Mandatory = $True)][string]$vault,
		[Parameter(Mandatory = $True)][string]$user,
		[Parameter(Mandatory = $True)][string]$safe,
		[Parameter(Mandatory = $True)][string]$folder,
		[Parameter(Mandatory = $True)][string]$file,
		[Parameter(Mandatory = $True)][securestring]$password,
		[Parameter(Mandatory = $False)][int]$sessionID
	)

	If(!(Test-ExePreReqs)) {

		#$pacli variable not set or not a valid path

	}

	Else {

		#$PACLI variable set to executable path

		#deal with password SecureString
		if($PSBoundParameters.ContainsKey("password")) {

			$PSBoundParameters["password"] = ConvertTo-InsecureString $password

		}

		$Return = Invoke-PACLICommand $pacli STOREPASSWORDOBJECT $($PSBoundParameters.getEnumerator() | ConvertTo-ParameterString)

		if($Return.ExitCode) {

			Write-Debug $Return.StdErr
			$FALSE

		}

		else {

			$TRUE

		}

	}

}