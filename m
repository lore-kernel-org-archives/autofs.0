From: raven@themaw.net
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Sun, 9 May 2004 11:59:09 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405091154001.19921@donald.themaw.net>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com> 
	<Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
	<1083952697.18740.86.camel@serpentine.internal.keyresearch.com> 
	<Pine.LNX.4.58.0405081333390.2371@donald.themaw.net>
	<1084051615.2073.5.camel@camp4.serpentine.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1084051615.2073.5.camel@camp4.serpentine.com>
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

On Sat, 8 May 2004, Bryan O'Sullivan wrote:

> On Fri, 2004-05-07 at 22:44, raven@themaw.net wrote:
> 
> > Dealing with mount fails is often a source of pain for a bunch of reasons. 
> > I think the idea of using that as a trigger to re-read the map is likely 
> > not the best as this is potentially the time the map might not be available.
> 
> Right, which is why I suggest dropping the TTL instead of taking
> immediate action.  Frankly, if NIS or LDAP is hosed and you're relying
> on them for directory services, it is unlikely to matter whether or not
> autofs "works", since so much else (i.e. regular user stuff) is going to
> be hosed.

Fair call.

But I don't want to have to deal with the "autofs is not working" calls 
(cause someones NIS is broke). Not everyone has stable infrastructure.

The other problem with a long timeout is that potentially incorrect map 
info is around for a long time. This part of the original complaint.

I can't help but think that the Solaris automounter doesn't do this for a 
good reason?

Ian
