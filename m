From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 14:04:31 -0400
Message-ID: <1113933871.1274.56.camel@barsoom.rdu.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Tue, 2005-04-19 at 12:58, raven@themaw.net wrote:
> Does the is_local_addr function work correctly for multi-homed hosts?

I changed the name of the is_local_addr() function to is_bind_addr(),
but otherwise left it more or less untouched. I did this in anticipation
that we will eventually want to make an is_local_addr() function that
does the 'subnet' check that the manpage claims. So, the short answer
is, yes -- it should work for multi-homed hosts since it essentially
does what the original code does here.

> Does the parse_mount_string work for something like:
> "host1 , host2	 ,host3,  host4:/this/dir"?

Yes. I've verified that it does. It even works for relatively strange
stuff like:

host1(1),host2:/this/dir host3(5):/that/dir

Unspecified weights get assigned the value 65535.

> 
> Ian
> 

Also, I didn't mention before, but this patch is against a CVS update
from yesterday. I also goofed and left the old $Id$ line in place so
please ignore that again. I fixed that in my tree, so hopefully that
won't be an issue from here on out.

Thanks,
Jeff
