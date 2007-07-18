From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Seeing some 5.0.1 stop expiring mounts
Date: Wed, 18 Jul 2007 14:39:45 -0700
Message-ID: <20070718213945.GA7455@cornholio.qualcomm.com>
References: <20070717195431.GA14624@cornholio.qualcomm.com>
	<1184741167.4178.50.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1184741167.4178.50.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

On Wed, Jul 18, 2007 at 02:46:07PM +0800, Ian Kent wrote:

> Might be worth considering going to 5.0.2, especially since you have a
> busy site, as a nasty deadlock in the alarm handler has been fixed. 

Unfortunately, we can't.  I've since found out (through trial and error)
that the patch:
> > autofs-5.0.1-map-update-source-only.patch

is completely broken for us, and it appears to be part of the 5.0.2
codebase now.

Our main setup for auotofs5 clients now is pure ldap.. auto_master is in
ldap, nsswitch.conf has
automount: ldap
everything is in ldap.  We remove all /etc/auto.* files too.

With the above patch applied to 5.0.1 (or using 5.0.2) as soon as the
daemon gets a HUP signal, it flushes out all the auto.projects (our main
map) entries from /proc/mounts and they're gone forever.

When first started, and until the daemon gets a HUP, it works fine.  Our
/proc/mounts has 6200+ entries (we have a crapload of paths) and
they'll mount great.  Entries look as expected, e.g.:
auto.projects /prj/qct/gv autofs rw,fd=6,pgrp=2571,timeout=600,minproto=5,maxproto=5,direct 0 0
then if you mount it, it adds in:
ronald:/vol/eng_ice_0014/qct_gv /prj/qct/gv nfs rw,v3,rsize=32768,wsize=32768,acregmin=1,acregmax=5,acdirmin=1,acdirmax=5,hard,lock,proto=tcp,addr=ronald 0 0

After the HUP, the thing flushes, then logs a ton of rm_dir errors..
like so:

Start of daemon:
automount[2571]: mounted direct mount on /prj/qct/gv with timeout 600, freq 150 seconds

Flush after HUP:
automount[2572]: umounted direct mount /prj/qct/gv

After all umounts.. these errors show for every path:
automount[2549]: rmdir_path: lstat of /prj/qct/gv failed.

I did a test with 5.0.1 with all patchs sans the
autofs-5.0.1-map-update-source-only.patch and it's fine... I can HUP
left and right, do kill -USR1 to flush, etc.  Works right.  But rebuild again
with that patch and first HUP breaks all our auto.projects paths.  Weird
thing is the /net and /usr2 (indirect home dirs) stay working.  Those
entries look like:
$ egrep 'auto.home|/net' /proc/mounts | grep -v auto.projects
-hosts /net autofs rw,fd=9,pgrp=13948,timeout=600,minproto=5,maxproto=5,indirect 0 0
auto.home /usr2 autofs rw,fd=14,pgrp=13948,timeout=600,minproto=5,maxproto=5,indirect 0 0

I can try to get more info out of the ldap setup if needed, but
unfortunately the admin that really knows the ldap side is out until
next week.  I can poke around some though, and use his docs.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
The needs of the many outweigh the needs of the few, or the one.  That's from
Trek.  Pretty cool, huh? -- Dennis Miller
