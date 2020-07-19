#!/usr/bin/env sh

file=$1

check_versions() {
    git diff origin/master ${file} | grep version
}

version_changed=`check_versions | wc -l | tr -d '[:space:]'`

if [ $version_changed -gt 1 ]; then
    echo "Versions are different; verifying that the version increased"
    check_versions
    version_increased=`check_versions | awk -F\" '{
    split($4, old, ".");
    getline;
    split($4, new, ".");
    if(new[1] > old[1] \
        || (new[1] == old[1] && new[2] > old[2]) \
        || (new[1] == old[1] && new[2] == old[2] && new[3] > old[3])) {
        print 1
    } else {
        print 0
    }
    }'`
    if [ $version_increased -eq 1 ]; then
        echo "Version is properly increased!"
        exit 0
    else
        echo "Version is not properly increased; failing..."
        exit 1
    fi
else
    echo "Version has not been modified; failing..."
    exit 1
fi
