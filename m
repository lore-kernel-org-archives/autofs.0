From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs v4 releases, at last
Date: Fri, 3 Oct 2003 20:53:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0310032012180.3559-100000@raven.themaw.net>
References: <20031002221108.GB31591@ca-server1.us.oracle.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20031002221108.GB31591@ca-server1.us.oracle.com>
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
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 2 Oct 2003, Mark Fasheh wrote:

> On Wed, Oct 01, 2003 at 10:07:10PM +0800, Ian Kent wrote:
> > You will notice in autofs-4.1.0 that the showmount code you sent has been 
> > moved to a library along with the cache management routines. I think this 
> > is more manageable. Also the supporting stuff that you in the kernel 
> > module need has been added. Unfortunately, that's all so far.
> Agreed, glad to see that at least that part made it.

Yep. I did some and realised it was a bit difficult, then went on and did 
what I thought would not have side effects so that it could be used when 
we got back to it.

> 
> > There are a few things I would like to change.
> > 
> > The way that I would like to see a new function (lookup_reghost 
> > in this case) introduced to the lookup subsystem is to add that function 
> > to every lookup module and have it return LKP_NOTSUP for those modules 
> > that don't implement it. This gives a consistent interface for all 
> > extensions. This is the way I have done it for the lookup_ghost function 
> > for browsable maps. This should allow for the addition of this 
> > functionality to other maps without changing the surrounding map 
> > independent code. At least that's the aim.
> That's easy enough to do and as you point out it's more consistent with the
> rest of the way the module interfaces are coded.

Yep.

>  
> > I seem to remember having the impression that there was no way to specify 
> > whether you wanted to use the functionality or not. I think that a command 
> > line option is needed for this. The default should be for the 
> > code to behave as though the functionality was not there so that others 
> > using the product do not get confused with unexpected behavior.
> So a '--reghost' or some such command line parameter to turn reghosting of
> wildcards on? Not that difficult either I suppose.

Not quite what I am thinking.

More of a 

	if it's a wildcard map and reghosting is requested and all the 
		preconditions are met then
		go ahead with reghost
	else
		act like normal wildcard

A no impact implementation. I got the impression this was not quite the 
way it worked.

>  
> > So those are pretty easy.
> > 
> > The bit that looked a bit hard (I may be wrong) was the assumption that 
> > the map entry is an indirect map, in Sun format and that it is an NFS 
> > mount that requires no & substitutions. If the hostname was an & I think 
> > some very strange things might happen. All these things need to be checked 
> > and handled appropriately. The type of the map entry and substitutions need 
> > to be handled as well. Only once the entry has passed these sanity tests 
> > should it be acted upon. This likely requires changes to the parsing 
> > subsystem which could a bit tricky. Maybe some discussion on this 
> > would be in order.
> Ok, my understanding of the autofs4 architecture is somewhat limited, so
> please correct me if I'm wrong in my response here: Obviously, we *have* to
> allow '&' substitutions, but it seems you're thinking of doing that for
> hostnames. The code definitely doesn't know how to do *that* and I honestly
> don't know how we'd get a list of hostnames (at least for a file map). As
> far as assuming it's in Sun format, I'm not sure what the alternative is...
> Are you asking me to support it for all the lookup_* modules? Ghosting in
> and of itself is only supported in less than half the lookup modules... 
> If you're worred about checking to make sure the mount is an nfs one, I
> agree, that definitely needs to be done.

Again not quite what I am trying to get at.

First my saying dealing with it doesn't necessarily mean implementing it. 
So that should make things more reasonable for a start. But dealing with 
it can mean keeping in mind that someone else might implement it.

So ask, how can I deal with entries like:

*		&:/remote/dir
or
*		:/dev/&

We'll cope flak that we can do without over this stuff. Whether the 
entries are sensible or not the code should handle the special cases.

And there are more cases I'm sure.

We need to fall back to expected behaviour.

The & and macro substitutions are the biggest headache. To do this we need 
to verify that the map entry is in Sun format and then parse it without 
mounting it to get the rest of the info before deciding it's OK. But 
the current design doesn't know this stuff till later. Hence a rework of 
that part of the core is needed (ouch). I may be wrong and we could 
possibly do it a different way. I'm open to ideas.

Bottom line is people use stuff in ways that their design was not 
intended. To retain our sanity we have to, at least try, to second guess 
them.

> 
> > Lastly, the functionality needs to be implemented in a way that can easily 
> > be applied to other lookup modules such as NIS and LDAP. This is in many 
> > ways the hardest thing to do as there is no pre-defined API for this type 
> > of extension within the autofs implementation at this stage. I guess some 
> > discussion of design and agreement on how it should be done might be 
> > useful here as well. This is probably not essential as your close 
> > attention to this goal is probably enough and this type of thing is rarely 
> > done how you would like it first time around.
> Yeah, I'm not sure what the best approach would be here. Most of the stuff
> is easily seperated out already though...

Good. Then lets do that.

One thing that I was thinking today is should this be a seperate map type?
I'm just rambling don't take any notice.

I suggest seperating as much of the map independent code so that it we can 
use it easily in other map types. It took me two goes to get even the 
small amount of modularity in the stuff that I have and I was constantly 
thinking about it.

If nothing else, at this stage we need to be confident that your 
enhancements will not cause us pain when presented with unexpected maps.

That's really my concern, as once it's there, if some how a bunch of 
people use the package it will have to be supported.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
