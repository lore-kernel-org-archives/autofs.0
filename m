From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Tue, 19 Apr 2005 22:32:14 -0300
Message-ID: <20050420013214.GA9960@vision.ime.usp.br>
References: <20050417154240.GA17232@uio.no>
	<Pine.LNX.4.62.0504200059370.8587@donald.themaw.net>
	<20050419210653.GA15270@vision.ime.usp.br>
	<Pine.LNX.4.58.0504200859160.7460@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504200859160.7460@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, 304245@bugs.debian.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2005 at 09:02:22AM +0800, Ian Kent wrote:
> 
> Fine, but what I'm after is what happpens when the ping fails for all 
> servers. Changing the host names to bogus names should be enough.

Changed /etc/auto.testing to

foo     -ro,hard,intr \
        /dir/bar        bogus:/usr/local/bin \
        /dir/baz        morebogus:/usr/local/sbin

cd /testing/foo resulted in the part of the log that follows attached.

Daniel

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="autofs.log"

Apr 19 22:16:52 myhost automount[4357]: handle_packet: type = 0 
Apr 19 22:16:52 myhost automount[4357]: handle_packet_missing: token 299, name foo 
Apr 19 22:16:52 myhost automount[4357]: attempting to mount entry /testing/foo
Apr 19 22:16:52 myhost automount[9850]: lookup(file): foo -> -ro,hard,intr         /dir/bar        bogus:/usr/local/bin         /dir/baz        morebogus:/usr/local/sbin
Apr 19 22:16:52 myhost automount[9850]: parse(sun): expanded entry: -ro,hard,intr         /dir/bar        bogus:/usr/local/bin         /dir/baz        morebogus:/usr/local/sbin
Apr 19 22:16:52 myhost automount[9850]: parse(sun): dequote("ro,hard,intr") -> ro,hard,intr
Apr 19 22:16:52 myhost automount[9850]: parse(sun): gathered options: ro,hard,intr
Apr 19 22:16:52 myhost automount[9850]: parse(sun): dequote("/dir/bar") -> /dir/bar
Apr 19 22:16:52 myhost automount[9850]: parse(sun): dequote("bogus:/usr/local/bin") -> bogus:/usr/local/bin
Apr 19 22:16:52 myhost automount[9850]: parse(sun): dequote("/dir/baz") -> /dir/baz
Apr 19 22:16:52 myhost automount[9850]: parse(sun): dequote("morebogus:/usr/local/sbin") -> morebogus:/usr/local/sbin
Apr 19 22:16:52 myhost automount[9850]: parse(sun): multimount: morebogus:/usr/local/sbin on /dir/baz with options ro,hard,intr
Apr 19 22:16:52 myhost automount[9850]: parse(sun): mounting root /testing/foo, mountpoint dir/baz, what morebogus:/usr/local/sbin, fstype nfs, options ro,hard,intr 
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): root=/testing/foo name=dir/baz what=morebogus:/usr/local/sbin, fstype=nfs, options=ro,hard,intr
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): nfs options="ro,hard,intr", nosymlink=0, ro=1
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): host morebogus: lookup failure
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): winner = (null) local = 0
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): all hosts timed out for 'morebogus:/usr/local/sbin', retrying with longer timeout
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): winner = (null) local = 0
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): from morebogus:/usr/local/sbin elected morebogus:/usr/local/sbin
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): calling mkdir_path /testing/foo/dir/baz
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): calling mount -t nfs -s  -o ro,hard,intr morebogus:/usr/local/sbin /testing/foo/dir/baz
Apr 19 22:16:52 myhost automount[9850]: >> mount: can't get address for morebogus
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): nfs: mount failure morebogus:/usr/local/sbin on /testing/foo/dir/baz
Apr 19 22:16:52 myhost automount[9850]: parse_mount: ignoring failure of non-strict mount
Apr 19 22:16:52 myhost automount[9850]: parse(sun): multimount: bogus:/usr/local/bin on /dir/bar with options ro,hard,intr
Apr 19 22:16:52 myhost automount[9850]: parse(sun): mounting root /testing/foo, mountpoint dir/bar, what bogus:/usr/local/bin, fstype nfs, options ro,hard,intr 
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): root=/testing/foo name=dir/bar what=bogus:/usr/local/bin, fstype=nfs, options=ro,hard,intr
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): nfs options="ro,hard,intr", nosymlink=0, ro=1
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): host bogus: lookup failure
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): winner = (null) local = 0
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): all hosts timed out for 'bogus:/usr/local/bin', retrying with longer timeout
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): winner = (null) local = 0
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): from bogus:/usr/local/bin elected bogus:/usr/local/bin
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): calling mkdir_path /testing/foo/dir/bar
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): calling mount -t nfs -s  -o ro,hard,intr bogus:/usr/local/bin /testing/foo/dir/bar
Apr 19 22:16:52 myhost automount[9850]: >> mount: can't get address for bogus
Apr 19 22:16:52 myhost automount[9850]: mount(nfs): nfs: mount failure bogus:/usr/local/bin on /testing/foo/dir/bar
Apr 19 22:16:52 myhost automount[9850]: parse_mount: ignoring failure of non-strict mount
Apr 19 22:16:52 myhost automount[4357]: handle_child: got pid 9850, sig 0 (0), stat 0 
Apr 19 22:16:52 myhost automount[4357]: sig_child: found pending iop pid 9850: signalled 0 (sig 0), exit status 0
Apr 19 22:16:52 myhost automount[4357]: send_ready: token=299 

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--/9DWx/yDrRhgMJTb--

