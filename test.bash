#!/bin/bash

canonicalise () {
    filename="${1}"
    # prefix replacement
    case "${1}" in
	/*)
	    # absolute, nothing to do.
	    ;;
	~*)
	    # home-relative and for some odd reason calling shell
	    # didnt expand this already (for ex. it was quoted).
	    filename="${HOME}/${filename}"
	    ;;
	*)
	    # relative path.
	    filename="$(pwd)/${filename}"
	    ;;
    esac
    # strip './' elements
    filename=$(echo "${filename}" | sed -e 's:/\./:/:g')
    # strip 'foo/../' elements
    filename=$(echo "${filename}" | sed -e 's:/[^/]\+/\.\./:/:g')
    # protect real backslashes
    filename=$(echo "${filename}" | sed -e 's/\\/\\\\/g')
    file="${filename}"
    unset filename
}

get_filenames() {
    local file
    local -a files
    while (( ${#} )); do
	canonicalise "${1}"
	echo "${file}"
	if [[ -d "${file}" ]]; then
	    files=( "${files[*]}" "$(find ${file} \! -type d)" )
	else
	    files=( "${files[*]}" "${file}" )
	fi
	shift
    done
    echo "${files[*]}"
}

get_filenames "${@}"
