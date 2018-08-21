If([Environment]::OSVersion.Version.Major -ne 10) {
	Clear-Host
	Write-Host 'Sorry, this Script supports Windows 10 ONLY.' -ForegroundColor 'cyan' -BackgroundColor 'black'
	If($Automated -ne 1){ Read-Host -Prompt "`nPress Any key to Close..." } ;Exit
}

If(!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $args" -Verb RunAs ;Exit
}

$ProcessList = @()
$Filename = ''

For($i=0 ;$i -lt $args.Length ;$i++) {
	If($args[$i].StartsWith('-')) {
		$tmpS = $args[$i]
		If($tmpS -eq '-f'){ $Script:Filename = $args[$i+1] }
		ElseIf($tmpS -eq '-stop'){ $Script:StarStop = 'stop' }
		ElseIf($tmpS -eq '-start'){ $Script:StarStop = 'start' }
	}
}

If(Test-Path -LiteralPath $Filename -PathType Leaf) {
	$ProcessList = Get-Content $Filename
} Else {
	write-host $Filename
	write-host 'Not found'
	Read-Host -Prompt "`nPress any key to exit"
	exit
}

If($StarStop -eq 'stop') {
	ForEach($Proc In $ProcessList) {
		write-host "Stopping $Proc"
		Stop-Process $Proc
	}
} ElseIf($StarStop -eq 'start') {
	ForEach($Proc In $ProcessList) {
		write-host "Straring $Proc"
		Start-Process -FilePath $Proc
	}
} Else {
	write-host "Start or Stop has not been Specified"
}
