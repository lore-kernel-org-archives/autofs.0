From: Ian Kent <raven@themaw.net>
Subject: Re: user token
Date: Wed, 28 Nov 2007 00:40:47 +0900
Message-ID: <1196178047.3973.44.camel@raven.themaw.net>
References: <4a3f02760711260149g1f5be5f9q9fcd2ea5d364b95@mail.gmail.com>
	<1196101382.3381.7.camel@raven.themaw.net> <474B1E0E.3040505@gmail.com>
	<1196129844.3973.16.camel@raven.themaw.net>
	<4a3f02760711270019v490249fet119d1683cd41f995@mail.gmail.com>
	<1196168788.3973.33.camel@raven.themaw.net>
	<4a3f02760711270713k7083ddabya43b735eba8fc509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4a3f02760711270713k7083ddabya43b735eba8fc509@mail.gmail.com>
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
To: muzzol <muzzol@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-11-27 at 16:13 +0100, muzzol wrote:
> 2007/11/27, Ian Kent <raven@themaw.net>:
> > I have no idea what you are talking about here.
> >
> 
> sorry for not being clear.
> 
>  - im using version 5.0.2
>  - i want an executable map that asks some info to user.
>  - i take auto.smb as base and add something like this:
> 
> opts="-fstype=cifs,credentials=$CREDENTIALS"
> 
> USERSESSION=`w | grep "x-session-manager"`
> USER=`echo "$UXSESSION" | cut -d" " -f1`
> DISPLAY=`echo "$UXSESSION" | tr -s " " | cut -d" " -f2`
> CREDENTIALS="/home/$USER/.smb.auth.$key"
> 
> if [ ! -e "$CREDENTIALS" ]; then
>     NEWKEY=`zenity --entry --hide-text --text="Enter your pass for $key"`
>     echo -e "username=$USER\npassword=$NEWKEY" > "$CREDENTIALS"
> fi
> 
> [...]
> 
> this works as long as there's only one user on the machine and is
> pretty limited. if user variables were exposed to executable maps it
> could be easily integrated with Zenity, DBUS, xmessage, or any other
> user space process.

I think this is where the problem is.
Expose what user variables?
The ones of the user process requesting the mount?
They are present in the user process not the automount process and
basically aren't known to automount.

This is the fundamental problem with adding this feature.
One suggestion is to actually decouple the mount request from automount
and run a program from the kernel within requesting user context but
then you can't mount because you're not root and executing a program
from the kernel is bad news as far as I'm concerned. You just can't get
return status.

> 
> 
> > The USER macro is available to maps (along with the others I mentioned
> > before), including executable maps as an environment variable, and as a
> > macro variable for normal maps, when using version 5.
> >
> 
> but this is _after_ the executable map is processed, so its usability
> is very limited.

What do you mean "after" it's processed.
It, along with the other variables, are set in the environment prior to
executing the map.

Ian
