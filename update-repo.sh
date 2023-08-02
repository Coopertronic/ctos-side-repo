#!/bin/bash

##  This script updates the ctos-side-repo.

clear
thArch="x86_64/"
lineBreak="<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"
echo $lineBreak
echo "Updateing the Repo"
echo $lineBreak
if !( cd "$thArch" ); then
    echo $lineBreak
    echo "Unable to find the $thArch folder."
    echo "Please check that you are in the correct project."
    echo $lineBreak
    exit 1
else
    cd $thArch
    echo "$PWD"
    if !(rm ctos-side-repo.*); then
        echo $lineBreak
        echo "The repo DB files do not exist."
        echo "Building the DB."
        echo $lineBreak
    else
        echo $lineBreak
        echo "Old DB files have been deleted."
        echo "I will now rebuild the DB."
        echo $lineBreak
    fi
    if !( repo-add ctos-side-repo.db.tar.gz *.pkg.tar.zst ); then
        echo $lineBreak
        echo "Something went wrong."
        echo "See the above messages for errors."
        echo $lineBreak
        exit 1
    else
        echo $lineBreak
        echo "All done."
        echo "Now pushing the repo to GitHub."
        echo $lineBreak
        cd ..
        if !( update-git ); then
            echo $lineBreak
            echo "Something went wrong."
            echo "See the above messages for errors."
            echo $lineBreak
            exit 1
        else
            echo $lineBreak
            echo "All done."
            echo "The repo has successfully been pushed to GitHub."
            echo $lineBreak
        fi
    fi
fi
exit 0
