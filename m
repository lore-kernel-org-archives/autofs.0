From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs v4 releases, at last
Date: Wed, 1 Oct 2003 22:07:10 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0310012109270.3024-100000@raven.themaw.net>
References: <20030930181300.GA31591@ca-server1.us.oracle.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20030930181300.GA31591@ca-server1.us.oracle.com>
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

On Tue, 30 Sep 2003, Mark Fasheh wrote:

> Excellent! It's great to see this stuff getting out to a larger audience!
> As far as my reghosting stuff goes, could you elaborate on what you need
> done? I might be able to lend a hand ;)

That would be good.

As always (I know you are cool with this but I'll say it anyway), please 
don't think I am picking on you or don't appreciate your efforts. I am 
just giving my opinion. Please feel free to give yours.

You will notice in autofs-4.1.0 that the showmount code you sent has been 
moved to a library along with the cache management routines. I think this 
is more manageable. Also the supporting stuff that you in the kernel 
module need has been added. Unfortunately, that's all so far.

There are a few things I would like to change.

The way that I would like to see a new function (lookup_reghost 
in this case) introduced to the lookup subsystem is to add that function 
to every lookup module and have it return LKP_NOTSUP for those modules 
that don't implement it. This gives a consistent interface for all 
extensions. This is the way I have done it for the lookup_ghost function 
for browsable maps. This should allow for the addition of this 
functionality to other maps without changing the surrounding map 
independent code. At least that's the aim.

I seem to remember having the impression that there was no way to specify 
whether you wanted to use the functionality or not. I think that a command 
line option is needed for this. The default should be for the 
code to behave as though the functionality was not there so that others 
using the product do not get confused with unexpected behavior.

So those are pretty easy.

The bit that looked a bit hard (I may be wrong) was the assumption that 
the map entry is an indirect map, in Sun format and that it is an NFS 
mount that requires no & substitutions. If the hostname was an & I think 
some very strange things might happen. All these things need to be checked 
and handled appropriately. The type of the map entry and substitutions need 
to be handled as well. Only once the entry has passed these sanity tests 
should it be acted upon. This likely requires changes to the parsing 
subsystem which could a bit tricky. Maybe some discussion on this 
would be in order.

Lastly, the functionality needs to be implemented in a way that can easily 
be applied to other lookup modules such as NIS and LDAP. This is in many 
ways the hardest thing to do as there is no pre-defined API for this type 
of extension within the autofs implementation at this stage. I guess some 
discussion of design and agreement on how it should be done might be 
useful here as well. This is probably not essential as your close 
attention to this goal is probably enough and this type of thing is rarely 
done how you would like it first time around.

The idea and method that you have used appears good to me and I'm sure 
that people will find the ability to browse indirect wildcard maps useful 
for the case that it covers. Your help will be greatly appreciated by me 
as well as there are things that I am passionate about implementing 
myself but have not had time to do more than think about them.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
