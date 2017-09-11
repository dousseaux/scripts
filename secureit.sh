# Author: Pedro Dousseau
# Description: Encrypt and decrypts files using gpg command for AES256 encryption.
# Requires:
#   - GNU gpg.
#   - atom -n -w markdown editor installed for decm and editm commands."

if [[ $1 == "enc" ]]; then
    echo "Encrypting..."
    gpg --symmetric --cipher-algo AES256 --output $3 $2
    echo "Deleting..."
    while true; do
        read -p "Do you want to delete the old file? (y/N) " yn
        case $yn in
            [Yy]* ) echo "Deleting..."; rm $2; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
else if [[ $1 == "dec" ]]; then
        echo "Decrypting..."
        gpg --decrypt $2
    else if [[ $1 == "deca" ]]; then
            temp_file=secureit_temp$RANDOM.md
            echo "Decrypting..."
            gpg --decrypt --output $temp_file $2
            atom -n -w $temp_file
            echo "Deleting..."
            rm $temp_file
        else if [[ $1 == "decf" ]]; then
                echo "Decrypting to file..."
                gpg --decrypt --output $3 $2
            else if [[ $1 == "edit" ]]; then
                    temp_file=secureit_temp$RANDOM.md
                    echo "Decrypting..."
                    gpg --decrypt --output $temp_file $2
                    atom -n -w $temp_file
                    echo "Encrypting..."
                    gpg --symmetric --cipher-algo AES256 --output $2 $temp_file
                    echo "Deleting..."
                    while true; do
                        read -p "Do you want to delete the old file? (y/N) " yn
                        case $yn in
                            [Yy]* ) echo "Deleting..."; rm $temp_file; break;;
                            [Nn]* ) break;;
                            * ) echo "Please answer yes or no.";;
                        esac
                    done
                else
                    echo "Parameters: <action> <input path> <output path>"
                    echo "Where action can be:"
                    echo "  enc: encrypt input to output file and delete input."
                    echo "  dec: print to terminal. No need of output."
                    echo "  deca: print to temp .md file, open it on atom -n -w, then delete afterwords."
                    echo "  decf: print to specified output file."
                    echo "  edit: create and open tempfile on atom. Encrypts it back and delete then tempfile."
                fi
            fi
        fi
    fi
fi
