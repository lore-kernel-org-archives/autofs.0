From: Ian Kent <raven@themaw.net>
Subject: Re: Help with automounting from a LDAP server
Date: Mon, 10 Jan 2005 16:47:53 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501101645100.5722@wombat.indigo.net.au>
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

> Hi,
> 
> Are there any standard practices to follow for automounting from a LDAP
> server without using local files, for both the NFS server and the clients?
> The NFS clients part seems straightforward.  However it is not clear how
> autofs mounts directories residing on the local filesystem on the NFS
> server.

autofs should perform a bind mount if the mount is on the local machine.

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
> use a loopback mount for /home?  If so, do people recommend using the same
> approach (using a direct mount) for /var/spool/mail on nfs.example.com?  If
> not, why not?

Can't do that at present.
Direct mounts are not fully implemented.

> 
> Is there any way to disable specify exclude clauses in the mount options to
> autofs?  For example, can I specify some option to autofs so that on a
> particular machine autofs will not use the automount entry from the
> directory server.

Not that I know of.

Ian
