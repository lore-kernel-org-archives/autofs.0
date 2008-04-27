From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sun, 27 Apr 2008 13:52:32 +0800
Message-ID: <1209275552.7913.29.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<20080426011727.BBE6CF8E2B@serval.math.ucla.edu>
	<1209188097.3120.27.camel@raven.themaw.net>
	<Pine.LNX.4.64.0804261116130.4088@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0804261116130.4088@xena.cft.ca.us>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Sat, 2008-04-26 at 11:48 -0700, Jim Carter wrote:
> On Sat, 26 Apr 2008, Ian Kent wrote:
> 
> > OK, but if you "rpmbuild --rebuild" the source rpm on does it then also
> > produce a debuginfo package?
> 
> Yes, the debuginfo package was produced, and I installed it.  But even so, 
> and with -g appended to their LOCAL_CFLAGS variable (and it was in fact 
> used in the compilation), "nm" reports that /usr/sbin/automount has no 
> symbols.  Stripping was no-op-ed, and I couldn't see where they were 
> removed.  If you or Jeff Moyer have a suggestion how to build this thing 
> with complete symbols, I'll bet the output would be a lot more useful.

You could try changing
make all STRIP=: LOCAL_CFLAGS="$RPM_OPT_FLAGS %(getconf LFS_CFLAGS)"
to
make all DONTSTRIP=1 LOCAL_CFLAGS="$RPM_OPT_FLAGS %(getconf LFS_CFLAGS)"

This uses a change that Jeff did to resolve a similar problem.

> 
> OK, thanks to the search feature of tkinfo: gcc -s means omit all debug 
> symbols.  I relinked by hand omitting -s and copied the resulting binary 
> into place (fortunately our anti-hack mechanisms are not as extensive as 
> I'd like :-)  Now I'll re-do the test.  It would be nice if SuSE's spec 
> file / Makefile were conditionalized for an easy debug build.
> 
> > > There is an update (autofs-5.0.2-30.2) in which the issue is a missing
> > > dependency, so no code change is involved.  The included patches are:
> > > Patch0:         autofs-5.0.2-add-krb5-include.patch
> > > Patch1:         autofs-5.0.2-bad-proto-init.patch
> > > Patch2:         autofs-5.0.2-add-missing-multi-support.patch
> > > Patch3:         autofs-5.0.2-add-multi-nsswitch-lookup.patch
> > 
> > mmm ....
> > 
> > [raven@raven done]$ wc -l patch_order-5.0.2 
> > 67 patch_order-5.0.2
> > 
> > and they've picked up only 4?
> 
> The build service has an unofficial package of autofs-5.0.3 hosted by 
> Matthias Koenig (their developer assigned to autofs).  Would it help if I 
> build and install that one (with symbols)?  Or would you prefer to stick 
> with just one version?  The source URL is
> http://download.opensuse.org/repositories/home:/makoenig/openSUSE_10.3/src/autofs-5.0.3-6.1.src.rpm
> if you want to inspect what they're including.

This depends more on what you'd like to use following the investigation.

Perhaps we could continue a little while with you're current version but
change to working on this one if we don't make progress fairly quickly.

I'm not sure what will be most effective, but as maintainer I'm always
going to recommend using all current fixes, warts and all, as the case
sometimes is.

[raven@raven RHEL-5]$ wc -l /work/autofs/5.0.4/done/patch_order-5.0.3 
15 /work/autofs/5.0.4/done/patch_order-5.0.3

It looks like the above rpm includes 2 of these 15 but they've been
lumped into a single patch so it's a bit hard to tell.

The above list doesn't include the submount fix Jeff and I are currently
testing, which is quite possibly what you need. In addition our testing
is being done with a package that is essentially (very close to) 5.0.3
with several selected patches from the above list.

The gdb backtraces where uninteresting in terms of identifying the root
cause but there was some indication that the expire patches from the
above list may figure in this.

So, consider this and let me know which you would like to go ahead with
and we'll work from there. I guess another consideration for you would
be the likelihood you can get corrections into the SuSE release version
but, to be honest, my main concern is to resolve the issue so the latest
source is better for me. The other consideration for me is that it's
hard to know if prior corrections affect more recent ones in a way that
isn't obvious.

Ian
