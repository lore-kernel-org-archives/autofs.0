From: raven@themaw.net
Subject: Re: Please help - cleanup
Date: Thu, 6 May 2004 22:44:56 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405062236500.16356@donald.themaw.net>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
	<16535.44980.475389.900686@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
	<40997CA1.2070904@sedona.intel.com>
	<16538.12848.197215.483456@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16538.12848.197215.483456@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 6 May 2004, Jeff Moyer wrote:

> I'm not certain of this, as I haven't had a chance to test w/o it.  As I
> mentioned before, I ran across a problem with clients that got their maps
> from LDAP.  They would timeout given the low timeout value passed to
> rpc_ping.  If we just tell it to use a long timeout value, this seems to
> work.  As I mentioned, this is a band-aid, and I haven't debugged the real
> problem.  I'm hoping Ian's patches fix it.

The replicated server patch continues to be difficult. I'm still working 
on it. I'll post another replacement with an explanation tonight. 
Hopefully I've got the last of the problems with it.

And it looked so inocent it couldn't cause side effects!

> 
> mlblandf> 2) What kernel modules are you going to add to the kernel?  Is it
> mlblandf> the 20040417 ( for 2.6 ) or are you going to wait for the newest
> mlblandf> ones from Ian?
> 
> Unfortunately, the kernel is frozen.  I will have to wait until the pool
> opens up again before I can get any changes in.  In general, we don't take
> patches that aren't upstream, so it's important that the changes make it
> into the Linus tree.

For 2.6 it looks like it is very soon. Andrew was ready to pass it on 
except I got the last minute jitters after your thought provoking mail 
about the differences between 2.4 and 2.6.

Ian
