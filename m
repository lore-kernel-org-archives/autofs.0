From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Help with automounting from a LDAP server
Date: Mon, 10 Jan 2005 18:27:16 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0501101808280.9027@xena.cft.ca.us>
References: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krishnakumar B <kitty@dre.vanderbilt.edu>
Cc: autofs@linux.kernel.org

On Mon, 10 Jan 2005, Krishnakumar B wrote:

> ...  However it is not clear how
> autofs mounts directories residing on the local filesystem on the NFS
> server.
> 
> For example if I have the following setup:
> 
> 1. I export /export/home from the NFS server, nfs.example.com
> 2. The NFS server is also configured to use the LDAP server to get
>    automount information, i.e, automount: ldap in /etc/nsswitch.conf
> 3. auto_home is setup on the LDAP server to spit out something equivalent to:
> 
> *  -rw,hard,intr,rsize=8192,wsize=8192,nosuid nfs.example.com:/export/home
> 
> Will autofs on nfs.example.com recognize the local mount /export/home and
> use a loopback mount for /home?  

It works for me.  I use NIS, not LDAP, for the map, but it should work the 
same for any map type.  The automount daemon specifically identifies 
attempted NFS mounts on the local machine and substitutes bind mounts (on 
Linux).  

> If so, do people recommend using the same
> approach (using a direct mount) for /var/spool/mail on nfs.example.com?  If
> not, why not?

There's no problem if the mail user agent and delivery agent are both on 
the machine that has the mailbox, reaching it either by its own name or via 
a bind/loopback mount.  However, if either one is on another host, file 
locking is not completely effective; most likely there is a short window 
during which both programs can get the lock.  The more common symptom is 
truncated incoming messages; trashed non-deleted messages are also 
possible.  My most recent test of this was last year on Linux kernel 2.4.21 
with kernel NFS; I also tested it a number of years ago on SunOS 3.x.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
