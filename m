From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Thu, 17 Nov 2005 13:50:39 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>
  <1132159817.5720.33.camel@localhost>  <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>
 <1132192362.5720.163.camel@localhost>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1132192362.5720.163.camel@localhost>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ram Pai <linuxram@us.ibm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, William H Taber <wtaber@us.ibm.com>

On Wed, 16 Nov 2005, Ram Pai wrote:

> > > > 
> > > > Aren't there other paths that enter revalidate without holding the 
> > > > semaphore? chdir?
> > > 
> > > Looking at the code and it seemed to me that ->revalidate() function is
> > > always with the semaphore held. Atleast VFS seem to have that
> > > assumption.
> > 
> > My reading gives me the opposite impression.
> > 
> > The chdir example above calls the path walking routine which calls the 
> > lookup method with the semaphore held and revalidate without it held. 
> > Clearly, there are a number of other examples.
> > 
> > Certainly, I could be wrong and I'll be checking that.
> 
> I see your point. Looking more through the code it looks like
> the convention about how ->revalidate() gets called, seems to be
> inconsistent in VFS.
> 
> in do_lookup() which calls ->revalidate(), the semaphore is not-held.
> 
> Where as lookup_one_len() is expected to be called with the semaphore
> held. This function calls lookup_hash() which calls cached_lookup()
> which later calls ->revalidate(), and here ->revalidate() is called with
> the semaphore held.  Is this the source of the bug?

Yep. My focus has been very much on link_path_walk so I've missed this 
case.

I understood what was going on after reading your answer to Jeffs 
question. I realized then what lead to it doesn't matter, your point being 
that it's possible to cause this by calling lookup_one_len, as you describe.

> > 
> > What I can't work out is how getdents appears to be called without having 
> > called open. Is there anything more that you can tell me about how you 
> > have been able to demonstrate this error.
> > 
> Maybe you are missing the stubfs part. The stubfs is kind of
> in-the-middle filesystem which sits between the application and
> the autofs4. 

Yep. Got that from the other post to.

> 
> Will Taber: Am I saying this right?

Your original description was fine.

Thanks for putting in the effort to make it clear.

> 
> Take a look at the test patch for stubfs posted at
> http://www.sudhaa.com/~ram/readahead/stubfs.patch
> 

I will. Soon as I get a chance. Sounds interesting.

> 
> For clarity here is the scenario:
> 
> P1 executes 'ls' on a directory belonging to stubfs. 
>           stubfs's ->lookup() gets
> 	  called and it internally redirects that lookup to autofs4
>           by calling lookup_one_len() on /net/ram 
>           note: /net belongs to autofs4 and lookup_one_len() is
>            called holding the inode-semaphore of /net .
>            lookup_one_len() calls lookup_hash() which finds that there
> 	   is no cached dentry for 'ram', and hence allocates a dentry
>            and calls ->lookup() of autofs4. 
>            autofs4 adds the dentry to the dcache and calls its
> 	   ->revalidate() after releasing the semaphore.
>            ->revalidate tries to wake up the automounter daemon, and
>             goes to sleep on a waitq.
> 
> P2 executes 'ls' on another directory belonging to stubfs. 
>          stubfs's ->lookup()
>          gets called and it internally redirects that lookup to autofs4
>          by calling lookup_one_len() on /net/ram. lookup_one_len() is
>          called holding the inode-semaphore of /net.  
>          lookup_one_len() calls lookup_hash() which calls
>          cached_lookup(). cached_lookup() finds the dentry
>          corresponding to 'ram' in the dcache. So it calls
>          ->revalidate() on it. NOTE: this time autofs4's 
>          ->revalidate() is called holding the semaphore.
>          ->revalidate() goes to sleep on the same waitq 
>          waiting on the automounter to wake him up.
> 
> automouter: the automounter now comes in and tries to hold 
>            the semaphore on /net and deadlocks.
> 
> The question is: Who is the culprit?  stubfs?  VFS? or
>              autofs4?

I'm happy to fix it in autofs unless you feel we need to address the wider 
issue.

I'll put together a patch which takes account of this and pushes the 
hold/release down into try_to_fill_dentry. But I would like a little 
time to think about whether there may be other implications.

Ian

