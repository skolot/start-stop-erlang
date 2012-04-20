#! /bin/sh
#
### BEGIN INIT INFO
# Provides:          EXAMPLE
# Required-Start:    $remote_fs $network
# Required-Stop:     $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts EXAMPLE server
# Description:       Erlang app
### END INIT INFO

set -e
APP=EXAMPLE
PREFIX=/path/
VER=

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME="EXAMPLE server"
DESC="EXAMPLE server"
USER=EXAMPLEUSER
APPHOME="${PREFIX}/${APP}"
HOSTNAME=$(hostname -s)
ERLOPT="-K true -A1024 -P 2097152"
SNAME="${APP}"
PATHA="${APPHOME}/ebin ${APPHOME}/deps/*/ebin"
APPCONF="${APPHOME}/${APP}"

export ERL_CRASH_DUMP="${APPHOME}/erl_crash.dump"

#set -x

do_start()
{
    ulimit -n 30000
    start-stop-erlang -H -n "${SNAME}@${HOSTNAME}" -A "${APP}" \
	    -P "${PATHA}" -u "${USER}" -C "${APPCONF}" \
        -o "${ERLOPT}" start
}

do_stop()
{ 
    start-stop-erlang -n "${SNAME}@${HOSTNAME}" -u "${USER}" \
	    -P "${PATHA}" -A "${APP}" -C "${APPCONF}" \
        -o "${ERLOPT}" stop
}

do_console() 
{
    ulimit -n 30000
    start-stop-erlang -n "${SNAME}@${HOSTNAME}" -A "${APP}" \
        -P "${PATHA}" -u "${USER}" -C "${APPCONF}" \
        -o "${ERLOPT}" console 
}

do_attach()
{
     start-stop-erlang -n "${SNAME}@${HOSTNAME}" -u "${USER}" \
         -P "${PATHA}" -A "${APP}" -C "${APPCONF}" \
         -o "${ERLOPT}" attach 
}

case "$1" in
    start)
	echo -n "Starting $DESC: "
	do_start
	echo "$NAME."
    ;;
    stop)
	echo -n "Stopping $DESC: "
	do_stop
	echo "$NAME."
    ;;
    restart)
	echo -n "Restarting $DESC: "
	do_stop
	sleep  3 
	do_start
	echo "$NAME."
    ;;
    console)
        echo -n "Starting console $DESC: "
        do_console
        echo "$NAME."
    ;;
    attach)
        echo -n "Attach $DESC: "
        do_attach
        echo "$NAME."
    ;;
    *)
	N=/etc/init.d/$NAME
	echo "Usage: $N {start|stop|restart|console|attach}" >&2
	exit 1
    ;;
esac

exit 0

