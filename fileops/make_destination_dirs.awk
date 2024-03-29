#!/usr/bin/awk -f

# Takes file names with one file path per line
# as input and creates the corresponding directories.
#
# You could set RS="\0" on the command line and pipe the results of
#   find dirname/ -type f -print0
# into this script (replacing the placeholder, 'dirname', with an actual directory).
#
#
# The -p flag to mkdir is a GNU corelib feature and is not POSIX-compliant.
# This workaround is (sort of) portable...Never going to matter but I thought
# reinventing the wheel would be an amusing exercise. Certainly not the most
# performant solution.

BEGIN{
    FS = "/"
}

{
    previous_dir = ""
    for(i = 1; i < NF; ++i){# < instead of <= to exclude the element with the file name
        current_dir = previous_dir $i
        if(!(current_dir in alldirs)){
            alldirs[current_dir]
            cmd_mkdir = sprintf("test -d %s || mkdir %s", current_dir, current_dir)
            if(print_only){# useful for testing
                print cmd_mkdir
            } else {
                system(cmd_mkdir)
                close(cmd_mkdir)
            }
        }
        previous_dir = current_dir "/"
    }
}
