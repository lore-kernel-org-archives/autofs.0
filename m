From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Tue, 24 Jun 2008 11:46:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806241121430.4023@xena.cft.ca.us>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
	<1213969464.2971.107.camel@raven.themaw.net>
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>
	<1213974299.4975.15.camel@raven.themaw.net>
	<095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
	<1213975734.4975.17.camel@raven.themaw.net>
	<485BE2E6.9080509@zytor.com>
	<1213986137.4975.39.camel@raven.themaw.net>
	<485BFF00.7020205@zytor.com>
	<1214016215.4975.50.camel@raven.themaw.net>
	<485C834C.6010507@zytor.com>
	<1214023459.4975.90.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806211007570.22566@hermes-1.csi.cam.ac.uk>
	<1214186003.3098.10.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806230318150.22566@hermes-1.csi.cam.ac.uk>
	<485EF785.3020308@zytor.com>
	<8109C868-FFB0-4AF3-A667-FEA9F6693558@cam.ac.uk>
	<Pine.LNX.4.64.0806231735200.5058@xena.cft.ca.us>
	<D5877985-8F27-4B28-B942-DF54B9C82D29@cam.ac.uk>
	<1214293135.12623.126.camel@raven.themaw.net>
	<9B01C3D6-BB7F-4500-BC8E-BF0E6202BB34@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9B01C3D6-BB7F-4500-BC8E-BF0E6202BB34@cam.ac.uk>
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
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: autofs@linux.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "J.P. King" <jpk28@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, Ian Kent <raven@themaw.net>

On Tue, 24 Jun 2008, Anton Altaparmakov wrote:

> Ok.  I have for testing purposes done the changes you suggested and am using a
> file map successfully so we probably will not want/need to use a program map
> given the overhead it would impose.  Much easier to regenerate the file map
> for each user when they log in.  We now have:
> 
> /etc/auto.master:
> /.servers	file:/etc/auto.user
> 
> /etc/auto.user:
> * -fstype=autofs file:/var/run/pwfautomount/auto.&
> 
> And /var/run/pwfautomount/auto.<username> is generated when <username> user
> logs in and for my user aia21 contains exactly the same content as before:

This looks like a very sane way to handle your situation.  

> # Tidy up the user's (auto)mounts.
> (
>        umount /home/$user
>        umount /authcon/$user
>        /sbin/killproc -USR1 /usr/sbin/automount
> ) >/dev/null 2>&1
> 
> And yes, this does expire everybody's non-busy mounts but that is not actually
> a bad thing.  They will get automounted on next use so there is no problem.
> And it has the nice side effect that it will cause broken mounts to expire
> sooner.  (We have a recurring problem where people leaving themselves logged
> in for ages end up with broken connections and NCPfs does not support
> reconnects so this might actually help us.)

So it's a similar deal as CIFS: you need, and don't have, the user's 
plaintext password if the automounter ever expires the mount and then tries 
to reconnect when it's referred to again (in the same session).  Bummer.  
At least with CIFS there's the possibility of getting a Kerberos ticket 
valid on Windows at login time, and making it available via rpc.gssd or 
something like that.  I want to experiment with that but haven't 
been able to make time for it yet -- some of our users would really get 
good use out of such a feature.

It's much better if the filesystem is not mounted when the server or client 
crashes (or some idiot unplugs it).  Automounter expiration is good, if 
feasible for the filesystem type.  It also disposes of resources promptly 
without extra scripting by the sysop that could get broken.

> I assume someone has attached to such a hung machine with gdb and gotten the
> two (or more) stack traces involved in the dead lock to find where in the code
> this happens?  

More like 130 threads to be reported, in my case :-( Yes, I have this all 
automated.  You can take a look at some of the tracebacks in the mailing 
list archive (oink).  The rate of hanging seems to be proportional to the 
square of the rate of mount-expire cycles, being caused by a race condition 
getting a mutex, so it was noticed first on our webservers, which serve 
automounted UserDirs.  Ian Kent and I are making good progress stomping 
this bug (he fixes, I break it again :-).

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
