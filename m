From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sat, 26 Apr 2008 11:48:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0804261116130.4088@xena.cft.ca.us>
References: <20080423185018.122C53C3B1@xena.cft.ca.us> 
	<20080426011727.BBE6CF8E2B@serval.math.ucla.edu>
	<1209188097.3120.27.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1209188097.3120.27.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sat, 26 Apr 2008, Ian Kent wrote:

> OK, but if you "rpmbuild --rebuild" the source rpm on does it then also
> produce a debuginfo package?

Yes, the debuginfo package was produced, and I installed it.  But even so, 
and with -g appended to their LOCAL_CFLAGS variable (and it was in fact 
used in the compilation), "nm" reports that /usr/sbin/automount has no 
symbols.  Stripping was no-op-ed, and I couldn't see where they were 
removed.  If you or Jeff Moyer have a suggestion how to build this thing 
with complete symbols, I'll bet the output would be a lot more useful.

OK, thanks to the search feature of tkinfo: gcc -s means omit all debug 
symbols.  I relinked by hand omitting -s and copied the resulting binary 
into place (fortunately our anti-hack mechanisms are not as extensive as 
I'd like :-)  Now I'll re-do the test.  It would be nice if SuSE's spec 
file / Makefile were conditionalized for an easy debug build.

> > There is an update (autofs-5.0.2-30.2) in which the issue is a missing
> > dependency, so no code change is involved.  The included patches are:
> > Patch0:         autofs-5.0.2-add-krb5-include.patch
> > Patch1:         autofs-5.0.2-bad-proto-init.patch
> > Patch2:         autofs-5.0.2-add-missing-multi-support.patch
> > Patch3:         autofs-5.0.2-add-multi-nsswitch-lookup.patch
> 
> mmm ....
> 
> [raven@raven done]$ wc -l patch_order-5.0.2 
> 67 patch_order-5.0.2
> 
> and they've picked up only 4?

The build service has an unofficial package of autofs-5.0.3 hosted by 
Matthias Koenig (their developer assigned to autofs).  Would it help if I 
build and install that one (with symbols)?  Or would you prefer to stick 
with just one version?  The source URL is
http://download.opensuse.org/repositories/home:/makoenig/openSUSE_10.3/src/autofs-5.0.3-6.1.src.rpm
if you want to inspect what they're including.

Mixing topics slightly...  Once when I let the test script run for several 
hours and it got hung up on a lot of mount points, I then ran gdb on the 
main automount process.  gdb started, attached to the process, but did not 
load any library symbols even though available and did not print a list of 
threads.  I can think of two reasons for this: I screwed up, or one of the 
threads splattered nonfatally.

I've been focused on the hung client threads, but I'm starting to suspect 
that the "failed" mounts are equally an issue, because they happen in 
clusters on a single server (i.e. a single submount).  "Failed" means that 
the process which reads the mountpoint directory finishes having read zero 
entries.  I need to encode a possible error code, such as ENOENT, in the 
process' return code, so the main process can record and report something 
useful beyond just "failed".  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
