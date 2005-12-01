From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Thu, 01 Dec 2005 11:27:50 -0500
Message-ID: <438F2486.9080002@us.ibm.com>
References: <20051116101740.GA9551@RAM>	 <17292.64892.680738.833917@segfault.boston.redhat.com>	 <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com>	 <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com> <1133389942.8267.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1133389942.8267.7.camel@lade.trondhjem.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jmoyer@redhat.com, Ram Pai <linuxram@us.ibm.com>, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2005-11-30 at 16:30 -0500, William H. Taber wrote:
> 
> 
>>>Trivially, if you have a d_revalidate that does something like
>>>
>>>int autofs_revalidate(struct dentry *dentry, struct nameidata *nd)
>>>{
>>>  d_drop(dentry);
>>>  return 0;
>>>}
>>>
>>>then the VFS will currently allocate a new dentry with the same name,
>>>and call ->lookup() on it without dropping dir->i_sem. If you still need
>>>to reference the old dentry, then put it on a private list somewhere.
>>>That would also allow you to return the old dentry as the result of the
>>>->lookup() operation if that is desirable.
>>
>>Problem with that, as I understand it and Ian Kent knows better than I, 
>>is that the autofs lookup code creates the dentry and fills it in 
>>partially and marks it as waiting for mounting and wakes up the 
>>automount demon.  The demon completes the mount and finishes filling in 
>>the dentry.  So we cannot have some other lookup coming in and removing 
>>the dentry on us.  At least that is what I understand from Ian's answer 
>>when I proposed the same sort of thing to him.
> 
> 
> What do you mean by "removing the dentry on us"? It is perfectly
> possible to have lookup() return the original dentry every time, which
> is precisely what I suggested above.
What I meant was that the autofs code created this dentry and then 
called d_add to put it in the hash chain, woke up the autofs demon to 
perform the mount then waited for the mount to complete.  The autofs 
code is, I think, intending for the demon to find this entry in a 
revalidate and complete the mount.  But Ian knows better than I.  Anyway 
I did not think that it would be good for a racing call to do_lookup to 
unhash a dentry that the automounter was expecting to find.

I was probably unclear when I referred to lookup.  I meant it in the 
generic sense of do_lookup or lookup_one_len and not the i_op->lookup 
function.  I had already suggested to Ian that they not d_add the dentry
in autofs4_lookup until the mount demon came in to complete the mount 
and have autofs4_lookup be responsible for queing up subsequent lookups 
until the mount completed and moving the code for that out of 
autofs4_revalidate.  He allowed how it would be possible but a lot of work.
> 
> 
>>   Even if  they end up 
>>doing something like that in a future version of the automounter, I 
>>would still like a simple patch that can be applied to existing systems 
>>as an interim fix.
> 
> 
> "Interim" fixes to the entire VFS API such as the ones that have
> proposed here tend to be a poor idea...
> 
Which is why I was discussing the ideas here.  From the start I have 
been asking for input from people with more understanding than I have of 
the subleties of VFS locking.  I have been trying to find a solution 
short of waiting for autofs5 since we are seeing the problem now.  But 
obviously we don't want a fix that causes more problems.  My original 
thought was that the solution to the problem was to make the locking 
requirements for d_revalidate consistent.  I now have a greater 
understanding of why things are as they are.  In another post I have 
outlined what I think a workable solution is that is confined to the 
autofs code.  Your input it has been quite helpful in helping me 
understand all of this.  Thanks.

Will
