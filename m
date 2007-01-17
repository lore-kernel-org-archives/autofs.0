From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.1 rc3 release candidate
Date: Wed, 17 Jan 2007 22:36:17 +0900
Message-ID: <1169040977.4390.61.camel@raven.themaw.net>
References: <200701041309.l04D9S9i031351@raven.themaw.net>
	<45AE01A5.9010408@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45AE01A5.9010408@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Wed, 2007-01-17 at 11:59 +0100, Guillaume Rousse wrote:
> Also sprach Ian Kent:
> > - fix get_query_dn not looking in subtree for LDAP search (missed second
> >   occurance).
> Well, this patch was mine :)

Apologies, you are right.
I do try to credit the source of patches and I didn't mean to leave you
out, sorry.

Now that I think I've just about fixed the more important v5
functionality issues, at least almost all the ones I know about, I'll
have a look through these, thanks.

I must say though that I want to make as few changes as I can till after
the first v5 release. Following that I'll collect the outstanding
patches and apply them and we can deal with any issues.

How urgent are these first two for your needs?

> 
> Actually, I don't really care about getting mentionned in the changelog,
> but I'd like my other patches from
> http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/autofs/releases/5.0.1/0.rc3.1mdv2007.1/SOURCES/
> to get in also, especially when they fix objectives troubles:
> - autofs-5.0.1-rc1-fix-hesiod-check.patch is needed to build without
> hesiod but with other libraries (such as LDAP)

Tell me a little more about this please.

> - autofs-5.0.1-rc1-fix-man-page.patch fix an error in a man page, and
> avoid a useless substitution

The Makefile isn't updated by this patch.
Does this build and install without error in your build environment?

> 
> The following are more discussable, and only concern enhancing
> configuration readability:
> - autofs-5.0.1-rc1-drop-default-prefix-from-config.patch drop useless
> DEFAULT_ prefix from configuration directives

Mmmm .. remember that.
In principle it looked OK but I couldn't help thinking there was
something missed in the patch, I didn't know what but you've been using
it for a while now so I must be mistaken. The other thing, which is more
my way of thinking about the meaning of the names, is that I felt that
the names are more meaningful as they are. For example the master map
name can be changed by passing a value on the command line, and so that
changes the configured default, and similarly the timeout.

> - autofs-5.0.1-rc3-separate-config-files.patch split configuration in
> two parts, one for the automount daemon, one for the automount init script

Initially I didn't want to split these up but looking at the patch and
thinking about it I'm starting to warm to the idea.

> - autofs-5.0.1-rc1-cleanup-config-files-names.patch just tidify
> configuration files names

Not sure about changing the config file name.
There are two common naming schemes, one is what your proposing and the
other is what's being used. I come from a background where the later is
most common so I tend to prefer using it. But that probably needs some
more thought and a closer look at the patch.

Ian
