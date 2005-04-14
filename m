From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release
Date: Thu, 14 Apr 2005 13:58:02 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504141357180.7872@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
 <Pine.LNX.4.62.0504112324510.6384@donald.themaw.net>
 <16989.52849.68024.30163@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <16989.52849.68024.30163@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Wed, 13 Apr 2005, Jeff Moyer wrote:

> ==> Regarding [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; raven@themaw.net adds:
> 
> raven> On Sun, 10 Apr 2005 raven@themaw.net wrote:
> >> Hi all,
> >> 
> >> Here is autofs 4.1.4.
> 
> raven> There were a couple of mistakes in the release.
> 
> raven> The kernel patches have been updated as there were some obvious
> raven> errors in them.  An error in patching of the Debian portion of the
> raven> init script was corrected.
> 
> raven> I've uploaded corrected versions along with a MD5SUMS file of
> raven> checksums for people to verify against.
> 
> raven> The new upload has a timestamp of 11-Apr-2005 06:21-59. If you
> raven> downloaded anything before this, sorry, you'll need to get the
> raven> updated files.
> 
> This new version has regressed since beta2 for /net mounts in my
> environment.  A simple ls of /net/<filer> will now show the contents of
> /net/<filer>/exporteddir.  So, for example, we have devfiler which exports
> /vol/vol1.  When I do an ls of /net/devfiler, I get the contents of
> devfiler:/vol/vol1.
> 
> Okay, after further debugging, it seems we're not identifying this as a
> multimount entry.  It's getting late, so I'm going to turn this over to
> you.  I think that the checking of first_chunk is bogus.  For instance,
> with the below change, everything works as expected for me.
> 

Cool, I'll check this out and get back.

Ian

