From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sat, 26 Apr 2008 13:34:57 +0800
Message-ID: <1209188097.3120.27.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<20080426011727.BBE6CF8E2B@serval.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080426011727.BBE6CF8E2B@serval.math.ucla.edu>
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


On Fri, 2008-04-25 at 18:17 -0700, Jim Carter wrote:
> On Wed, 23 Apr 2008 16:04:44 -0400 Jeff Moyer writes:
> 
> > For starters, can you install the autofs debuginfo package and attach to
> > the running automounter (when in a bad state) and get the output from:
> 
> > gdb> thr a a bt
> 
> > ?  That would be a great help.
> 
> SuSE does not save the debuginfo packages, unfortunately.  The source 
> RPM is
> http://download.opensuse.org/repositories/openSUSE:/10.3/standard/src/autofs-5.0.2-30.src.rpm

OK, but if you "rpmbuild --rebuild" the source rpm on does it then also
produce a debuginfo package?

This is going to make it a bit hard.
I'll got though the patches I think may be related (guess) to this and
see how difficult it is to backport them.

> 
> There is an update (autofs-5.0.2-30.2) in which the issue is a missing
> dependency, so no code change is involved.  The included patches are:
> Patch0:         autofs-5.0.2-add-krb5-include.patch
> Patch1:         autofs-5.0.2-bad-proto-init.patch
> Patch2:         autofs-5.0.2-add-missing-multi-support.patch
> Patch3:         autofs-5.0.2-add-multi-nsswitch-lookup.patch

mmm ....

[raven@raven done]$ wc -l patch_order-5.0.2 
67 patch_order-5.0.2

and they've picked up only 4?

> Patch10:        autofs-suse-auto_master_default.patch
> Patch11:        autofs-suse-autofs_init.patch
> Patch12:        autofs-5.0.1-mount_xdr_no_strict_aliasing.patch

I saw this one before, I think it might be useful to me as well.

> Patch13:        autofs-5.0.2-use_local_cflags.patch
> # UCLA-Mathnet non-hack: this file was in a previous source RPM but
> # not in the current one (???)
> # Patch14:        autofs-5.0.2-nested_mounts.patch
> # UCLA-Mathnet hack: special patch from Ian Kent...
> Patch15:	autofs-5.0.2-dns-name-lookup.patch
> 
> Configuration parameters are:
> ./configure %{_target_cpu}-suse-linux \
>             --libdir=%{_libdir} --mandir=%{_mandir} \
>             --disable-mount-locking \
>             --enable-forced-shutdown \
>             --with-hesiod=no
> 

That's much the same as what I use.

Pitty those backtraces don't have symbols for the threads that are
probably the important ones.

Ian
