From: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Subject: Re: Help with automounting from a LDAP server
Date: Mon, 10 Jan 2005 10:30:04 +0100
Message-ID: <20050110093004.GB30790@uranos.quantum.physik.uni-potsdam.de>
References: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
Reply-To: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Mon, Jan 10, 2005 at 01:29:23AM -0600, Krishnakumar B wrote:
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

Yes.

> If so, do people recommend using the same
> approach (using a direct mount) for /var/spool/mail on nfs.example.com?  If
> not, why not?
> 
> Is there any way to disable specify exclude clauses in the mount options to
> autofs?  For example, can I specify some option to autofs so that on a
> particular machine autofs will not use the automount entry from the
> directory server.

I don't know a way to specify exclude clauses in the mount options, but
you might be able to do something equivalent in the LDAP query itself:
I've written a patch for autofs-4.1.3 to give more flexibility with LDAP
requests; in particular, it allows to specify arbitrary search filter
expressions, so you should be able to include something along the lines of
!(hostname=$MYSELF) into the query, if that is what you need. The patched
version of modules/lookup_ldap.c is available at
  http://www.timof.qipc.org/autofs-4.1.3-patch

Regards,

Timo Felbinger


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany
