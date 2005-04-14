From: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release
Date: Thu, 14 Apr 2005 10:04:23 +0300
Message-ID: <200504141004.23164.vda@ilport.com.ua>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net> <16989.52849.68024.30163@segfault.boston.redhat.com> <Pine.LNX.4.58.0504141357180.7872@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504141357180.7872@wombat.indigo.net.au>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Thursday 14 April 2005 08:58, Ian Kent wrote:
> On Wed, 13 Apr 2005, Jeff Moyer wrote:
> 
> > ==> Regarding [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; raven@themaw.net adds:
> > 
> > raven> On Sun, 10 Apr 2005 raven@themaw.net wrote:
> > >> Hi all,
> > >> 
> > >> Here is autofs 4.1.4.
> > 
> > raven> There were a couple of mistakes in the release.
> > 
> > raven> The kernel patches have been updated as there were some obvious
> > raven> errors in them.  An error in patching of the Debian portion of the
> > raven> init script was corrected.
> > 
> > raven> I've uploaded corrected versions along with a MD5SUMS file of
> > raven> checksums for people to verify against.
> > 
> > raven> The new upload has a timestamp of 11-Apr-2005 06:21-59. If you
> > raven> downloaded anything before this, sorry, you'll need to get the
> > raven> updated files.

I think that you should just bump version # in such cases.
Having several tarballs with same version # can wreak havoc.

There is no rule like "versions shall not be released closer than
10 days apart". Linus, for example, once released 2.4.10-dontuse (IIRC),
followed by 2.4.11 on the next day.
--
vda

