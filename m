From: Ian Kent <raven@themaw.net>
Subject: Re: -hosts and -null enabling for autofs v4.1.x
Date: Mon, 07 Aug 2006 14:56:33 +0800
Message-ID: <1154933793.11586.0.camel@raven.themaw.net>
References: <44AE7785.74E63D70@ggr.co.uk>
	<x49u05laae9.fsf@segfault.boston.redhat.com>
	<44B780FA.DC42CB24@ggr.co.uk>
	<x49bqrsia8r.fsf@redhat.com>  <44B7BF3B.7D744291@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44B7BF3B.7D744291@ggr.co.uk>
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
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

On Fri, 2006-07-14 at 16:58 +0100, Gordon Lack wrote:
> Jeff Moyer wrote:
> >
> > Yes, you are correct.
> 
>    Thanks.
> 
> >                       This line in the man page is what confused me:
> > 
> >      The -null map cancels a previous map for the directory indi-
> >      cated.
> 
>    Yes, it's an interesting interpretation of "previous" since the end
> of that paragraph is:
> 
> >                             To be effective, the -null entries must
> >     be inserted before the included map entry.

Indeed.

I found it confusing as well.

Ian
