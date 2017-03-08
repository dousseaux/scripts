# Author: Pedro Dousseau
# Description: Encrypt and decrypts files using gpg command for AES256 encryption.
# Requires: 
#   - GNU gpg.   
#   - Remarkable markdown editor installed for decm and editm commands."
#   - gedit for edit command

if [[ $1 == "enc" ]]; then
  echo "Encrypting..."
  gpg --symmetric --cipher-algo AES256 --output $3 $2
  echo "Deleting..."  
  while true; do
    read -p "Do you want to delete the old file? (y/N) " yn
    case $yn in
        [Yy]* ) echo "Deleting..."; srm $2; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
  done
else if [[ $1 == "dec" ]]; then
  echo "Decrypting..."
  gpg --decrypt $2
else if [[ $1 == "decm" ]]; then
  temp_file=secureit_temp$RANDOM.md  
  echo "Decrypting..."
  gpg --decrypt --output $temp_file $2
  remarkable $temp_file
  echo "Deleting..."  
  srm $temp_file
else if [[ $1 == "decf" ]]; then
  echo "Decrypting to file..."
  gpg --decrypt --output $3 $2
else if [[ $1 == "edit" ]]; then
  temp_file=secureit_temp$RANDOM.md  
  echo "Decrypting..."
  gpg --decrypt --output $temp_file $2
  gedit -s $temp_file
  echo "Encrypting..."
  gpg --symmetric --cipher-algo AES256 --output $2 $temp_file
  echo "Deleting..."  
  while true; do
    read -p "Do you want to delete the old file? (y/N) " yn
    case $yn in
        [Yy]* ) echo "Deleting..."; srm $temp_file; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
  done
else if [[ $1 = "editm" ]]; then
  temp_file=secureit_temp$RANDOM.md  
  echo "Decrypting..."
  gpg --decrypt --output $temp_file $2
  remarkable $temp_file
  echo "Encrypting..."
  gpg --symmetric --cipher-algo AES256 --output $2 $temp_file
  while true; do
    read -p "Do you want to delete the old file? (y/N) " yn
    case $yn in
        [Yy]* ) echo "Deleting..."; srm $temp_file; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
  done
else
  echo "Parameters: <action> <input path> <output path>"
  echo "Where action can be:"
  echo "  enc: encrypt input to output file and delete input."  
  echo "  dec: print to terminal. No need of output."
  echo "  decm: print to temp .md file, open it on remarkable, then delete afterwords."
  echo "  decf: print to specified output file."
  echo "  edit: create and open tempfile on gedit. Encrypts it back and delete then tempfile."
  echo "  editm: like decm, but it encrypts the changes before deleting it."
fi
fi
fi
fi
fi
fi
