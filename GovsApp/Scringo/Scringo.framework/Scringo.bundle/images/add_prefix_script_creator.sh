for x in `find . -name "*.png" `; do echo "mv $x `dirname $x`/ScrImg_`basename $x`"; done >> add_prefix.sh
