From: Ian Kent <ikent@redhat.com>
Subject: Re: Automouter crashed, I have the core
Date: Wed, 08 Dec 2010 00:24:10 +0800
Message-ID: <1291739050.16875.14.camel@perseus>
References: <4CFE0736.8050606@s3group.cz> <1291724466.16875.6.camel@perseus>
	<4CFE4D4C.9020008@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4CFE4D4C.9020008@s3group.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2010-12-07 at 16:05 +0100, Ondrej Valousek wrote:
> On 07.12.2010 13:21, Ian Kent wrote: 
> > Unfortunately not but there certainly is a mistake in this area
> > somewhere.
> > 
> > I have another report of a hang with very similar symptoms but a thread
> > that should have existed in the back trace had simply disappeared. That
> > thread should have been an expire callback just like the one you have
> > here. So this is really useful to know but I haven't worked it out yet.
> Hi Ian,
> 
> Ok, so how can I help now? Submit a bugzilla request/Redhat support
> case/forget about it?

My problem is working out what is going wrong.

There are two things we need to do. First, any information about what is
happening at the time this occurs might give us a clue of where to look.
Second, a debug log might tell us what is happening, especially if we
can spot the time of the problem and relate it back to the time in the
log, although turning debugging on might stop the bug from occurring.
If that happens then we need to go over what we do have and guess, then
put some selective logging in to try and nail down what is happening.

There's no question this process is difficult for us both and will
require a fair amount of effort but that's the way it goes.

Ian
