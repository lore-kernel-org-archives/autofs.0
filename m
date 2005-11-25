From: Hans Deragon <hans@deragon.biz>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Fri, 25 Nov 2005 16:17:35 -0500
Message-ID: <43877F6F.5000708@deragon.biz>
References: <4378ED9A.6090903@deragon.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_kK6IpAUZS63xXBCQX9WoPQ)"
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4378ED9A.6090903@deragon.biz>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_kK6IpAUZS63xXBCQX9WoPQ)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Greetings.


   Well, I successfully reproduced the problem of a path sent to 
auto.net (see below for full description).  Attached, the debug output 
on syslogd.  From what I understand of the syslogd logs, the problem 
occurs before sun_mount() is called.

   What I did was:

   cd /net/asterix  # Everything is ok.  $key=asterix
   cd asteris-07    # Bug:  $key=asterix/asterix-07

   What was passed to auto.net was asterix/asterix-07 at the second 'cd'.

   And there is some confusion.  The directory structure should be:

# pwd
/net/asterix
# ls -l
drwxr-xr-x  4 root root 8192 Jun  1 16:23 asterix-00
drwxr-xr-x  5 root root 8192 Sep 20 09:06 asterix-01
drwxr-xr-x  4 root root 8192 Jun 29  2004 asterix-02
drwxr-xr-x  5 root root 8192 Feb 13  2004 asterix-03
drwxr-xr-x  4 root root 8192 Oct 17 07:18 asterix-04
drwxr-xr-x  4 root root   96 Sep 22 13:29 asterix-05
drwxr-xr-x  4 root root   96 Nov  3  2004 asterix-06
drwxr-xr-x  4 root root   96 Nov  3  2004 asterix-07

However, I notice the following:

# pwd
/net/asterix/asterix-07
# ls -l
drwxr-xr-x  4 root root 8192 Jun  1 16:23 asterix-00
drwxr-xr-x  5 root root 8192 Sep 20 09:06 asterix-01
drwxr-xr-x  4 root root 8192 Jun 29  2004 asterix-02
drwxr-xr-x  5 root root 8192 Feb 13  2004 asterix-03
drwxr-xr-x  4 root root 8192 Oct 17 07:18 asterix-04
drwxr-xr-x  4 root root   96 Sep 22 13:29 asterix-05
drwxr-xr-x  4 root root   96 Nov  3  2004 asterix-06

   This is not right.  The content of /net/asterix/asterix-07 is not 
supposed to be the same as /net/asterix.  Something recursive is going on.

I went so far as:

# cd asterix-07
# pwd
/net/asterix/asterix-07/asterix-07
# cd asterix-07
# pwd
/net/asterix/asterix-07/asterix-07/asterix-07
# cd asterix-07
# pwd
/net/asterix/asterix-07/asterix-07/asterix-07/asterix-07

   You see?  Automount fall in a recursive condition.

   Autofs 4.1.4 was used.  What was running was:

/usr/sbin/automount --debug --ghost --timeout 60 /net program /etc/auto.net

   Let me know if you find something strange in the output.  What I do 
not understand, is the asterix-06 mountpoint.


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.
http://www.deragon.biz        Open source (contribution):
mailto://hans@deragon.biz     http://autopoweroff.deragon.biz


Hans Deragon wrote:
> Greetings.
> 
> 
>   I compiled autofs 4.1.4 for SuSE Linux Enterprise Server 9 (SLES9). I 
> did found a little problem with auto.net.  The original code has:
> 
>   key=$1
> 
>   However, under SLES9, in my network environment, $key can be of the 
> form "server/something[/otherthing]*", which is wrong.  $key should only 
> be a server name.  I fixed the problem with:
> 
>   key=`echo $1 | perl -wp -e 's%^(\w+)(\/?.+)*$%$1%;'`
> 
>   My fix removes any path after the server name.
> 
>   Exactly why automount passes a server name containg some path is 
> unclear for me.  But I wanted to report this here.  If other suffer from 
> this, you might want to consider some fix like mine (maybe using sed 
> which is more standard).
> 
>   I have not experienced this under Fedora Core 4 (FC4).
> 
> 
> Best regards,
> Hans Deragon


--Boundary_(ID_kK6IpAUZS63xXBCQX9WoPQ)
Content-type: text/x-log; CHARSET=US-ASCII; name=autofs.pathprob.log
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=autofs.pathprob.log

Nov 25 15:44:28 mysystem automount[31394]: handle_packet: type = 0 
Nov 25 15:44:28 mysystem automount[31394]: handle_packet_missing: token 116, name asterix/asterix-07 
Nov 25 15:44:28 mysystem automount[31394]: attempting to mount entry /net/asterix/asterix-07
Nov 25 15:44:28 mysystem automount[31431]: lookup(program): looking up asterix/asterix-07
Nov 25 15:44:28 mysystem automount[31431]: lookup(program): asterix/asterix-07 -> -fstype=nfs,hard,intr,nodev,nosuid  	/asterix-00 asterix:/asterix-00  	/asterix-01 asterix:/asterix-01  	/asterix-02 asterix:/asterix-02  	/asterix-03 asterix:/asterix-03  	/asterix-04 asterix:/asterix-04  	/asterix-05 asterix:/asterix-05  	/asterix-06 asterix:/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): expanded entry: -fstype=nfs,hard,intr,nodev,nosuid  	/asterix-00 asterix:/asterix-00  	/asterix-01 asterix:/asterix-01  	/asterix-02 asterix:/asterix-02  	/asterix-03 asterix:/asterix-03  	/asterix-04 asterix:/asterix-04  	/asterix-05 asterix:/asterix-05  	/asterix-06 asterix:/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("fstype=nfs,hard,intr,nodev,nosuid") -> fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): gathered options: fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-00") -> /asterix-00
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-00") -> asterix:/asterix-00
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-01") -> /asterix-01
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-01") -> asterix:/asterix-01
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-02") -> /asterix-02
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-02") -> asterix:/asterix-02
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-03") -> /asterix-03
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-03") -> asterix:/asterix-03
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-04") -> /asterix-04
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-04") -> asterix:/asterix-04
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-05") -> /asterix-05
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-05") -> asterix:/asterix-05
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("/asterix-06") -> /asterix-06
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): dequote("asterix:/asterix-06") -> asterix:/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-06 on /asterix-06 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-06, what asterix:/asterix-06, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-06 what=asterix:/asterix-06, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-06 elected asterix:/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-06 /net/asterix/asterix-07/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-06 on /net/asterix/asterix-07/asterix-06
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-05 on /asterix-05 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-05, what asterix:/asterix-05, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-05 what=asterix:/asterix-05, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-05 elected asterix:/asterix-05
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-05
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-05 /net/asterix/asterix-07/asterix-05
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-05 on /net/asterix/asterix-07/asterix-05
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-04 on /asterix-04 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-04, what asterix:/asterix-04, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-04 what=asterix:/asterix-04, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-04 elected asterix:/asterix-04
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-04
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-04 /net/asterix/asterix-07/asterix-04
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-04 on /net/asterix/asterix-07/asterix-04
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-03 on /asterix-03 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-03, what asterix:/asterix-03, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-03 what=asterix:/asterix-03, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-03 elected asterix:/asterix-03
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-03
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-03 /net/asterix/asterix-07/asterix-03
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-03 on /net/asterix/asterix-07/asterix-03
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-02 on /asterix-02 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-02, what asterix:/asterix-02, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-02 what=asterix:/asterix-02, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-02 elected asterix:/asterix-02
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-02
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-02 /net/asterix/asterix-07/asterix-02
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-02 on /net/asterix/asterix-07/asterix-02
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-01 on /asterix-01 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-01, what asterix:/asterix-01, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-01 what=asterix:/asterix-01, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-01 elected asterix:/asterix-01
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-01
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-01 /net/asterix/asterix-07/asterix-01
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-01 on /net/asterix/asterix-07/asterix-01
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): multimount: asterix:/asterix-00 on /asterix-00 with options fstype=nfs,hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: parse(sun): mounting root /net/asterix/asterix-07, mountpoint asterix-00, what asterix:/asterix-00, fstype nfs, options hard,intr,nodev,nosuid 
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): root=/net/asterix/asterix-07 name=asterix-00 what=asterix:/asterix-00, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): winner = asterix local = 0
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): from asterix:/asterix-00 elected asterix:/asterix-00
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mkdir_path /net/asterix/asterix-07/asterix-00
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid asterix:/asterix-00 /net/asterix/asterix-07/asterix-00
Nov 25 15:44:28 mysystem automount[31431]: mount(nfs): mounted asterix:/asterix-00 on /net/asterix/asterix-07/asterix-00
Nov 25 15:44:28 mysystem automount[31394]: handle_child: got pid 31431, sig 0 (0), stat 0 
Nov 25 15:44:28 mysystem automount[31394]: sig_child: found pending iop pid 31431: signalled 0 (sig 0), exit status 0
Nov 25 15:44:28 mysystem automount[31394]: send_ready: token=116 

--Boundary_(ID_kK6IpAUZS63xXBCQX9WoPQ)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary_(ID_kK6IpAUZS63xXBCQX9WoPQ)--

