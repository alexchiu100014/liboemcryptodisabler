
ui_print "*******************************"
ui_print "   liboemcrypto.so disabler    "
ui_print "*******************************"


# warn if superfluous
bl=$(getprop ro.boot.bootloader)
device=${bl:0:$((${#bl} - 8))}
if ( [ $device = G975F ] || [ $device = G973F ] || [ $device = G970F ] )
then
	ui_print "- Warning: This module is not needed on the $device."
	ui_print ''
fi


for part in system vendor
do
	for libdir in lib lib64
	do
		if [ -s /$part/$libdir/liboemcrypto.so ]
		then
			size=$(ls -l /$part/$libdir/liboemcrypto.so | awk '{print $5}')
			ui_print "- Found /$part/$libdir/liboemcrypto.so, which is $size bytes."
			ui_print "-   Neutralising..."
			if [ $part = vendor ]
			then
				instdir=system/vendor
			else
				instdir=system
			fi
			mkdir -p $MODPATH/$instdir/$libdir
			touch $MODPATH/$instdir/$libdir/liboemcrypto.so
		fi
	done
done

