tigrc=`cat $HOME/.tigrc`
if [[ $tigro != *"set vertical-split = no"* ]]; then
  echo "set vertical-split = no" >> $HOME/.tigrc
fi
