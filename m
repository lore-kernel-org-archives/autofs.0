From: Jim Carter <jimc@math.ucla.edu>
Subject: RE: umount fails with NFS mounts
Date: Thu, 23 Sep 2004 09:39:53 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409230902080.9057@simba.math.ucla.edu>
References: <Pine.LNX.4.44.0409231438370.23756-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409231438370.23756-100000@maggie.lkpg.cendio.se>
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
To: Peter Astrand <peter@cendio.se>
Cc: autofs@linux.kernel.org, Erik Forsberg <forsberg@cendio.se>, nfs@lists.sourceforge.net

On Thu, 23 Sep 2004, Peter Astrand wrote:
> Today, I've managed to reproduce the problem by doing several
> mounts/umounts for the same user. I've used the following shell script:
> 
> #!/bin/sh
> while true; do
>     usleep 50000
>     echo statting
>     stat /home/94azajmi >/dev/null

There's an ambiguity whether you're going to stat the mount point with 
nothing mounted on it, or the referent of the mount.  Since the automounter 
is involved, the mount points could exist without referents, depending on 
the version you're using and what options you've set for ghost mounts 
(browsing).  The automounter *should* finish the mount before releasing the 
thread to do the stat, but...  If you stat /home/$user/. then the filename 
resolution code has to actually read the referent directory and look up "." 
in it, resolving the ambiguity.  

> checking mounts
> 10.201.1.10:/VOL1/Arb/94AZAJMI on /home/94azajmi type nfs 
    (rw,nfsvers=2,hard,intr,addr=X.X.X.X)

The script mentioned further on (programmatic automount map?) changes the
loginID to upper case, because that is what is on the Novell system, right?

"mount | grep $user" and "grep $user /proc/mounts" normally give the same
basic answers (a few options appear only in /etc/mtab), and if there were a
difference between them, it might be a clue.

> I've noticed one very interesting thing: Each time I do a "umount 
> /home/94azajmi", this ends up in the system logg:
> 
> Sep 23 15:03:38 foobar last message repeated 3 times
> Sep 23 15:03:42 foobar automount[1565]: attempting to mount 
    entry /home/94azajmi
> Sep 23 15:03:42 foobar automount[6586]: >> mount: 
    10.201.1.10:/VOL1/Arb/94azajmi failed, reason given by server: No such
    file or directory

The server did not lie, right?  /VOL1/Arb/94AZAJMI is on the server, not
/VOL1/Arb/94azajmi.  Is it possible that there are *two* automount maps,
one with the programmatic case conversion and one maybe a simple file map 
with a wildcard?  

> tl-nds-mountpath does a test-mount (in another
> directory) before returning the mount path. 

Maybe the message above from process 6586 is the test mount, which needed 
case conversion and didn't get it.

> So, during the automount, the 
> script calls the mount command. Perhaps this confuses automount?

I doubt it.  The test mount is finished (and probably unmounted) by the 
time the programmatic automount map script returns the referent pathname.

> Of course, the question is why a umount triggers a mount in the first 
> place...

Let me guess: automount has to consult the map to know the exact hostname
and options used to mount the filesystem, some of which are needed for the
unmount.  (Well, I always do "umount /mount/point" and it works, but maybe
the automounter needs to do more, such as finding and clearing an entry in
the list of filesystems it is responsible for.)  In your case, the map is
programmatic and includes the test mount.  But under obscure circumstances
the necessary case conversion isn't happening.

Things would be a lot easier if you didn't have to do the test mount.  
Maybe do the Novell equivalent of a YP or Hesiod lookup so you know the 
right loginID without having to do any mounts.

I hope this speculation is helpful, not a total fantasy.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
