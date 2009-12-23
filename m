From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: sshfs and autofs
Date: Wed, 23 Dec 2009 23:53:59 +0100
Message-ID: <1261608555-sup-8913@nixos>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl> <1261391275-sup-7258@nixos>
	<4B311928.9070503@bononline.nl> <1261518309-sup-4721@nixos>
	<4B329000.3060101@bononline.nl> <4B3292D4.5040106@bononline.nl>
	<1261606324-sup-8574@nixos> <4B329A33.5000901@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4B329A33.5000901@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs <autofs@linux.kernel.org>

Excerpts from Stef Bon's message of Wed Dec 23 23:31:15 +0100 2009:
> Marc Weber wrote:
> > Excerpts from Stef Bon's message of Wed Dec 23 22:59:48 +0100 2009:
> >   
> >> Stef Bon wrote:
> >>     
> >>> This is the whole problem, because this is not easy. The automounter 
> >>> (read man 5 autofs) can offer variables like USER, UID, etc,HOST
> >>> of the user requesting the mount (according to the manpage). Then to 
> >>> present this user a suitable dialog... maybe via dbus???
> >>>       
> >> I'm silly here, the user is not the problem, this is already available, 
> >> in the options, or - in my construction - in the config file, in the 
> >> parameter AUTOFS_USER
> >> and in the mountpath, but the environment this user is using! A pid of 
> >> the process would be very usefull, for example.
> >> But this is not easy. When I'm logged in twice with the same account, 
> >> which session should get the question for the passphrase?
> >>     
> >
> > About which session are you talking now? A ssh-agent session determined
> > by SSH_AGENT_PID and SSH_AUTH_SOCKET ?
> >
> > Add this to your .bashrc or .zshrc:
> >
> > reuseSSHAgent () {
> >         local f=~/.current-ssh-agent
> >         . $f || true
> >         ps -p "$SSH_AGENT_PID" &> /dev/null || {
> >                 ssh-agent | grep -v echo > $f
> >                 . $f
> >                 ssh-add
> >         }
> > }
> > reuseSSHAgent
> >
> > If there is a ssh agent running it will be used if not it will be
> > started. Then ssh-add will be run (I use only one key so this is
> > comfortable to me ..)
> >
> > Maybe I should check that the socket file exists then I would'nt have to
> > run ps.
> >
> > Gentoo has a nice script called "keychain" which provides this and more
> > for ssh-agent and the gnu-gpg agent. However I felt it was too bloated
> > and replaced it by this function.
> >
> > You really don't want to type your password twice, do you ? :)
> >   
> No, but sometimes inevitable.
> 
> I'm talking about the usersession. When logged in twice, and I'm 
> activating the mount at the second session (or login)
> how does the automounter and the mount script know which usersession to 
> present a dialog.
> 
> This is no issue when you first enter the passphrase manually in the 
> first session, make use of it and reuse it on the second.
> 
> Stef

How does wall work ?
Maybe it should be asked on all terminals.
This would work.
But that's the reason why I didn't even try to find a solution.

If automount knew about the process id there might be a chance figuring
out about the tty being used..

But it's not a problem for me so I won't fix it unless you have an idea
which can be implemented fast.

Marc Weber
