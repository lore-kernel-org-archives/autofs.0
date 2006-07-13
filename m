From: Ian Kent <raven@themaw.net>
Subject: Re: Map overrides
Date: Thu, 13 Jul 2006 13:01:24 +0800
Message-ID: <1152766884.2929.18.camel@raven.themaw.net>
References: <20060712013858.GA29064@mail.iSKUNK.ORG>
	<1152674321.2930.28.camel@raven.themaw.net>
	<20060712041816.GC29064@mail.iSKUNK.ORG>
	<1152705813.2930.34.camel@raven.themaw.net>
	<20060713021103.GG29064@mail.iSKUNK.ORG>
	<1152765179.2929.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1152765179.2929.11.camel@raven.themaw.net>
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

On Thu, 2006-07-13 at 12:32 +0800, Ian Kent wrote:
> On Wed, 2006-07-12 at 22:11 -0400, Daniel Richard G. wrote:
> > On Wed, 2006 Jul 12 20:03:33 +0800, Ian Kent wrote:
> > > > 
> > > > So there's nothing going on here w.r.t. checking whether an NFS/AFS server 
> > > > is up. It's about overriding what autofs would usually do---to have a 
> > > > program map return the (special-case) local path, preempting the usual 
> > > > LDAP/Hesiod request. (And if and only if the program map gives no answer, 
> > > > go ahead and do the LDAP/Hesiod lookup.)
> > > 
> > > OK. Maybe a multi-map entry in the master map will work for this.
> > > 
> > > /mit	program,hesiod:/sbin/myprogmap -- ldap,hesiod://foo/ou=auto.indirect,dc=mit,dc=edu

However I think my syntax is wrong.
It should be
/mit	multi:program,hesiod:/sbin/myprogmap -- ldap,hesiod://foo/ou=auto.indirect,dc=mit,dc=edu


> > > 
> > > It should behave the way you need.
> > 
> > [I wasn't able to get autofs beta6 up and going to answer this, though a 
> > glance at the code implies that the answer is "no"...]
> > 
> > Is this implemented already? Or are you saying that you'd prefer this minor 
> > extension to the master map syntax instead of allowing redundant entries?
> 
> This is part of the original autofs implementation so it's definitely
> available in v4 and so must be carried through to v5 for backward
> compatibility.
> 
> And having a quick look at the code suggests that it could be made to
> function the way you require with some minor changes.
> 
> Ian
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
