$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Test-Cycle {
  param(
    [Parameter(Mandatory=$true)] [System.Collections.Hashtable] $Edges  # parent -> [children]
  )
  # DFS with colors: 0=unvisited,1=visiting,2=done
  $color = @{}
  foreach ($k in $Edges.Keys) { $color[$k] = 0 }
  foreach ($k in $Edges.Keys) {
    if (Invoke-DFS -Node $k -Edges $Edges -Color $color) { return $true }
  }
  return $false
}

function Invoke-DFS {
  param(
    [string] $Node,
    [System.Collections.Hashtable] $Edges,
    [System.Collections.Hashtable] $Color
  )
  if ($Color[$Node] -eq 1) { return $true }    # back edge => cycle
  if ($Color[$Node] -eq 2) { return $false }   # already done
  $Color[$Node] = 1
  $children = @()
  if ($Edges.ContainsKey($Node)) { $children = $Edges[$Node] }
  foreach ($c in $children) {
    if ($Color.ContainsKey($c) -eq $false) { $Color[$c] = 0 }
    if (Invoke-DFS -Node $c -Edges $Edges -Color $Color) { return $true }
  }
  $Color[$Node] = 2
  return $false
}

# Sample OK: manager with N subordinates, no cycles
$edgesOK = @{
  "A" = @("B","C","D")
  "C" = @("E")
}
$hasCycleOK = Test-Cycle -Edges $edgesOK
if ($hasCycleOK) {
  Write-Host "[KO] expected acyclic graph for OK sample" ; exit 1
}
# Verify N subordinates is allowed (here N=3)
if ($edgesOK["A"].Count -lt 3) {
  Write-Host "[KO] expected A to manage N>=3 people" ; exit 1
}
Write-Host "[OK] manager with N subordinates allowed; no cycles detected"

# Sample KO: simple cycle A->B->A
$edgesKO = @{
  "A" = @("B")
  "B" = @("A")
}
$hasCycleKO = Test-Cycle -Edges $edgesKO
if (-not $hasCycleKO) {
  Write-Host "[KO] expected cycle detection on A->B->A" ; exit 1
}
Write-Host "[OK] cycle detected on A->B->A (as required)"
Write-Host "spec org hierarchy tests: PASS"
exit 0
