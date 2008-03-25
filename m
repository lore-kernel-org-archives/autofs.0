From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: sudo and autofs
Date: Mon, 24 Mar 2008 23:12:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0803242227320.21910@xena.cft.ca.us>
References: <1203828797.5413.355.camel@localhost> <47E391D4.9050107@inria.fr>
	<Pine.LNX.4.64.0803210832590.3306@simba.math.ucla.edu>
	<Pine.GSO.4.55.0803241350360.14855@loogie.intranet.csupomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.GSO.4.55.0803241350360.14855@loogie.intranet.csupomona.edu>
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
To: "Paul B. Henson" <henson@acm.org>
Cc: autofs@linux.kernel.org

On Mon, 24 Mar 2008, Paul B. Henson wrote:

> On Fri, 21 Mar 2008, Jim Carter wrote:
> 
> > Unfortunately Kerberos is used to authenticate the client *host*, so
> > hostbased impersonation schemes (rogue laptops) no longer work, but it
> > still relies on the client to honestly report the alphabetic loginID and
> > group ID of the client user, and so is vulnerable to a generic root
> > exploit on the client.
> 
> I don't believe that to be the case -- Kerberos NFS authenticates the
> end-users. If you're actually using Kerberos security, any access from a
> local user without appropriate credentials is mapped to the nobody account
> (or simply denied, I don't recall which)

I had hoped to test this by mounting something using -o sec=krb5 (as root 
with no TGT), accessing the content (as myself with a TGT), and then 
destroying my TGT and seeing what happened.  But after a recent OS upgrade, 
my NFSv4 test setup has become broken and I've run out of time for fixing 
it.  I'll continue working on this.

OK, I have a definitive answer: you're right.  Here's the URL:
http://www.citi.umich.edu/projects/nfsv4/gssd/
The user does something (like read()) requiring a GSS security context. 
The client's kernel has a cache of such contexts and representative tokens.
The token for (user x server) is missing, so it sends a message to rpc.gssd
    on the client to get one.
rpc.gssd infers the filename of the user's credential cache from the UID,
    chatters with the server's nfsd and rpc.svcgssd, and gets a security
    context (you hope).  
The client's kernel can now present a valid token to make the access 
    happen.

When the operation is done by root, like mounting, it's a special case and
the key needed to get the service ticket is found in the default 
keytab, rather than the usual way through the TGT.  

There are complaints that rpc.gssd only looks for /tmp/krb5cc_${UID} 
whereas pam_krb5 uses /tmp/krb5cc__{UID}_XXXXXX (randomized by mktemp).
There is supposed to be a patch for this but I haven't discovered yet 
whether I have it.

Access will not happen unless the KDC has nfs/${fqdn}@REALM for both hosts 
(can't mount) and for the user (can't create security context for 
read/write).

I still want to actually see it work/fail on my test machines.  But 
destroying my ticket will have no effect because the kernel caches it.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
