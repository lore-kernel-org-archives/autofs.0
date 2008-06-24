From: Ian Kent <raven@themaw.net>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Tue, 24 Jun 2008 15:38:54 +0800
Message-ID: <1214293135.12623.126.camel@raven.themaw.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <D5877985-8F27-4B28-B942-DF54B9C82D29@cam.ac.uk>
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
Cc: autofs@linux.kernel.org, Unix Support <unix-support@ucs.cam.ac.uk>, "J.P. King" <jpk28@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>


On Tue, 2008-06-24 at 08:27 +0100, Anton Altaparmakov wrote:
> Hi,
> 
> On 24 Jun 2008, at 02:08, Jim Carter wrote:
> > On Mon, 23 Jun 2008, Anton Altaparmakov wrote:
> >> On 23 Jun 2008, at 02:08, H. Peter Anvin wrote:
> >>> This sounds like a perfect use of an executable map to me.
> >>
> >> Sounds like something that is certainly worth investigating.
> >> ......
> >> This is what ours look like at present.  When a user logs in we
> >> generate two files (below $user is the user name of the user logging
> >> in):
> >
> > This problem is interesting: how would you do this while using the
> > multi-thread capability of autofs version 5?  Here's how far I got.   
> > First,
> > we're not going to mount anything at login time; we're going to  
> > mount the
> > homedir the first time it's referenced, which on my system would be
> > slightly before logging in is finished (to check the ssh key in the
> > homedir).
> 
> Note this is not possible for us.  You cannot use SSH-keys when the  
> home directory is on a Netware server because you need the user's  
> password to be able to mount the home directory, there is no way to  
> perform the mount before asking the user for their password.  Once the  
> user is logged in, as long as they maintain that session open, they  
> can then use SSH key based authentication when logging in to the same  
> PWF Linux server as their home directory is already mounted so their  
> SSH keys are accessible before their subsequent logins.  This is one  
> of the "features" our users complain about the most...
> 
> > Similarly, we're going to rely on automount's normal expiration
> > behavior to get rid of mounts after logout.
> >
> > /etc/auto.master would say:
> > /server		/etc/auto.per-user
> >
> > /etc/auto.per-user says:
> > *       -fstype=autofs,-DNCP_USER=&     program:/etc/auto.userdirs
> >    (this is bogus, see below)
> >
> > /etc/auto.userdirs is executable and goes something like this:  (I  
> > modified
> > it so it reports something that can be mounted on my system, and it
> > actually happens.)
> >
> > #!/bin/sh
> > # $1 is the map key, i.e. on access to /server/$user/$share, $1  
> > would be
> > # $share.  Translate the key into the server's IP address.  Likely  
> > this
> > # is waaaaay different on an authentic Novell network.
> > ip=`dig +short +search $1 A`
> >
> > # Emit the map row (leaving off the key).  Bogus \'s supplied for
> > # readability.
> > echo -fstype=ncp,ipserver=$ip,owner=$NCP_USER,uid=$NCP_USER,gid= 
> > $NCP_USER,\
> > hard,nodev,nosuid,nfsextras,strong,codepage=cp850,iocharset=utf8,\
> > filemode=640,dirmode=750,a=/authcon/$NCP_USER    :$1/$NCP_USER.Aliases
> >
> > Now, what's the right way to get the NCP user available to the program
> > map?  In a file map -DNCP_USER (as shown, with the hyphen) will  
> > propagate
> > this variable into the map rows, so the whole thing could have been
> > handled in a file map...  except for the IP address in the mount  
> > options.
> > If ipserver could possibly be a FQDN rather than a numeric IP  
> > address, I
> > would be very, very tempted to create a massive DNS map that has "A"
> > records for PWF-HOME$N.$user.ncp-xlate.cam.ac.uk (to give an example  
> > domain
> > structure).  This would be updated, perhaps by dynamic DNS updates,
> > whenever a user's server assignment changed.
> >
> > Returning to the question that most interests me, in the submount I  
> > tried
> > these variants:
> >
> > *       -fstype=autofs,-DNCP_USER=&     program:/etc/auto.userdirs
> >    (NCP_USER was not defined as an environment variable; neither was  
> > USER)
> > *       -fstype=autofs     program:/etc/auto.userdirs &
> >    (The extra arg to the program map was ignored with no error  
> > message)
> >
> > What do people think would be the best way to get the containing map  
> > key
> > into the program map?  Not the key to be translated by the map (in our
> > case PWF-HOME1 etc.), but the key that caused the submount to be  
> > created,
> > or any of the other environment variables of the submount, such as  
> > $USER,
> > which is probably what you really want to use here.
> 
> I would have expected the -DNCP_USER= to be created as an environment  
> variable for the program map to find or alternatively to be given on  
> the program map command line.  Given a choice the environment variable  
> option would be much nicer and easier to use.

Setting them in the environment is the sensible and easiest thing for me
to do. But setting the macros that are in the lookup table at the time
of the mount it isn't done at the moment. I think we had a request for
this some time ago and I made a patch for testing but didn't get any
feedback so I let it slip.

> 
> > Warning: before deploying a submount-based scheme in production,  
> > watch for
> > a resolution of the internal locking (mutex) issue that's so  
> > bedeviling me.
> 
> Could you elaborate on this?  What issue are you seeing?  Thanks a lot  
> in advance!

Jim sees autofs hang.
There is synchronization problem between submounts that are shutting
down at the same time a mount request comes in. Of course we only see it
on busy systems.

Ian
