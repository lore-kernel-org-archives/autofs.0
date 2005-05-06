From: Steven Ihde <steve@x2.hamachi.us>
Subject: Re: Re: debug failed automount
Date: Thu, 05 May 2005 21:19:13 -0700
Message-ID: <pan.2005.05.06.04.19.09.534391@x2.hamachi.us>
References: <11101302050428071921ec8bb7@mail.gmail.com>
	<11101302050429222770e0df9d@mail.gmail.com>
	<Pine.LNX.4.62.0504302318540.2229@donald.themaw.net>
	<Pine.LNX.4.62.0505012144150.2824@donald.themaw.net>
	<1110130205050116184381a11e@mail.gmail.com>
	<Pine.LNX.4.58.0505020959430.8040@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

On Mon, 02 May 2005 10:03:38 +0800, Ian Kent wrote:
[discussion of failure to automount a NFS server over a VPN tunnel...]
> This sound even more like the original problem.
> 
> The symptom was intermitent fails.
> 
> So if the target server responds quickly enough all is well.
> But if there's a bit to much trafic or if you stop to scratch it doesn't 
> work.
> 
> As I said I'd recommend the two patches on kernel.org.

I was suffering the same problem, and the patch fixed it.

I'm automounting an NFS server in India with a 250ms round trip time --
autofs consistently refused to mount it.

I applied the non-replicated-ping patch from kernel.org and the problem is
fixed:

http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-non-replicated-ping.patch

Thanks for the information.

Along the way I noticed that the replicated server support seems a bit
broken with respect to the "nosymlink" option.  Before applying the patch
above I noticed that "nosymlink" allowed the slow server to mount -- this
is because "nosymlink" completely bypasses get_best_mount.  This is OK if
you have only a single server, but doesn't work if you have a replicated
mount.  For example,

* -nosymlink foo.bar.com,baz.quux.com:/some/path

will wind up passing the literal string
'foo.bar.com,baz.quux.com:/some/path' to mount, which of course fails --
if you remove the nosymlink option it works fine.

Thanks,

Steve
