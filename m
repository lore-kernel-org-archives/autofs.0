From: raven@themaw.net
Subject: Re: automount doesn't reread file map, automount terminates
 on empty file map
Date: Mon, 20 Dec 2004 23:27:24 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0412202320040.8019@donald.themaw.net>
References: <1102796222l.6265l.2l@mercury>
	<Pine.LNX.4.58.0412151807070.30726@wombat.indigo.net.au>
	<Pine.LNX.4.58.0412161052250.20186@wombat.indigo.net.au>
	<20041216131949.GA15605@mercury.jahnsnet.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20041216131949.GA15605@mercury.jahnsnet.de>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Thomas Jahns <Thomas.Jahns@gmx.net>
Cc: autofs@linux.kernel.org

On Thu, 16 Dec 2004, Thomas Jahns wrote:

> Hi again,
>
> On 12/16/04 04:00:33, Ian Kent wrote:
>> A further difficulty with this is that to fix this problem a small
>> kernel patch was needed. But what kernel are you using (ie. are the 
>> latest kernel updates included in it)?
>
> I'm currently running a kernel compiled from debian kernel- 
> source-2.6.9_2.6.9-2 package.

I'm not good with Debian packages but I had a go at applying the map 
update patch to the source deb.

I've placed the source deb package files in
http://www.kernel.org/pub/linux/kernel/people/raven/deb
if your interested.

I had to back out an LDAP entries limit patch as the map update patch 
changes the LDAP lookup module. If that's not a problem for you try it 
out.

I haven't tested this at all except to build a deb from it on my system. 
The patch itself has been tested previously.

The kernel patch that is needed for it to function properly is there also.

Ian
