From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Tue, 06 Jan 2004 14:20:57 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFB34C9.5010305@zytor.com>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
	<20040106215018.GA911@sun.com> <3FFB316A.6000004@zytor.com>
	<20040106221502.GA7398@hockin.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040106221502.GA7398@hockin.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Tim Hockin <thockin@hockin.org>
Cc: autofs <autofs@linux.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Tim Hockin wrote:
> On Tue, Jan 06, 2004 at 02:06:34PM -0800, H. Peter Anvin wrote:
> 
>>>Can you maybe share some details?  I think this deign moves MORE state to
>>>userspace (expiry aside).  The "state" in kernel is really mostly sent back
>>>to userspace.  No more passing pipes into the kernel (state) or tracking the
>>>pgid of the daemon (state).
>>
>>If you want to fire up a new daemon, all that state that was supposed to
>>be kept in userspace has to be reconstructed.  That means the kernel has
>>to have all that information; this would include stuff like what kind of
>>umount policy you want for each key entry (the current daemon doesn't do
>>that because it doesn't have the proper state.)
> 
> I'm not really sure what you're saying., here.  I'm sorry.  Not trying to be
> thick, just not understanding.
> 
> What umount policy?  What state is supposed to be kept in userspace that isn't?
> 

The current autofs daemon, for example, does not handle different
procedures on umount.  This is particularly important when you have
mount trees.

> 
>>>The daemon as it stands does NOT handle namespaces, does NOT handle expiry
>>>well, and is a pretty sad copy of an old design.
>>
>>First of all, I'll be blunt: namespaces currently provide zero benefit
>>in Linux, and virtually noone uses them.  I have discussed this with
>>Linus in the past, and neither one of us see namespaces as being worth
> 
> Let's get rid of them, then.  Make life that much easier.
> 

That's what the Linux community is doing, de facto.  The Linux userspace
simply is not set up to handle namespaces, and the autofs daemon is no
exception.  Consider such a simple thing as /etc/mtab - /proc/mounts
which is necessary for most of the mount(8) functionality to work.  It
doesn't support namespaces and really cannot be made to.

namespace support in Linux is at the best a far-off future goal.  It is
one thing to put in infrastructure, especially since it has some other
nice benefits; it's another thing to revamp all of userspace to use it;
it's nowhere close and autofs is no exception.

	-hpa
