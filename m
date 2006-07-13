From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: Map overrides
Date: Wed, 12 Jul 2006 22:11:04 -0400
Message-ID: <20060713021103.GG29064@mail.iSKUNK.ORG>
References: <20060712013858.GA29064@mail.iSKUNK.ORG>
	<1152674321.2930.28.camel@raven.themaw.net>
	<20060712041816.GC29064@mail.iSKUNK.ORG>
	<1152705813.2930.34.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1152705813.2930.34.camel@raven.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

On Wed, 2006 Jul 12 20:03:33 +0800, Ian Kent wrote:
> > 
> > So there's nothing going on here w.r.t. checking whether an NFS/AFS server 
> > is up. It's about overriding what autofs would usually do---to have a 
> > program map return the (special-case) local path, preempting the usual 
> > LDAP/Hesiod request. (And if and only if the program map gives no answer, 
> > go ahead and do the LDAP/Hesiod lookup.)
> 
> OK. Maybe a multi-map entry in the master map will work for this.
> 
> /mit	program,hesiod:/sbin/myprogmap -- ldap,hesiod://foo/ou=auto.indirect,dc=mit,dc=edu
> 
> It should behave the way you need.

[I wasn't able to get autofs beta6 up and going to answer this, though a 
glance at the code implies that the answer is "no"...]

Is this implemented already? Or are you saying that you'd prefer this minor 
extension to the master map syntax instead of allowing redundant entries?

> > Why not? :) Imagine a (public, read-only) volume that's normally 
> > AFS-mounted, but has an NFS backup. As NFS is dead easy to set up, it's a 
> > good option for emergency use.
> 
> In the same entry?
> The Hesoid format can't have AFS and NFS for the same map entry can it?

A single Hesiod record can't specify both, but it can handle one or the 
other. So if you had a situation that could return one of two possible 
records then this would work.


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
