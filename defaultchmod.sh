if [ "$#" -ne 1 ]; then
    echo "Please specify directory"
else
    find $1 -type d -exec chmod 755 {} \;
    find $1 -type f -exec chmod 644 {} \;
fi
