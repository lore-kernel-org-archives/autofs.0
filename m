From: hariharan veerappan <hariharanneevee@gmail.com>
Subject: automount daemon not running
Date: Tue, 2 Aug 2005 10:20:01 +0530
Message-ID: <f16b04cf050801215045e5a24@mail.gmail.com>
Reply-To: hariharan veerappan <hariharanneevee@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello all,

We are try to run the automount daemon.

We are using the below script file 
We are using the autofs version 4 support


#/etc/rc.d/init.d/auto_mount..

case "$1" in
	start)

	for mountspec in $(/bin/ls /etc/sysconfig/automount-config/*.auto)
	do
		MOUNTPOINT=/mount
		TIMEOUT=0

		MOUNT_BASE=${mountspec%.auto}

		echo "Starting automount for group ${MOUNT_BASE##*/}  ..."
		automount --timeout=${TIMEOUT} $MOUNTPOINT file \
		$MOUNT_BASE.map
		evaluate_retval
	done
	;;
	
	# assume all instances of automount were started by this script
	stop)
		echo -n "Stopping automount ..."
		# Unmount everything mounted by automount
		killall -USR1 automount
		killall automount
		evaluate_retval
		#exit 1
		;;
	restart)
		$0 stop
		sleep 1
		$0 start
		;;
	*)
		echo "Usage: $0 {start|stop|restart}"
		exit 1
		;;
esac
# End /etc/rc.d/init.d/auto_mount
#EOF

The daemon does not run in the background
please confirm and verify..
 
Thanks and regards
Hariharan.V.
