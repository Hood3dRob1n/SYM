NAME: sym.sh 
AUTHOR: H.R.
DESC: Bash Standalone Symlinker Script w/ability to use OS, PHP or Perl based symlink methods

USAGE: ./sym.sh <1|2|3>
   option 1 will use OS based method
   option 2 will use Perl based method
   option 3 will use PHP based method

EX for OS Method:   ./sym 1
EX for Perl Method: ./sym 2
EX for PHP Method:  ./sym 3

Works if your in shell but web shells may time out depending on size of server. I will work on speeding things up in the future but works as is for now and easily modded to find what you want :)
