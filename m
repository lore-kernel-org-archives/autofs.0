From: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Subject: Re: Autofs LDAP info
Date: Fri, 30 Sep 2005 13:49:50 +0200
Message-ID: <20050930114950.GQ6460@uranos.quantum.physik.uni-potsdam.de>
References: <433C86AC.1010100@eecs.wsu.edu>
Reply-To: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <433C86AC.1010100@eecs.wsu.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Thu, Sep 29, 2005 at 05:28:28PM -0700, Jim Kusznir wrote:
> 
> Hello all:
> 
> I've been tasked with making AutoFS get its maps from a Windows 2003 
> Active Directory server via LDAP.  I know AutoFS works with LDAP in some 
> fashon or another, however the documentation seems very sparce, and 
> information on the net seems very fragmented and contradictory in areas.
> 
> My primary questions at this point:
> 
> What schema(s) does the latest AutoFS support?  Does it support 
> standards such as NisMap?  (I've found both "yes" and "no" answers to 
> this on the net, and no details in either)
> 
> How are maps entered in such schema?
>
The current stable version of autofs (4.1.4) does support nis.schema
and autofs.schema. With the nis.schema, entries must have objectclass
"nisObject"; the relevant attributes are "cn" (the mount point, as in
the second argument of the mount command) and "nismapentry" (the
"automount information": options and first argument of the mount
command).

If you need greater flexibility (want to use a different schema), or
if you need to authenticate to the LDAP server: there is a patch for
autofs-4.1.4 to allow this:
  http://timof.qipc.org/autofs
The page also shows some examples. It works for me with an OpenLDAP
server. I've never tried it with Windows AD, but I would like to learn
whether it does.


Regards,

Timo Felbinger


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany   PGP key-id: E92567B2
