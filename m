From: Hans Deragon <hans@deragon.biz>
Subject: Bug in parse_sun.c:parse_mount() single mount code.
Date: Thu, 22 Dec 2005 16:05:17 -0500
Message-ID: <43AB150D.5090309@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Greetings.


   In parse_sun.c, I notice that parse_mount() does not handle cases the
   same way if there are multi mount points or not.  Why is that?  Why
   isn't the single case treated as a single pass in the multi loop?

   I ask this because I have a problem to report.  But first, here is the
   output of /etc/auto.net when querying a host with multiple mount
   points and one with a single one.

[root@asterix root] /etc/auto.net server1
-fstype=nfs,hard,intr,nodev,nosuid \
         /export/archives server1:/export/archives \
         /export/devel server1:/export/devel \
         /export/users server1:/export/users

[root@asterix root] /etc/auto.net obelix
-fstype=nfs,hard,intr,nodev,nosuid \
         /pathxyz obelix:/pathxyz

   As you can see, there is not much diff between the two.  I am running:

   /usr/sbin/automount --debug --ghost --timeout 60 /net program 
/etc/auto.net

   The following happens in the single mount point case
   (/var/log/messages; I removed the leading headers on each line to
   protect the innocent):

: attempting to mount entry /net/obelix
: lookup(program): looking up obelix : lookup(program): obelix -> 
-fstype=nfs,hard,intr,nodev,nosuid,nonstrict    /pathxyz obelix:/pathxyz
: parse(sun): expanded entry: 
-fstype=nfs,hard,intr,nodev,nosuid,nonstrict   /pathxyz obelix:/pathxyz
: parse(sun): dequote("fstype=nfs,hard,intr,nodev,nosuid,nonstrict") -> 
fstype=nfs,hard,intr,nodev,nosuid,nonstrict
: parse(sun): gathered options: fstype=nfs,hard,intr,nodev,nosuid,nonstrict
: parse(sun): dequote("/pathxyz") -> /pathxyz : parse(sun): 
dequote("obelix:/pathxyz") -> obelix:/pathxyz
: parse(sun): core of entry: 
options=fstype=nfs,hard,intr,nodev,nosuid,nonstrict, loc=/pathxyz 
obelix:/pathxyz : parse(sun): mounting root >>/net<<, mountpoint 
 >>obelix<<, what >>/pathxyz obelix:/pathxyz<<, fstype >>nfs<<, options 
 >>hard,intr,nodev,nosuid<< : mount(nfs): root=/net name=obelix 
what=/pathxyz obelix:/pathxyz, fstype=nfs, options=hard,intr,nodev,nosuid
: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
: mount(nfs): host /pathxyz: lookup failure
: mount(nfs): winner = obelix local = 0
: mount(nfs): winner = obelix local = 0
: mount(nfs): from /pathxyz obelix:/pathxyz elected obelix:/pathxyz
: mount(nfs): calling mkdir_path /net/obelix
: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid 
obelix:/pathxyz /net/obelix
: >> nfs server reported tcp not available, falling back to udp
: mount(nfs): mounted obelix:/pathxyz on /net/obelix


   Notice that host "/pathxyz" lookup failed.  Obviously, since /pathxyz
   is a path, not a hostname.  The NFS share is being mounted, but as
   /net/obelix, instead of the expected /net/obelix/pathxyz .  There is a
   bug somewhere, but I have not put my finger on it.  But I come back to
   my initial question:  why is the single mount code different then the
   multi mount code?  Why not make the single case just a single loop
   execution of the multi mount code?  The multi code works fine, but not
   the single code.

   Any comments are welcomed.

   BTW, Ian Kent, I cannot write to you directly.  Somewhere my email is 
being blocked (hans@deragon.biz).  Can you check this out?


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.
http://www.deragon.biz        Open source (contribution):
mailto://hans@deragon.biz     http://autopoweroff.deragon.biz
