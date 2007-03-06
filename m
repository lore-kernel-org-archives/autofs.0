From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.1 release
Date: Wed, 07 Mar 2007 02:51:48 +0900
Message-ID: <1173203508.3629.32.camel@raven.themaw.net>
References: <200702200718.l1K7Ixlk029511@raven.themaw.net>
	<45DC0CEA.5050502@inria.fr> <1172066045.3380.16.camel@raven.themaw.net>
	<45ED455A.60406@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45ED455A.60406@inria.fr>
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
To: autofs@linux.kernel.org, Guillaume Rousse <Guillaume.Rousse@inria.fr>

On Tue, 2007-03-06 at 11:41 +0100, Guillaume Rousse wrote:
> Ian Kent wrote:
> > Thanks for the reminder.
> > I've grabbed them again and I'll have a closer look this weekend.
> > 
> > One thing though, I feel quite strongly about renaming the config file
> > but maybe I misunderstand what your trying to do so let me check it out
> > first.
> I guess you're refering to
> autofs-5.0.1-rc1-cleanup-config-files-names.patch here.
> Reading it now, it seems I mixed two issues:
> - make ldap_auth configuration file researched in autofs configuration
> directory, instead of having to set its full name in autofs
> configuration file, avoiding yet another subtitution during installation
> - and actually renaming autofs to autofs.conf, mainly for consistency
> between files

Give me some time, I'm working on this now.

> 
> I understand such changes ocurring after a final release may be
> considered a bit drastic, that's why I originally submitted quite long
> ago. The same applies to the patch renaming configuration options from
> DEFAULT_FOO to just FOO: while cleaner, it breaks existing
> configurations. If you don't want to merge them now, please consider
> them for a 5.1 release then.

It should be fine.
I liked the original names but am changing it to what you recommended.
I added a bit to accept the old names as well. Oops, it just occured to
me, I forgot to update the man pages.

Ian
