From: Deke Clinger <dclinger@qualcomm.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Thu, 17 Feb 2011 11:21:19 -0800 (PST)
Message-ID: <alpine.LSU.2.00.1102171118360.26104@tux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=qualcomm.com; i=dclinger@qualcomm.com; q=dns/txt;
	s=qcdkim; t=1297970481; x=1329506481;
	h=x-authentication-warning:date:from:to:subject:message-id:
	user-agent:mime-version:content-type;
	z=X-Authentication-Warning:=20tux.qualcomm.com:=20dclinger
	=20owned=20process=20doing=20-bs|Date:=20Thu,=2017=20Feb
	=202011=2011:21:19=20-0800=20(PST)|From:=20Deke=20Clinger
	=20<dclinger@qualcomm.com>|To:=20autofs@linux.kernel.org
	|Subject:=20Re:=20[autofs]=205.0.5=20non-expiring=20mount
	s|Message-ID:=20<alpine.LSU.2.00.1102171118360.26104@tux.
	qualcomm.com>|User-Agent:=20Alpine=202.00=20(LSU=201167
	=202008-08-23)|MIME-Version:=201.0|Content-Type:=20TEXT/P
	LAIN=3B=20charset=3DUS-ASCII;
	bh=2waNrAXk7+m8rO1JlDWfRd/y77N3UkEhvXGoYJ7NnRw=;
	b=p0bt4KiSq1PU7e8iVjrBYNlSylLJNC5C8IT9Zo/eYadoZwgvwnzGeofp
	IBR0Lp0qf9tbiUYyHYnZpI2MATMZ6Z/yks49tFFperwfs 
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

(my reply to Ian, without the logfile attached)

--

On Thu, 17 Feb 2011, Ian Kent wrote:

> On Wed, 2011-02-16 at 17:08 -0800, Deke Clinger wrote:
> > On Wed Feb 16 12:18:15 UTC 2011 Ian Kent wrote:
> > 
> > > A backtrace generally doesn't do us any good when were trying to find an
> > > expire problem, the debug log is where we have to start on these.
> > 
> > I've got a debug log from a sled10sp3 machine running the Novell autofs
> > 5.0.5 update. Ian - could I mail you this personally? I'd rather not have
> > this log with usernames, paths, hostnames, etc. on a public archive.
> 
> Yes please.

Attached. This is all automount entries from bootup in case you're
interested. I login and start doing stuff around "Feb 16 16:38:00". There
are entries like:

Feb 16 16:57:40 src@private automount[3833]: expired /usr2/user1
Feb 16 16:57:40 src@private automount[3833]: expiring path /usr2/user2

but these paths never actually go away.

BTW, this host is running 'autofs5-5.0.5-0.7.1.2597.0.TEST.667967' from
Novell, which includes your 'fix-out-of-order-locking-in-readmap' patch.

> > FWIW, I did do a test with autofs5.0.5 built from source with all the
> > patches in the patch order list from kernel.org and it demonstrated the
> > same behavior: a USR1 signal unmounted the direct map entries but not the
> > indirect. I changed the maps to files, pruned them to a few hundred entries
> > and converted the indirect entries to direct and re-ran the
> > test. Configured like this all entries unmounted upon a USR1 signal so I do
> > believe this has something to do with direct vs indirect mounts. 
> 
> There are a couple of possibilities. I'm always working with the current
> source and basic testing includes expiring both direct and indirect
> mounts as a matter of course and I'm not seeing this. So there has to be
> more to it or I have one or other patches already in the queue that
> resolve the problem.
> 
> Does this happen straight away or start after some time of running?

Immediately. 

> Do all indirect mounts stop expiring or only some?

We use /net with a map like this:

# /net, auto_master, automountMaps, sandiego, corp, qualcomm.com
dn: automountKey=/net,automountMapName=auto_master,ou=automountMaps,ou=sandiego,ou=corp,dc=qualcomm,dc=com
qcautomountkey: /net
objectClass: automount
objectClass: top
objectClass: qcNisObject
automountkey: /net
automountinformation: -hosts -nosuid

Those paths do unmount on signal. 

> What is the for of the indirect map entries, are they multi-mount
> entries?

No multimount, the maps are in LDAP like the one above. Here's my home
directory, for example:

# dclinger, auto.home, automountMaps, sandiego, corp, qualcomm.com
dn: qcAutomountKey=dclinger,automountMapName=auto.home,ou=automountMaps,ou=san 
 diego,ou=corp,dc=qualcomm,dc=com
automountinformation: -rw,noquota filer:/vol/vol2/usr2/dclinger
qcautomountkey: dclinger
automountkey: dclinger
objectClass: top
objectClass: automount
objectClass: qcNisObject

The others are similiar, with different keys obviously and various file
servers and volume names.

> Obviously the debug log will probably answer most of these questions.

Please let me know if any other questions. Thanks for looking at this.

-Deke
