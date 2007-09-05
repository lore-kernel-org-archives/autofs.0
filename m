From: Anthony Menasse <anthony.menasse@rsp.com.au>
Subject: automount and  nfs mount retry option
Date: Wed, 05 Sep 2007 12:33:01 +1000
Message-ID: <46DE155D.9090601@rsp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040404090507080605020707"
Return-path: <autofs-bounces@linux.kernel.org>
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

This is a multi-part message in MIME format.
--------------040404090507080605020707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

We had some issues the other day with an NFS server under high load and
clients which were attempting to automount the NFS shares timing out on
the mount attempts. This surprised me as we use the nfs mount option
"retry=2" in our auto.master file, which I assumed mean't clients would
keep retrying the mount attempt for 120 seconds.

I decided to setup a simple test to understand what was going on which I
have described below.

My questions are:

* Should I expect the retry option to work as described in the nfs man
page with automount?

* Am I misunderstanding something about how automount  works with with
the retry option?

* Is my test method ok?

I have attached the automount debug output from one of my test runs. Any
feedback is much appreciated.

Thanks
Anthony

Test setup:
=========

* Server is a xen instance  running CentOS 5. Kernel  2.6.18-8.el5xen

* 2 clients running Fedora 3 with latest autofs5 package from fc6
recompiled for our system ( autofs-5.0.1-0.rc3.33 ) behavior also seems
to occur with  Fedora 5 latest package (autofs-4.1.4-33 ) machines using
vanilla kernel 2.6.20.4

* Client 1 is accessing the NFS share via a static mount

* Client 2 is accessing the NFS share via automount with the following configuration:

auto.master:

/film /etc/mounts/auto.film retry=1000,nfsvers=3,fg

auto.film:

testmount
-ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
10.2.0.235:/export

Steps:
========
1) on the server set nfs daemon count to 1 exported an nfs share and
restarted nfs daemon.

2) thrashed nfs share  from client 1 using dd and cat.

3) on client 2 attempt to access automounted mount point (which is
currently not mounted) on server using cd or ls.


Expected Results:
=================
The mount attempt  on client 2 should not time out for 1000 minutes

Actual Result:
==============
The mount attempt times out rather quickly (i forgot to measure the time
I'm guessing it was about 60 seconds)

The debug output shows the retry value is definitely getting passed to
the mount command called by the automount daemon.

Additional Tests using static mounts give the expected behavior  for
retry. These were actually done by pausing the server instead of
applying load to the server . (This was the original test method
employed in the above test until I decided it might be better to thrash
the server instead)

1) The following times out after 60 seconds:

mount 10.2.0.235:/export /mnt/tmp/ -o retry=0,bg,nfsvers=3

2) The following doesn't time out for 1000 minutes (well i left it for a
few minutes and it hadn't timed out):

mount 10.2.0.235:/export /mnt/tmp/ -o retry=1000,bg,nfsvers=3


Current conclusion:
===============
setting the nfs mount option retry in automount map files does not work
as I would expect.

-- 
anthony menasse
systems administrator | anthony.menasse@rsp.com.au
rising sun pictures | www.rsp.com.au
direct line +61 2 9384 4572



--------------040404090507080605020707
Content-Type: text/plain;
 name="debugautomount.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debugautomount.txt"

Sep  5 09:52:43 kalel logger: START TEST 3
Sep  5 09:53:02 kalel automount[5436]: st_expire: state 1 path /film
Sep  5 09:53:02 kalel automount[5436]: expire_proc: exp_proc = 3083578288 path
/film
Sep  5 09:53:02 kalel automount[5436]: mount still busy /film
Sep  5 09:53:02 kalel automount[5436]: expire_cleanup: got thid 3083578288
path /film stat 0
Sep  5 09:53:02 kalel automount[5436]: expire_cleanup: sigchld: exp 3083578288
finished, switching from 2 to 1
Sep  5 09:53:02 kalel automount[5436]: st_ready: st_ready(): state = 2 path
/film
Sep  5 09:53:03 kalel automount[5436]: handle_packet: type = 3
Sep  5 09:53:03 kalel automount[5436]: handle_packet_missing_indirect: token
20, name testmount, request pid 7422
Sep  5 09:53:03 kalel automount[5436]: attempting to mount entry
/film/testmount
Sep  5 09:53:03 kalel automount[5436]: lookup_mount: lookup(file): looking up
testmount
Sep  5 09:53:03 kalel automount[5436]: lookup_mount: lookup(file): testmount
-> -ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
10.2.0.235:/export
Sep  5 09:53:03 kalel automount[5436]: parse_mount: parse(sun): expanded
entry: -ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
10.2.0.235:/export
Sep  5 09:53:03 kalel automount[5436]: parse_mount: parse(sun): gathered
options:
retry=1000,nfsvers=3,fg,ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
Sep  5 09:53:03 kalel automount[5436]: parse_mount: parse(sun):
dequote("10.2.0.235:/export") -> 10.2.0.235:/export
Sep  5 09:53:03 kalel automount[5436]: parse_mount: parse(sun): core of entry:
options=retry=1000,nfsvers=3,fg,ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768,
loc=10.2.0.235:/export
Sep  5 09:53:03 kalel automount[5436]: sun_mount: parse(sun): mounting root
/film, mountpoint testmount, what 10.2.0.235:/export, fstype nfs, options
retry=1000,nfsvers=3,fg,ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
Sep  5 09:53:03 kalel automount[5436]: mount_mount: mount(nfs): root=/film
name=testmount what=10.2.0.235:/export, fstype=nfs,
options=retry=1000,nfsvers=3,fg,ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
Sep  5 09:53:03 kalel automount[5436]: mount_mount: mount(nfs): nfs
options="retry=1000,nfsvers=3,fg,ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768",
nosymlink=0, ro=1
Sep  5 09:53:04 kalel automount[5436]: mount_mount: mount(nfs): calling
mkdir_path /film/testmount
Sep  5 09:53:04 kalel automount[5436]: mount_mount: mount(nfs): calling mount
-t nfs -s -o
retry=1000,nfsvers=3,fg,ro,noatime,hard,intr,nfsvers=3,tcp,port=2049,rsize=32768,wsize=32768
10.2.0.235:/export /film/testmount
Sep  5 09:53:24 kalel automount[5436]: >> mount: RPC: Timed out
Sep  5 09:53:24 kalel automount[5436]: mount(nfs): nfs: mount failure
10.2.0.235:/export on /film/testmount
Sep  5 09:53:24 kalel automount[5436]: send_fail: token = 20
Sep  5 09:53:24 kalel automount[5436]: failed to mount /film/testmount


--------------040404090507080605020707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------040404090507080605020707--

