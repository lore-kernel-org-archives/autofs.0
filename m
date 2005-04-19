From: raven@themaw.net
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 00:58:23 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113912312.1274.26.camel@barsoom.rdu.redhat.com>
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
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Jeffrey Layton wrote:

> Doh! Just realized that there was a rather nasty logic bug in the last
> patch I sent that could cause it to go into an infinite loop. This patch
> should take care of that (and also makes the code a little cleaner).

I've not had a chance to look at this patch much yet but I have a 
couple of questions the bit that I did look at.

Does the is_local_addr function work correctly for multi-homed hosts?
Does the parse_mount_string work for something like:
"host1 , host2	 ,host3,  host4:/this/dir"?

Ian
