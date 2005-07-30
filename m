From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-4.1.4/samples/rc.autofs.in bad use of grep \B
Date: Sat, 30 Jul 2005 18:04:30 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0507301802230.2344@donald.themaw.net>
References: <17127.59627.203496.547988@fig.ICSI.Berkeley.EDU>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17127.59627.203496.547988@fig.ICSI.Berkeley.EDU>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Johnson <davidj@ICSI.Berkeley.EDU>
Cc: autofs@linux.kernel.org


Thanks David.

I'll add your patch to the list to be merged for 4.1.5 when I return to 
working on it. Hopefully fairly soon now.

Ian

On Wed, 27 Jul 2005, David Johnson wrote:

> autofs-4.1.4/samples/rc.autofs.in uses \B incorrectly in grep
> commands.  \B actually means "not edge of word", but the script uses
> it to mean "beginning of word".  Fortunately, due to the script
> writer assuming "-" is part of a word, but this not being the case
> when LANG==C, it works under most common circumstances (but
> breaks with e.g. --no--verbose in /etc/sysconfig/autofs).
> However, it may cease to work if more command-line args get added to
> automount.
> 
> I've posted a tested patch against RHEL3 in bugzilla.redhat.com for
> Fedora Devel.  I've also forward-ported the patch to autofs-4.1.4 and
> included it here.  Note that although this is very similar to the
> RHEL3 patch and may well work, unfortunately I have no reasonable way
> of testing it.
> 
> Cheers,
> 
> David.
> 
> 
> 
