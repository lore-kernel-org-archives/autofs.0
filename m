From: raven@themaw.net
Subject: Re: autofs-4.1.2-6 test rpms available
Date: Sat, 8 May 2004 13:51:33 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405081345450.2371@donald.themaw.net>
References: <16538.43940.58650.642984@segfault.boston.redhat.com>
 <1083952048.18740.75.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083952048.18740.75.camel@serpentine.internal.keyresearch.com>
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
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: autofs@linux.kernel.org

On Fri, 7 May 2004, Bryan O'Sullivan wrote:

> On Thu, 2004-05-06 at 14:18, Jeff Moyer wrote:
> > Here is the changelog for the latest version.
> 
> Jeff, I suggest that if you have time, you take a look to see if your
> 4.1.0 RPMs have the "never notice updates to NIS maps" problem that is
> in 4.1.2.  It's not entirely a showstopper, but it's a huge headache.

Sorry to say that's more my problem than Jeffs'.

I think that once we've decided on an implementation plan, and I 
implement it, that it becomes a known problem with earlier versions.

It may be an option for someone to back port the changes. Perhaps someone 
on the list would be interested in doing it.

Ian
