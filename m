From: Ian Kent <raven@themaw.net>
Subject: Re: automount never umount
Date: Wed, 23 Nov 2005 07:18:44 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511230717330.2069@donald.themaw.net>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
	<17283.19512.49399.338448@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17283.19512.49399.338448@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 22 Nov 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] automount never umount; Farkas Levente <lfarkas@bppiac.hu> adds:
> 
> lfarkas> Ian Kent wrote:
> >> That wasn't what I had in mind.
> >> 
> >> I was thinking more along the lines of the definition of what constitues
> >> "use". For example any access, such as a directory listing, will update
> >> the "last used" value whereas if I change the definition of "last used"
> >> to "currently in use" then to be busy there would have to be an open
> >> file or a process working directory set. This may solve the GUI scanning
> >> problem we see but wouldn't solve immediate remounting that occurs due
> >> to the scanning as well.
> 
> lfarkas> that would be useful and may be solve our problem. without it the
> lfarkas> current implementation is not usable to umount. think about just
> lfarkas> the daily process like slocate database update, tripwire and may
> lfarkas> be others.
> 
> Things that run infrequently are not at fault, here.  I'd really like to
> know precisely what is going on, in your case.

Knowing what's going on would be good. Yes.

> 
> Ian, I think it would be easy enough to instrument the autofs4 module.
> Simple things, like figuring out which process is triggerring the lookup.
> We can either log it, or just keep a ring buffer.

Yep.

I probably won't get to it till the weekend.

Ian
