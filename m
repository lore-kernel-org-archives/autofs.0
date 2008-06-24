From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Mon, 23 Jun 2008 18:08:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806231735200.5058@xena.cft.ca.us>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <8109C868-FFB0-4AF3-A667-FEA9F6693558@cam.ac.uk>
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>, "J.P. King" <jpk28@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, 23 Jun 2008, Anton Altaparmakov wrote:

> On 23 Jun 2008, at 02:08, H. Peter Anvin wrote:
> > This sounds like a perfect use of an executable map to me.
> 
> Sounds like something that is certainly worth investigating.
> ......
> This is what ours look like at present.  When a user logs in we  
> generate two files (below $user is the user name of the user logging  
> in):

This problem is interesting: how would you do this while using the 
multi-thread capability of autofs version 5?  Here's how far I got.  First, 
we're not going to mount anything at login time; we're going to mount the 
homedir the first time it's referenced, which on my system would be 
slightly before logging in is finished (to check the ssh key in the 
homedir).  Similarly, we're going to rely on automount's normal expiration 
behavior to get rid of mounts after logout.

/etc/auto.master would say:
/server		/etc/auto.per-user

/etc/auto.per-user says:
*       -fstype=autofs,-DNCP_USER=&     program:/etc/auto.userdirs
    (this is bogus, see below)

/etc/auto.userdirs is executable and goes something like this:  (I modified 
it so it reports something that can be mounted on my system, and it 
actually happens.)

#!/bin/sh
# $1 is the map key, i.e. on access to /server/$user/$share, $1 would be 
# $share.  Translate the key into the server's IP address.  Likely this
# is waaaaay different on an authentic Novell network.
ip=`dig +short +search $1 A`

# Emit the map row (leaving off the key).  Bogus \'s supplied for 
# readability.
echo -fstype=ncp,ipserver=$ip,owner=$NCP_USER,uid=$NCP_USER,gid=$NCP_USER,\
hard,nodev,nosuid,nfsextras,strong,codepage=cp850,iocharset=utf8,\
filemode=640,dirmode=750,a=/authcon/$NCP_USER    :$1/$NCP_USER.Aliases

Now, what's the right way to get the NCP user available to the program 
map?  In a file map -DNCP_USER (as shown, with the hyphen) will propagate 
this variable into the map rows, so the whole thing could have been
handled in a file map...  except for the IP address in the mount options. 
If ipserver could possibly be a FQDN rather than a numeric IP address, I 
would be very, very tempted to create a massive DNS map that has "A" 
records for PWF-HOME$N.$user.ncp-xlate.cam.ac.uk (to give an example domain 
structure).  This would be updated, perhaps by dynamic DNS updates, 
whenever a user's server assignment changed.  

Returning to the question that most interests me, in the submount I tried 
these variants:

*       -fstype=autofs,-DNCP_USER=&     program:/etc/auto.userdirs
    (NCP_USER was not defined as an environment variable; neither was USER)
*       -fstype=autofs     program:/etc/auto.userdirs &
    (The extra arg to the program map was ignored with no error message)

What do people think would be the best way to get the containing map key 
into the program map?  Not the key to be translated by the map (in our 
case PWF-HOME1 etc.), but the key that caused the submount to be created, 
or any of the other environment variables of the submount, such as $USER, 
which is probably what you really want to use here.  

Warning: before deploying a submount-based scheme in production, watch for 
a resolution of the internal locking (mutex) issue that's so bedeviling me.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
