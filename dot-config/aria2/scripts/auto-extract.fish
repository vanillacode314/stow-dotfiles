#!/usr/bin/env fish

set DEBUG 0
set watch_dir "$HOME/Downloads/aria2"

function is_unpacking
    set unpacking (find $argv[1] -maxdepth 1 -type d -name "Unpack-*")
    if test (count $unpacking) -gt 0
        return 0
    end
    return 1
end

function handle_file
    set filepath $argv[1]
    set filename (basename $filepath)
    set dirname (dirname $filepath)
    set name_without_ext (string split -r -m 1 '.' $filename)[1]
    set aria2_file "$dirname/$filename.aria2"

    if not test -d "$dirname/$name_without_ext"
        if is_unpacking $dirname
            echo "Unpacking in progress for $filename. Waiting..."
            while is_unpacking $dirname
                sleep 1
            end
        end

        if test -f $aria2_file
            if test $DEBUG -eq 1
                echo "Download in progress for $filename. Skipping extraction."
            end
            return
        end

        echo "Running aunpack on $filepath"
        cd $dirname
        aunpack $filepath
    else
        if test $DEBUG -eq 1
            echo "Directory $name_without_ext already exists. Skipping $filepath."
        end
    end
end

while true
    for file in (find $watch_dir -type f -name "*.zip" -o -name "*.rar" -o -name "*.7z")
        handle_file $file
    end
    sleep 5
end
