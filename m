From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Direct mount newbie question
Date: Wed, 25 Jun 2008 17:39:31 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A5793@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A578E@hqemmail01.nvidia.com>
	<Pine.LNX.4.64.0806251647250.15233@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806251647250.15233@xena.cft.ca.us>
Content-class: urn:content-classes:message
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

> -----Original Message-----
> From: jimc@xena.cft.ca.us [mailto:jimc@xena.cft.ca.us] On 
> Behalf Of Jim Carter
> Sent: Wednesday, June 25, 2008 5:07 PM
> To: Stephen Biggs
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] Direct mount newbie question
> 
> On Wed, 25 Jun 2008, Stephen Biggs wrote:
> 
> > I have /home as an indirect mount point using a 
> yp:auto.home key file.
> > 
> > I have an application that I have no control over nor ability to 
> > change its behavior. It does many many searches for a file 
> that I will 
> > call .junk, starting at the cwd and going up the tree until 
> it either 
> > finds / or the file.  If the user is anywhere under the /home 
> > directory, this search eventually tries to open /home/.junk 
> and fails, 
> > but not until it triggers the automounter to try to mount a 
> > non-existent directory named .junk.  Because of the many 
> searches, it 
> > seriously slows down execution due to the automounting storm and 
> > consequent NFS dialogs over the network.
> 
> Is the application by any chance called "Apache" and the file 
> is .htaccess? 

No, and sorry for needing to be so circumspect, but it is an inhouse
proprietary application and I am not at liberty, etc, etc...

> We see the same phenomenon on our webservers.  However, in 
> our case we would be looking for /net/.htaccess (interpreting 
> .htaccess as a hostname), and our DNS efficiently determines 
> that there is no host .htaccess.math.ucla.edu.  So we've 
> never felt the need to work around it.
> 
> If the /home map were involved, I think we would do a YP 
> lookup in yp:auto.home for the named user, find that he has 
> no homedir listed, and return ENOENT on the file.

This won't help us because every one of our users does have a home dir.
In any case, which user it is is irrelevant for this problem.

>  In any 
> case, I'm puzzled about the automounting storm and NFS 
> chatter; unless your maps are quite different from ours, 
> without an entry in whatever map for the nonexistent "user", 
> there's nothing to mount.

But that is exactly the point. The user does exist. The automounter must
determine that there is nothing to mount, and the query is what is
taking this huge amount of time, averaged out over many many attempts to
open the file.

If I have written in a confusing manner, please excuse.  I'll try to
explain more clearly.

The file .junk is a configuration file that this application needs. Call
the application "Q" for brevity's sake.

"Q" starts by looking for the file in the current working directory
which invariably is a subdirectory of an automounted directory under
home.  The current directory may be a few levels down.  "Q" continues
walking up the tree to each parent directory trying to open the file
until it either finds the file or runs out of parents.

The only time this becomes a problem is when it tries to open
/home/.junk.  This triggers the automounter to go across the net to find
the directory in the map.  I may be wrong about any NFS chatter. In any
case, this access of the map across the network can take up to 300 ms to
query and then return a failure.

It has nothing to do with which user is running. The problem is that "Q"
is stupidly written and does this futile search many, MANY times in the
running of a job, not taking no for an answer. Again, as I said before,
I have no control over this application and cannot fix its ridiculous
behavior.

With my solution, I cut the running of a job down from 20.37 seconds
down to 0.52 seconds, a 98% savings.

> 
> > The best way I could see to do it was as such:
> > --snip--
> > In /etc/auto.data, I have one line:
> > /home/.junk -mode=555,fstype=tmpfs,ro :/.junk
> 
> Tempting fate here.  I'll be interested to read other 
> people's comments about how to make this work.  If feasible, 
> sneaking content (like a zero-length .htaccess file) into 
> /home or /net would be a more elegant way to shut up Apache 
> than to try and fail to automount it in the normal way.

But, with my solution, it succeeds in automounting and then there is no
further issue.  It accesses local files, mounts it once, and the next
time through, it is already mounted so no automounter involvement.

However, if I could somehow write into /home, I would love to do that.
That would be the real solution, done everytime the automounter came up.
How do I write a file into /home?  I get a failure when I try `touch
/home/.junk`.

root@server1:/# grep autofs /proc/mounts
auto.home /home autofs
rw,fd=7,pgrp=22752,timeout=600,minproto=5,maxproto=5,dev=12,indirect 0 0
root@server1:/# ls -ald /home
drwxr-xr-x    9 root     root            0 Jun 25 17:22 /home
root@server1:/# touch /home/.junk
touch: creating `/home/.junk': No such file or directory
root@server1:/#
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
