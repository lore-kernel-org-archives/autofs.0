From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Thu, 17 Nov 2005 14:19:46 -0500
Message-ID: <437CD7D2.40003@us.ibm.com>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>  <1132159817.5720.33.camel@localhost>  <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net> <1132192362.5720.163.camel@localhost> <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent wrote:
> On Wed, 16 Nov 2005, Ram Pai wrote:
> 
>>
>>The question is: Who is the culprit?  stubfs?  VFS? or
>>             autofs4?
> 
> 
> I'm happy to fix it in autofs unless you feel we need to address the wider 
> issue.
> 
> I'll put together a patch which takes account of this and pushes the 
> hold/release down into try_to_fill_dentry. But I would like a little 
> time to think about whether there may be other implications.
> 

Ian,
I don't think that you can fix this in the autofs by tinkering with 
holding and releasing the parent i_sem.  The reason for this is that you 
  don't have any way of knowing if you hold that lock or not.  The easy 
case is that nobody holds the lock.  But if the lock is held you have no 
way to know that you are the person holding the lock and you cannot 
unlock someone elses lock without serious consequences.

The only way to fix the lock handling is to fix the VFS.  This means 
either changing all calls to the d_revalidate functions (or all calls to 
d_revalidate itself) so that the parent i_sem is obtained first, or to 
change lookup_one_len (or actually lookup_hash) to only get the lock 
around the filesystem lookup call, matching what is done in real_lookup. 
  I don't know which is better from a locking correctness perspective. 
I would have to defer to the VFS experts on that one.  I do know that 
lookup_one_len is called from about 40 places in kernel tree and 
probably from every filesystem outside the tree as well.  Either way, it 
is a non-trivial piece of work.

If you take the inconsistant locking as a given, then the fix has to 
involve not doing the d_add on the new dentry until after the mount 
completes.  This would eliminate the need for revalidate to wait.  You 
would have to provide a mechanism for keeping track of the outstanding 
mount requests and looking for a a mount in progress before starting a 
new request.  This would take the waiting out of revalidate and put it 
into the lookup request itself where you are guaranteed that the parent 
i_sem lock is held.

I hope this is helps.

Will Taber


