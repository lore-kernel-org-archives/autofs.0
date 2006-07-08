From: ramana <intraperson@yahoo.com>
Subject: Re: Large number of mount request.
Date: Fri, 7 Jul 2006 22:53:04 -0700 (PDT)
Message-ID: <20060708055304.30906.qmail@web56008.mail.re3.yahoo.com>
References: <1152334903.2814.6.camel@raven.themaw.net>
Reply-To: ramana@intraperson.com
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1152334903.2814.6.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Latrell <is85022@cis.nctu.edu.tw>, Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org



--- Ian Kent <raven@themaw.net> wrote:

> 
> I think Jeff has pretty much summed it up.
> 
> The SIGTERM terminates autofs and you then have unnecessary startup
> and
> shutdown overhead giving a window where mounts will not work as there
> is
> no daemon to manage them.
> 
> Don't forget that there was also a bug in the lock routines that
> cause
> it not to wait sometimes. Apply, at least the locking patch to 4.1.4.

I do not think so.

His explanation about what actually he is doing is not very clear.

Little more explanation on how he is doing strss test would help,
'rather than trying to include his own conclusions'

Thanks in advance.

Regards
ramana

--

Autodir

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
