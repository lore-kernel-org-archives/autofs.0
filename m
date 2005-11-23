From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 23 Nov 2005 13:47:02 -0500
Message-ID: <4384B926.5030104@us.ibm.com>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>  <1132159817.5720.33.camel@localhost>  <Pine.LNX.4.63.0511170627150.3049@donald.themaw.net>  <1132192362.5720.163.camel@localhost>  <Pine.LNX.4.58.0511171330320.26602@wombat.indigo.net.au>  <437CD7D2.40003@us.ibm.com>  <Pine.LNX.4.58.0511180926400.25749@wombat.indigo.net.au>  <437DF12A.5050805@us.ibm.com>  <Pine.LNX.4.63.0511190025050.2602@donald.themaw.net>  <437E0B62.4000306@us.ibm.com> <1132340265.5720.191.camel@localhost> <437E34D9.4050102@us.ibm.com> <Pine.LNX.4.63.0511190947540.2069@donald.themaw.net> <4381F873.2010408@us.ibm.com> <Pine.LNX.4.58.0511220724250.16196@wombat.indigo.net.au> <438359FA.4060105@us.ibm.com> <Pine.LNX.4.63.0511232118220.3200@donald.themaw.net> <43849C11.6000302@us.ibm.com> <Pine.LNX.4.63.0511240130510.2072@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511240130510.2072@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent wrote:

>>I am a little unclear about this.  Which directory are you talking about?  The
>>mount-over directory or the directory being mounted?  My picture of things
>>(and I haven't verified this by doing anything mundane like reading the code)
>>is that There is a directory (such as /net ) which is of type autofs and as
>>needed new directories of type autofs are created under it for the various
>>hosts/filenames.  Over these subdirectories (the mount-over directories) get
>>mounted the remote filesystems, usually of type NFS.  Is this a correct
>>understanding?
> 
> 
> Yep. That's an indirect mount.

OK.  Got it.
> 
> The directories I'm refering to are the ones created inside the autofs 
> mount point /net or other autofs mount point. Creating the directories 
> makes them browsable without necessarily mounting them (as long as the 
> module knows when to trigger a mount request). This lazyness is what 
> causes all the fus.
> 
> 
>>>Case 2 needs special attention. To achieve this I would need to have two
>>>types of unhashed dentry, valid and invalid (perhaps because of a ENOENT
>>>return from the daemon on mount).
>>>
>>
>>If my understanding above is correct, I don't think you need to hide the
>>dentry for the autofs mount-over directory.  If there is an active mount, then
>>the dentries d_mounted flag will be set and the normal mountpoint traversal
>>will work.  If nothing is mounted here then the autofs mount-over directory
>>lookup functions will be called.  This is where the actual mount request gets
>>triggered.  The dentry created here should not be added to the dentry cache
>>until the dentry is actually ready to use.  It has to be kept in a way that
>>can be found by subsequent calls to lookup in case there are multiple requests
>>for it. The trick is that the first lookup to succeed has to be the one for
>>the mount request.  But once it is on the dentry hash chain, revalidate has to
>>be careful because if the revalidate fails then the dentry will be
>>invalidated.  And if revalidate succeeds then everything needs to be setup so
>>that folow_down will work.  Hmm.  I will have to think about this some more.
> 
> 
> That was how things used to work but late mounting is what's needed to 
> provide the function expected of an automounter when people start using 
> this in an enterprise environment. Basically autofs tells lies until it's 
> forced to tell the truth.
> 
> Point is people expect to be able to see the mount points without causing 
> them to mount until they actually try and access something inside the 
> mount.
> 
> Hence "browseable".
> 
OK.  This is a whole other kettle of fish.
This means that readdir lies and reports about the existance of 
directories but doesn't mount them until someone is actually foolish 
enough to include them in a pathname.  That's the problem.  Too many 
fools. :^)

And thanks for the pointer to the paper.

Will
