From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] semi-trivial patches
Date: Mon, 11 Apr 2005 17:14:48 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504111704160.18235@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
	<200504111101.13933.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200504111101.13933.vda@port.imtp.ilyichevsk.odessa.ua>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Mon, 11 Apr 2005, Denis Vlasenko wrote:

> On Sunday 10 April 2005 16:38, raven@themaw.net wrote:
> > 
> > Hi all,
> > 
> > Here is autofs 4.1.4.
> 
> Please find three patches attached.

Good to see your persistent in keeping your patches upto date.
I'll work through this soon as I can fix my mistakes in the 4.1.4 release.

> 
> b.exec.patch makes it possible to rely on PATH
> when exec'ing mount etc. If one wants to do this, he will
> need to run configure like this:
> OUNT="mount" \
> UMOUNT="umount" \
> E2FSCK="fsck.ext2" \
> E3FSCK="fsck.ext3" \
> ./configure
> but at least one wouldn't need to hack C source for that to work
> as expected (.i.e., to search for binaries in the PATH).
> 'Classic' automount would be unaffected since it uses /abs/path/names,
> and exec..p() does not search PATH in this case.
> 
> c.msg.patch removes usage of %m in messages (this can't work for
> non-syslog directed messages). I need this for pending --stderr patch.
> Also it removes tons of stray newlines.
> 
> d.close.patch fixes obscure bug when we can close one of standard
> descriptors.
> 
> Was run tested before, rediffed against 4.1.4 and compile tested.
> 
> Please apply.

I remember applying several of your patches to do with this some time ago.
On my development machine (an Ultra 2), the autofs daemon failed 
completely when trying to log. I mailed you asking about it but received 
no answer.

Are you able to help merging them when I get to it?

Ian
