start-stop-erlang
=================

analogue of the start-stop-daemon for erlang

usage
=================


required options
$last == action {start|stop|attach|console}
 -n node name
 -A application name, use to start app
 -P erlang path options (-pa opt)
 -u sytem username

optional argumets

 -C application config file
 -c cookie
 -N flag to use name instead of sname
 -o addtional erl option
 -s extra start app
 -l log base dir, default /var/log/$appname#
 -H falg to use erlang heart

