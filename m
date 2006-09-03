From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to therr automount points
Date: Sun, 3 Sep 2006 22:31:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0609032221570.24199@frank.dcs.qmul.ac.uk>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net> 
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net> 
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net> 
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk> 
	<Pine.LNX.4.64.0608251417500.14075@frank.dcs.qmul.ac.uk> 
	<1156516669.30971.43.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608271549370.21043@raven.themaw.net>
	<1156849871.15241.9.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608302028550.4441@frank.dcs.qmul.ac.uk>
	<1156994282.5281.4.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608311040070.2953@frank.dcs.qmul.ac.uk>
	<1157019921.14116.5.camel@raven.themaw.net>
	<1157023109.14116.12.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608311221110.12689@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608311221110.12689@frank.dcs.qmul.ac.uk>
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Aug 31 Matt Bernstein wrote:

> Bizarrely, I've seen it work for some users now, eg:
>
> cream:/export73 /server/cream/export73 nfs rw,nosuid,vers=3,rsize=8192,wsize=8192,hard,intr,proto=udp,timeo=11,retrans=2,sec=sys,addr=cream 0 0
> cream:/export73 /home/cream/home73 nfs rw,nosuid,vers=3,rsize=8192,wsize=8192,hard,intr,proto=udp,timeo=11,retrans=2,sec=sys,addr=cream 0 0
> cream:/export73 /homes/melanie nfs rw,nosuid,vers=3,rsize=8192,wsize=8192,hard,intr,proto=udp,timeo=11,retrans=2,sec=sys,addr=cream 0 0
>
> I think it's working on some NFS volumes and not on others, even
> though they're identically configured. I'll have to have a dig further.

Further archaeology suggests that traversing home directories only works 
if they have 755 permissions.

I've no idea why.

Hope this is useful, though..
