From: Bill Shannon <bill.shannon@sun.com>
Subject: Re: Ubuntu NFS automount problem
Date: Mon, 24 Nov 2008 07:59:48 -0800
Message-ID: <492ACF74.6000703@sun.com>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net>
	<492A56E6.1070603@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <492A56E6.1070603@sun.com>
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

Bill Shannon wrote:
>>> # cat /etc/auto.net
>>> *    -rw,intr    &:/
>>
>> How is do you expect this to work, explain?

Ok, maybe the question you meant to ask is "how is the above entry
supposed to achieve the effect you desire".

That's a good question.

Going back to Solaris, I see that /net is handled by a special
auto.master entry:

/net	-hosts	-nosuid

I'd forgotten all about that.

I just tried that on Linux with autofs and it doesn't seem to work.
Is there a Linux equivalent for the "-hosts" pseudo-map on Solaris?

I'm having the same problem with the corresponding entry in my
my auto.home map.  I guess exporting each individual home directory
from zfs isn't going to work the same way exporting the entire /export/home
directory works.  I guess I'll have to find a better way to handle that...
