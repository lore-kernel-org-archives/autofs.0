From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Looking for infor on executable map format
Date: Sat, 27 Mar 2004 16:35:26 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0403271550420.3141@xena.cft.ca.us>
References: <200403261040.08085.krienke@uni-koblenz.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403261040.08085.krienke@uni-koblenz.de>
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
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: autofs@linux.kernel.org

On Fri, 26 Mar 2004, Rainer Krienke wrote:

> I am looking on the exact format that a executable map has to echo to stadout
> in order to automount something.

As far as I can tell, it's supposed to send out what would have been in a
"file" map, minus the key and following whitespace.  For example, I have an
executable map that creates an appropriate file map and then emits a line
to tell the automounter to create a submount with that map.  The script
ends with:

    echo "-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs file:$rete/$1"
    exit 0

(where $rete is the directory where the dynamically created map is and $1
is the basename of the map file which happens to be the key as provided
when the executable map was called).

As another example, under autofs-4.0.0prewhatever that SuSE uses up to
version 9.0, I was not able to get the NIS "home" map working, so I
substituted an executable map which simply does

    ypmatch $1 auto.home 2> /dev/null

whose output is simply

    tupelo:/h1/maint/jimc

(or as appropriate for the particular user).  Both of these could have come
right out of a "file" map following the key: for the first example you
would have had

    tupelo -rsize=8192,wsize=8192,retry=1,soft,fstype=autofs file:/maps/tupelo

(except how do we create the map file on the fly?  We need the executable
map.)  For the second the map would have had:

    jimc  tupelo:/h1/maint/jimc

> # This seems to work, but is it correct?
> --bind -soft,retry=6 / server:/export/user/foo

As I read the man page, it isn't.  You need 2 or 3 whitespace separated
fields.  (For the executable map the key has to be omitted, meaning 1 or 2
fields.)  This example has 4 fields.  The separate operand "--bind" is
going to be real hard to make to work, and the isolated slash (converted to
an out-of-order key in other examples) is not wanted.  If the autofs daemon
were to take the last field as the mount referent and the first field
(--bind) as the mount options, it might just ignore the middle fields, not
bothering to reject the line for illegal format.

Are you actually getting bind mounts?  I thought the referent had to
already be mounted before you could do a bind mount, and the "olddir" has
to be specified as a filename as it would be accessed on the localhost,
e.g. /net/server/export/user/foo rather than server:/export/user/foo.
Also I suspect (don't know for sure) that the referent has to be an actual
filesystem on the local machine, because a NFS filesystem won't have local
inode structures to hook up to.

> My problem is that after a while on my real server which uses lots of user
> automounts like described here after shutting down autofs (switching to
> single user) I am unable to umount the user filesystem with the users on it
> since it claims to be busy. But there are no more processes (like automount,
> nfsd, user processes) that could make it busy.  So I suspect that a wrong
> format of the executable map might confuse the kernel.

I doubt the kernel is confused; more likely there really is a process
"cd'd" to that directory.  Try this (on the machine that refuses to
unmount) -- I'm using my own homedir as the example of what might have to
be unmounted.

[root tupelo /tmp/root.jimc 2] fuser -mv /h1/maint/jimc

                     USER        PID ACCESS COMMAND
/h1/maint/jimc       root      19250 ..c..  imapd
                     jimc      19321 ..c..  -tcsh
                     root      20137 ..c..  su

-m to recognize any directory under the mount point where the named file is
located (in this case, /h1), and -v to show the user and command name.
Without -v you get a 1-line list of just the PIDs and the access code.

Hope this helps!

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
