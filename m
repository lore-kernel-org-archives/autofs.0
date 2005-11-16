From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 16 Nov 2005 14:24:00 -0500
Message-ID: <437B8750.9030901@us.ibm.com>
References: <20051116101740.GA9551@RAM>	<17275.20160.12805.536289@segfault.boston.redhat.com>	<1132160404.5720.44.camel@localhost> <17275.31136.794385.872761@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <17275.31136.794385.872761@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com
Cc: Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Jeff Moyer wrote:
> ==> Regarding Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix; Ram Pai <linuxram@us.ibm.com> adds:

> 
> I've been trying to reproduce this using sleeps in the user space daemon,
> and I can't.  Can you post your test code so that I'm not guessing at
> what's going on?  For example, one thing that's unclear is how you are
> stuffing stubfs in between the vfs and autofs.
> 
> -Jeff
> -
The stubfs is just a test filesystem I wrote to reproduce this problem. 
  It doesn't sit between the vfs and autofs.  What it does is to do a 
lookup on /net and save the inode for it.  Then it gets the i_sem on 
/net and calls lookup_one_len on a given hostname.  The second time in 
it omits the lookup (it already has the inode for /net) and down on the 
i_sem lock and then calls lookup_one_len. It has some of it's own 
locking to get properly synchronized to force the race condition.  What 
happens is that both processes are waiting on i_sem for /net.  The first 
one gets it, and calls into the autofs which creates the new dentry, 
starts the automount deamon, and waits for the mount to complete.  Since 
the second lookup is already queued on the i_sem, it get's in second, 
finds the dentry, calls revalidate which waits for the mount to complete 
without releasing i_sem.  This of course prevents the automounter from 
completing the mount.

Does this clarify?

Will Taber
