param([Parameter(Mandatory=$false)] [string]$Item)

Clear-Host; Write-Host `n

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > $null

function YesNoQuestion
{
  param([Parameter(Mandatory=$true)] [string]$Message)
  $icon = [System.Windows.Forms.MessageBoxIcon]::Question
  $buttons = [System.Windows.Forms.MessageBoxButtons]::YesNo
  $MessageBox = [System.Windows.Forms.MessageBox]::Show($Message, $icon, $buttons)
  if ($MessageBox -eq "Yes"){ return $true }
  elseif ($MessageBox -eq "No"){ return $false }
}

function Error
{
  param([Parameter(Mandatory=$true)] [string]$Message)
  $icon = [System.Windows.Forms.MessageBoxIcon]::Warning
  $MessageBox = [System.Windows.Forms.MessageBox]::Show($Message, $icon)
}

function Execute
{
  param([Parameter(Mandatory=$true)] [string]$Program,
        [Parameter(Mandatory=$true)] [System.Array]$Parameters)

  try{ & "$Program" $Parameters 2> $null }
  catch [System.Exception] { Error -Message "Error executing $Program." }
}

function Erasure
{
  param([Parameter(Mandatory=$true)] [System.Object]$Item)

  $SDelete = "C:\SCRIPTS\SDelete\sdelete64.exe" # DEFAULT PATH

  if ( (Get-Item -Path $Item) -is [System.IO.DirectoryInfo] )
  {
    if (YesNoQuestion -Message "Are you sure do you want to delete the directory and its content?")
    {
      Execute -Program "$SDelete" -Parameters ( ("-p 35 -r -s $Item") -split " ") # DEFAULT ERASURE PASSES = 35
    }
  }
  elseif ( (Get-Item -Path $Item) -is [System.IO.FileInfo] )
  {
    if (YesNoQuestion -Message "Are you sure do you want to delete the file?")
    {
      Execute -Program "$SDelete" -Parameters ( ("-p 35 -r $Item") -split " ") # DEFAULT ERASURE PASSES = 35
    }
  }
}

if (Test-Path -Path $Item)
{
  Erasure -Item $Item
}
else
{
  Error -Message "Element $Item not found."
}

Write-Host `n
Pause