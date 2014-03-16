pathed
======

Easy Windows %PATH% editor


Basic Usage:

#Add a path; adds current path if value is omitted
pathed add <path>

#Remove a path
pathed remove <path>

#Check presence of a directory in PATH
pathed check <path>

#Remove invalid directories (if present)
pathed clean

#Print directories in the current value of $PATH 
pathed print


-------------------------------------------------------------------------

By default, $PATH of machine is edited.
For more control, use the additional parameter $env.
Possible targets: machine/user/process
