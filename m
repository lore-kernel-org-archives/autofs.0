From: "Daniel Schwager" <Daniel.Schwager@dtnet.de>
Subject: different behavior in static/executable autofs map
Date: Sat, 14 Feb 2009 23:17:49 +0100
Message-ID: <EB31672367A401439CD5A4A10889D57B01297357@exchange.dtnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org
Cc: Daniel Schwager <Daniel.Schwager@dtnet.de>

Hi,

the behavior of an executable and static map with the same
stdout differs - please refer to this sample

** content of "/etc/auto.master"
/home/t1      /root/a1
/home/t1a     /etc/auto.test1

** content of "/etc/auto.test1"
test1 \
         / :/tmp
	
** content of "/root/a1" (mode 755, executable)
#!/bin/sh
cat /etc/auto.test1


** Result

Accessing  /home/t1a/test1  works
	ls /home/t1a/test1  

Accessing  /home/t1/test1  does not work
	Feb 14 23:06:47 fs1 automount[17488]: failed to mount
/home/t1/test1

with debug output enabled:

Feb 14 23:12:53 fs1 automount[18460]: handle_packet: type = 0
Feb 14 23:12:53 fs1 automount[18460]: handle_packet_missing: token 1655,
name test1
Feb 14 23:12:53 fs1 automount[18460]: attempting to mount entry
/home/t1/test1
Feb 14 23:12:53 fs1 automount[18626]: lookup(program): looking up test1
Feb 14 23:12:53 fs1 automount[18626]: lookup(program): test1 -> test1
-fstype=bind  ^I/ :/tmp
Feb 14 23:12:53 fs1 automount[18626]: parse(sun): expanded entry: test1
-fstype=bind  ^I/ :/tmp
Feb 14 23:12:53 fs1 automount[18626]: parse(sun): gathered options:
Feb 14 23:12:53 fs1 automount[18626]: parse(sun): dequote("/") -> /
Feb 14 23:12:53 fs1 automount[18626]: parse(sun): dequote("test1") ->
test1
Feb 14 23:12:53 fs1 automount[18626]: parse(sun):
dequote("-fstype=bind") -> -fstype=bind
Feb 14 23:12:53 fs1 automount[18626]: parse(sun): dequote("/") -> /
Feb 14 23:12:53 fs1 automount[18626]: parse(sun): dequote("/tmp") ->
/tmp
Feb 14 23:12:53 fs1 automount[18626]: failed to mount /home/t1/test1
Feb 14 23:12:53 fs1 automount[18626]: umount_multi: path=/home/t1/test1
incl=1
Feb 14 23:12:53 fs1 automount[18626]: umount_multi: no mounts found
under /home/t1/test1
Feb 14 23:12:53 fs1 automount[18460]: handle_child: got pid 18626, sig 0
(0), stat 1
Feb 14 23:12:53 fs1 automount[18460]: sig_child: found pending iop pid
18626: signalled 0 (sig 0), exit status 1
Feb 14 23:12:53 fs1 automount[18460]: send_fail: token=1655
Feb 14 23:12:53 fs1 automount[18460]: handle_packet: type = 0
Feb 14 23:12:53 fs1 automount[18460]: handle_packet_missing: token 1656,
name test1
Feb 14 23:12:53 fs1 automount[18460]: attempting to mount entry
/home/t1/test1
Feb 14 23:12:53 fs1 automount[18629]: lookup(program): looking up test1
Feb 14 23:12:53 fs1 automount[18629]: lookup(program): test1 -> test1
-fstype=bind  ^I/ :/tmp
Feb 14 23:12:53 fs1 automount[18629]: parse(sun): expanded entry: test1
-fstype=bind  ^I/ :/tmp
Feb 14 23:12:53 fs1 automount[18629]: parse(sun): gathered options:
Feb 14 23:12:53 fs1 automount[18629]: parse(sun): dequote("/") -> /
Feb 14 23:12:53 fs1 automount[18629]: parse(sun): dequote("test1") ->
test1
Feb 14 23:12:53 fs1 automount[18629]: parse(sun):
dequote("-fstype=bind") -> -fstype=bind
Feb 14 23:12:53 fs1 automount[18629]: parse(sun): dequote("/") -> /
Feb 14 23:12:53 fs1 automount[18629]: parse(sun): dequote("/tmp") ->
/tmp
Feb 14 23:12:53 fs1 automount[18629]: failed to mount /home/t1/test1
Feb 14 23:12:53 fs1 automount[18629]: umount_multi: path=/home/t1/test1
incl=1
Feb 14 23:12:53 fs1 automount[18629]: umount_multi: no mounts found
under /home/t1/test1
Feb 14 23:12:53 fs1 automount[18460]: handle_child: got pid 18629, sig 0
(0), stat 1
Feb 14 23:12:53 fs1 automount[18460]: sig_child: found pending iop pid
18629: signalled 0 (sig 0), exit status 1
Feb 14 23:12:53 fs1 automount[18460]: send_fail: token=1656

I'm using debian etch with 
	autofs                          4.1.4-13

I would like to use a executable "map" - but I can't because of this
behavior.
Is there a change to fix this ?

regards
Danny
