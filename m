From: Joseph Mack NA3T <jmack@wm7d.net>
Subject: Re: automount doesn't expire nested nfs mounts for certain
 kernel configs
Date: Mon, 10 May 2004 05:28:29 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405100504440.7687@www.wm7d.net>
References: <409E4AB5.6A3CCEB1@wm7d.net>
	<Pine.LNX.4.58.0405100913350.14283@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405100913350.14283@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, 10 May 2004, Ian Kent wrote:

> > machine that does autoexpire nested nfs mounts
> >
> >   < > Kernel automounter support
> >   <M> Kernel automounter version 4 support (also supports v3)
>
> Yes. It loads the autofs4 module.
>
> >
> > machine that doesn't autoexpire nested nfs mounts
> >
> >   <M> Kernel automounter support
> >   <M> Kernel automounter version 4 support (also supports v3)

Looked at the kernel config help for these options to find that you don't
activate the first option if you want autofs v3 or v4 support. Since the
question is simple, and knew I wanted autofs support, it never occured to
me to read the help. I just said yes to the first option. I didn't know
what the first line did or why there were two lines for autofs. Perhaps I
thought that the first line was core autofs code while the 2nd line was
for v3 and v4.

Here's a suggestion for a fix

   < > Kernel automounter version 1,2 support (incompatible with v3,4)
   < > Kernel automounter version 3,4 support

> Using autofs-4.0.0 you need to add
>
> alias autofs autofs4
>
> to your modules.conf to ensure that autofs4 gets loaded.

autofs4 was loaded

> I wasn't aware expire didn't work with the autofs module and v4.

If you have the first option activated in the kernel config
then
 	expire with _nested_ nfs mounts doesn't work
	automount from autofs-4.1.2 won't load (well, loads and exits)
	automount from autofs-4.0.0pre10 loads OK
	expire with non-nested mounts works fine
fi

> > I can't get the automount from autofs-4.1.2 to load on the machine which
> > doesn't autoexpire. automount runs and exits with no process in the ps table,
> > no errors in the logs. Running with -d gives a few lines in the log files
> > as it fires up, but no error messages. firing up the demon under strace,
> > looks the same in both cases, as I don't see anything after the fork().
>
> Are you actually sending the *.debug to the log?

I was looking in the wrong spot. autofs-4.0.0pre10 on my machine sends the
logs to a file called debug (don't have machine here, so I don't know
what's in syslogd.conf). I expected the logs from autofs-4.1.2 to go to
the same file, but it's being sent to the file "messages". So I found
the output now.

Thanks Joe

-- 
Joseph Mack NA3T EME(B,D), FM05lw North Carolina
jmack (at) wm7d (dot) net - azimuthal equidistant map
generator at http://www.wm7d.net/azproj.shtml
Homepage http://www.austintek.com/ It's GNU/Linux!
