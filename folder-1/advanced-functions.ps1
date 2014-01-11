# Test bitch

function Get-Stuff {
    [CmdletBinding()]
    param (
        [Parameter(Position=0,Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [Alias('host')]
        $computerName
    )
    BEGIN {}
    PROCESS {
        if ($PSBoundParameters.ContainsKey('computerName')) {
            # we got parameter input
            foreach ($name in $computerName) {
                StuffWorker $name
            }
        } else {
            # we got pipline input
            StuffWorker $_
        }     
    }
    END {}
}

function StuffWorker {
    param (
        $computerName
    )
    Get-WmiObject -Class win32_BIOS -computerName $computerName
}

# Usage:
# Get-Stuff server-r2
# Get-Stuff -computername server-r2
# Get-Stuff -computername (Get-Content names.txt)
# Get-Content names.txt | Get-Stuff
# Get-ADComputer -filter * |
#      Select @{l='ComputerName';e={$_.Name}} | Get-Stuff
