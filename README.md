pathed
======

Easy Windows **%PATH%** editor


Basic Usage:

```powershell
# Prepend a path; adds current path if <path> is omitted
pathed prepend <path>

# Append a path; adds current path if <path> is omitted
pathed append <path>

# Remove a path
pathed remove <path>

# Check presence of a directory in PATH
pathed check <path>

# Remove invalid directories (if present)
pathed clean

# Print directories in the current value of $PATH
pathed print
```

-------------------------------------------------------------------------

By default, **%PATH%** of machine is edited.

For more control, use the additional parameter $env (machine/user/process)
