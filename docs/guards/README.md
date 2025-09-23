## PowerShell ParserError with -f and quotes
If you see `Unexpected token '{'` from `roadmap_guard.ps1`, the error is due to invalid quoting like `"` inside a formatted string. Fix by using:

- single quotes around `{0}` in the format string, e.g.:
  `throw ("Missing ... '{0}'" -f $requiredRef)`
- or PowerShell backtick to escape quotes: `` `" `` when needed.
