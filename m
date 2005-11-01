From: Dannie Stanley <dannie.stanley@gmail.com>
Subject: Re: autofs timeout and large map
Date: Tue, 1 Nov 2005 07:51:43 -0500
Message-ID: <89e9feae0511010451we3f1d43g8c8d3caf0efceb0@mail.gmail.com>
References: <20051028163028.75072c9b.akpm@osdl.org>
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
	<89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
Content-Disposition: inline
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

I performed some testing in the early morning hours and this is what I
found.  The problem seems to be with the --ghost option.  When I
specify this in my auto.master:

   /- /etc/auto.virtual --ghost

I get the originally reported errors.  When I remove the --ghost
option it seems to work as expected.

For good measure I also removed the --bind option from all of my
entries per Ian's suggestion.  He was right they still work without
the bind option.

-- Dannie

On 10/31/05, Dannie Stanley <dannie.stanley@gmail.com> wrote:
> Ian Kent has pointed me to this list.  I have included my original
> message thread posted to linux-kernel (sorry for the incorrect
> posting).  Here are my answers to Ian's specific questions:
>
> > Distribution?
> $ cat /etc/redhat-release
> Red Hat Enterprise Linux AS release 3 (Taroon Update 6)
>
> > Your version of autofs?
> $ rpm -q autofs
> autofs-4.1.3-154
>
> > Kernel version?
> $ uname -a
> Linux ... 2.4.21-37.EL #1 Wed Sep 7 13:35:21 EDT 2005 i686 i686 i386 GNU/Linux
>
> > Have any autofs4 patches been applied to your kernel?
> Standard packaged RedHat kernel, no patches.
>
> > What do you have in your master map?
> $ cat /etc/auto.master
> #/- /etc/auto.virtual --ghost
> /- /etc/auto.virtual
>
> > Then you have 1345 offset mount (multi-mount) entries similar to the
> > one above. Each with two offsets. Correct?
> True.
>
> > How many automount processes end up running after starting autofs?
> Two...
> $ ps -fC automount |cut -c49-200
> CMD
> /usr/sbin/automount --timeout=86400 /- file /etc/auto.virtual
> /usr/sbin/automount --submount --timeout=86400 /virtual file /etc/auto.virtual
>
>
> Thanks for your help!
> Dannie
