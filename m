From: "Wolfe, Allan" <Allan_Wolfe@anadarko.com>
Subject: RE: Autofs LDAP info
Date: Fri, 30 Sep 2005 08:39:38 -0500
Message-ID: <01C21895FD36D7419A4777E29FED91B90151DA84@houmbx19.anadarko.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

 Maybe I can help a bit here.  Microsoft supposedly uses the standard
rfc2307 schema, however, they seem to embellish the standard with their
own naming -- particularly prefacing the names with "mssfu" (Microsoft
Services for UNIX).  

I have a couple of broader questions along this line that I've not been
able to discern/decipher out of the information to implement LDAP with
autofs.  

(1) How does one utilize ldaps. All the notes I've seen has been
insecure transport.  We can't justify GSSAPI and TLS simple fits our
needs. 

(2) Why doesn't autofs (or maybe it does and it doesn't make sense)
utilize NSS?  Using NSS would give flexibility to create service search
descriptors to deal with the Microsoft and Sun deviations in object
definition without having to maintain duplicate data to accommodate any
version.  SSD support would logically be built into nss_ldap framework.

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Timo Felbinger
Sent: Friday, September 30, 2005 6:50 AM
To: autofs@linux.kernel.org
Subject: Re: [autofs] Autofs LDAP info

On Thu, Sep 29, 2005 at 05:28:28PM -0700, Jim Kusznir wrote:
> 
> Hello all:
> 
> I've been tasked with making AutoFS get its maps from a Windows 2003 
> Active Directory server via LDAP.  I know AutoFS works with LDAP in 
> some fashon or another, however the documentation seems very sparce, 
> and information on the net seems very fragmented and contradictory in
areas.
> 
> My primary questions at this point:
> 
> What schema(s) does the latest AutoFS support?  Does it support 
> standards such as NisMap?  (I've found both "yes" and "no" answers to 
> this on the net, and no details in either)
> 
> How are maps entered in such schema?
>
The current stable version of autofs (4.1.4) does support nis.schema and
autofs.schema. With the nis.schema, entries must have objectclass
"nisObject"; the relevant attributes are "cn" (the mount point, as in
the second argument of the mount command) and "nismapentry" (the
"automount information": options and first argument of the mount
command).

If you need greater flexibility (want to use a different schema), or if
you need to authenticate to the LDAP server: there is a patch for
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

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

-----------------------------------------
Anadarko Confidentiality Notice:  
This electronic transmission and any attached documents or other
writings are intended only for the person or entity to which it is
addressed and may contain information that is privileged, confidential
or otherwise protected from disclosure.  If you have received this
communication in error, please immediately notify sender by return
e-mail and destroy the communication. Any disclosure, copying,
distribution or the taking of any action concerning the contents of
this communication or any attachments by anyone other than the named
recipient is strictly prohibited.
