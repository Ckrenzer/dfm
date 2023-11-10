#!/usr/bin/awk -f

# ensure corresponding directories exist on disk for each dotfile in the repo.
#
# The -p flag to mkdir is a GNU corelib feature and is not POSIX-compliant.
# This workaround is (sort of) portable...

BEGIN{
    FS = ";"
    repo_file_field = 1
    system_file_field = 2
}

{
    # pass the input to the next command in a pipeline
    if(forward_input){
        print $0
    }

    system_file = $(system_file_field)
    split(system_file, components, /\//)
    current_dir = components[1]
    # < instead of <= to skip the file name
    for(i = 1; i < length(components); i++){
        if(i > 1){
            current_dir = sprintf("%s/%s", previous_dir, components[i])
        }
        if(!(current_dir in alldirs)){
            alldirs[current_dir]
            system(sprintf("test -d %s || mkdir %s", current_dir, current_dir))
        }
        previous_dir = current_dir
    }
}
