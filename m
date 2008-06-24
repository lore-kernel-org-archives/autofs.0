From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Tue, 24 Jun 2008 09:08:35 +0100
Message-ID: <9B01C3D6-BB7F-4500-BC8E-BF0E6202BB34@cam.ac.uk>
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
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214293135.12623.126.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Unix Support <unix-support@ucs.cam.ac.uk>, "J.P. King" <jpk28@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>

Hi,

On 24 Jun 2008, at 08:38, Ian Kent wrote:
> On Tue, 2008-06-24 at 08:27 +0100, Anton Altaparmakov wrote:
>> On 24 Jun 2008, at 02:08, Jim Carter wrote:
>>> What do people think would be the best way to get the containing map
>>> key
>>> into the program map?  Not the key to be translated by the map (in  
>>> our
>>> case PWF-HOME1 etc.), but the key that caused the submount to be
>>> created,
>>> or any of the other environment variables of the submount, such as
>>> $USER,
>>> which is probably what you really want to use here.
>>
>> I would have expected the -DNCP_USER= to be created as an environment
>> variable for the program map to find or alternatively to be given on
>> the program map command line.  Given a choice the environment  
>> variable
>> option would be much nicer and easier to use.
>
> Setting them in the environment is the sensible and easiest thing  
> for me
> to do. But setting the macros that are in the lookup table at the time
> of the mount it isn't done at the moment. I think we had a request for
> this some time ago and I made a patch for testing but didn't get any
> feedback so I let it slip.

Ok.  I have for testing purposes done the changes you suggested and am  
using a file map successfully so we probably will not want/need to use  
a program map given the overhead it would impose.  Much easier to  
regenerate the file map for each user when they log in.  We now have:

/etc/auto.master:
/.servers	file:/etc/auto.user

/etc/auto.user:
* -fstype=autofs file:/var/run/pwfautomount/auto.&

And /var/run/pwfautomount/auto.<username> is generated when <username>  
user logs in and for my user aia21 contains exactly the same content  
as before:

PWF-HOME1	- 
fstype 
= 
ncp 
,ipserver 
= 
172.16.3.42 
,owner 
= 
aia21 
,uid 
= 
aia21 
,gid 
= 
aia21 
,hard 
,nodev 
,nosuid 
,nfsextras 
,strong,codepage=cp850,iocharset=utf8,filemode=640,dirmode=750,a=/ 
authcon/aia21	:PWF-HOME1/aia21.Aliases
PWF-HOME2	- 
fstype 
= 
ncp 
,ipserver 
= 
172.16.3.43 
,owner 
= 
aia21 
,uid 
= 
aia21 
,gid 
= 
aia21 
,hard 
,nodev 
,nosuid 
,nfsextras 
,strong,codepage=cp850,iocharset=utf8,filemode=640,dirmode=750,a=/ 
authcon/aia21	:PWF-HOME2/aia21.Aliases
PWF-HOME3	- 
fstype 
= 
ncp 
,ipserver 
= 
172.16.3.44 
,owner 
= 
aia21 
,uid 
= 
aia21 
,gid 
= 
aia21 
,hard 
,nodev 
,nosuid 
,nfsextras 
,strong,codepage=cp850,iocharset=utf8,filemode=640,dirmode=750,a=/ 
authcon/aia21	:PWF-HOME3/aia21.Aliases
PWF-HOME4	- 
fstype 
= 
ncp 
,ipserver 
= 
172.16.3.45 
,owner 
= 
aia21 
,uid 
= 
aia21 
,gid 
= 
aia21 
,hard 
,nodev 
,nosuid 
,nfsextras 
,strong,codepage=cp850,iocharset=utf8,filemode=640,dirmode=750,a=/ 
authcon/aia21	:PWF-HOME4/aia21.Aliases
PWF-SHARED	- 
fstype 
= 
ncp 
,ipserver 
= 
172.16.3.8 
,owner 
= 
aia21 
,uid 
= 
aia21 
,gid 
= 
aia21 
,hard 
,nodev 
,nosuid 
,nfsextras 
,strong,codepage=cp850,iocharset=utf8,filemode=640,dirmode=750,a=/ 
authcon/aia21	:PWF-SHARED/aia21.Aliases

On logout I then do this:

# Kill user's processes politely at first, then less so.
su -c "kill -TERM -1" $user
sleep 1
su -c "kill -KILL -1" $user
sleep 1
# For logging purposes
ps -U $user

# Tidy up the user's (auto)mounts.
(
         umount /home/$user
         umount /authcon/$user
         /sbin/killproc -USR1 /usr/sbin/automount
) >/dev/null 2>&1

And yes, this does expire everybody's non-busy mounts but that is not  
actually a bad thing.  They will get automounted on next use so there  
is no problem.  And it has the nice side effect that it will cause  
broken mounts to expire sooner.  (We have a recurring problem where  
people leaving themselves logged in for ages end up with broken  
connections and NCPfs does not support reconnects so this might  
actually help us.)

>>> Warning: before deploying a submount-based scheme in production,
>>> watch for
>>> a resolution of the internal locking (mutex) issue that's so
>>> bedeviling me.
>>
>> Could you elaborate on this?  What issue are you seeing?  Thanks a  
>> lot
>> in advance!
>
> Jim sees autofs hang.
> There is synchronization problem between submounts that are shutting
> down at the same time a mount request comes in. Of course we only  
> see it
> on busy systems.


I assume someone has attached to such a hung machine with gdb and  
gotten the two (or more) stack traces involved in the dead lock to  
find where in the code this happens?  If not, that begs the question  
as to why not?  (-:  Also if the problem really is with a mutex then  
the kernel's own mutex debugging code should pick up on the dead lock  
and produce stack traces, too.  Jim, have you tried running a kernel  
with lock debugging features turned on?

If there is a reproducible test case, perhaps a script that can be run  
to trigger it, I could look into it if no-one else has done it  
already...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
