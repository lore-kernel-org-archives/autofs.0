From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 duplicate entries
Date: Tue, 14 Aug 2007 16:44:33 +0800
Message-ID: <1187081073.4963.3.camel@raven.themaw.net>
References: <46A747E0.7070202@math.uni-muenster.de>
	<C9AD2899A176C0499022697035E7625A19CC01@houmbx5.anadarko.com>
	<1185529315.3203.61.camel@raven.themaw.net>
	<46A9C4BB.6090208@math.uni-muenster.de>
	<1185549408.3203.64.camel@raven.themaw.net>
	<C9AD2899A176C0499022697035E7625A19CC2B@houmbx5.anadarko.com>
	<46C06FD2.3030500@math.uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46C06FD2.3030500@math.uni-muenster.de>
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
To: Nail El-Sourani <sourani@math.uni-muenster.de>
Cc: autofs@linux.kernel.org, "Wolfe, Allan" <Allan.Wolfe@anadarko.com>

On Mon, 2007-08-13 at 16:50 +0200, Nail El-Sourani wrote:
> Hi there,
> 
> I was just wondering if there are any news on this regarding autofs5?

I haven't done any work on this so far.
I'll review the posts again and give it some more thought.

> 
> Thanks,
> *nail
> 
> Wolfe, Allan wrote:
> > Ian.  Here is some information that might help.  I have worked with the
> > Sun Directory service and is running in our production environment.  I
> > am getting to know OpenLDAP and am studying the practical differences
> > between the two these days. We are a Solaris, Linux, HP-UX shop with
> > Solaris and Linux distributed in a networked desktop environment.  
> > 
> > As you probably already know, there is the IETF RFC2307 that was adopted
> > in the late 90's.  A revised "RFC2307bis" was submitted in 2002.  It was
> > never formally adopted (that I could ever see and now no longer is
> > accessible at the IETF). Sun had incorporated the additional
> > attributes/objects interjected, namely the attributes "automountKey" and
> > "automountInformation" used by objectclass "automount" in both the
> > client (NSS LDAP lib) and their directory server.
> > 
> > The OpenLDAP server base supports RFC2307, not RFC2307bis.  RedHat,
> > though, supplies a permutation of a schema definition to support the
> > "automount" extension of the RFC2307bis.  Both Sun and OpenLDAP both
> > include the "RFC2307" nisMap and nisObject and are defined consistently
> > between the two.  Historically for us, the "nisObject" objectclass were
> > used in our installation for automounter support, since it provided
> > consistency in deployment and Solaris had good support for attribute
> > mapping.  (If I remember correctly, on Linux we initially implemented
> > autofs v3.x and attribute mapping was not supported then -- I could be
> > wrong here).  We could support a "single line entry" in an automount map
> > without having to "duplicate entries" by supporting both sets of
> > objectclasses.
> > 
> > There are differences in the way the "key attributes" are defined.  To
> > define a "nisObject", the "cn" is required.  "cn" is a multi-value, case
> > insensitive attribute (UTF-8 DirectoryString -- EQUALITY
> > caseIgnoreMatch, SUBSTR caseIgnoreSubstringsMatch).  "automountKey" is
> > case sensitive and is a single-value attribute (IA5String -- EQUALITY
> > caseExactIA5Match).  Technically, by definition, the "cn" should lend to
> > case sensitivity issues, though queried, will deliver a case oriented
> > result.  Sun apparently took the technically precise approach and worked
> > around this dilemma (or some would argue they introduced it) by
> > delimiting upper case letters with the % sign in order to read a "cn"
> > mapped value and precisely understand its case sensitivity no matter how
> > it is delivered.
> > 
> > On Solaris, only the case defined definition appears as the mount.  I
> > guess they have programmed around receiving multiple values for an
> > attribute and adopts the one if the % sign is used in one of the values.
> > Over RHEL3/autofs 4.1.x, there is a mount per "cn" received.  One with
> > case sensitivity, one with the delimiters included.  Not elegant, but
> > the case sensitive path is preserved between platforms for the benefit
> > of the common applications running cross-platform.  Both mounted paths
> > are accessible as mounted.
> > 
> > With the above said, as a side note, the RedHat supplied schema (Fedora
> > 7) included in their packaged OpenLDAP server uses "cn" as the key in
> > the "automount" objectclass definition rather than the RFC2307bis
> > "automountKey".  Jeff would probably be able to interject some insight
> > why.  The mainstream version may not be, in fact, defined that way.
> > 
> > I hope this helps.
> > 
> > 
> > 
> > -----Original Message-----
> > From: Ian Kent [mailto:raven@themaw.net] 
> > Sent: Friday, July 27, 2007 10:17 AM
> > To: support@math.uni-muenster.de
> > Cc: Wolfe, Allan; autofs@linux.kernel.org
> > Subject: Re: [autofs] autofs5 duplicate entries
> > 
> > On Fri, 2007-07-27 at 12:11 +0200, Nail El-Sourani wrote:
> >> Hi Ian,
> >>
> >> since you asked for documentation on this issue, see the sourcecode of
> > 
> >> the solaris automounter here:
> > 
> > No, I won't be looking at Copyrighted source, sorry.
> > External documentation or behavioral reports only thanks.
> > 
> >> http://src.opensolaris.org/source/xref/pef/phase_I/usr/src/cmd/fs.d/au
> >> tofs/ns_ldap.c
> >>
> >> line 976 ++
> >>
> >> as can be seen the % apply to the character following. JaVa would be 
> >> queried for as %Ja%Va. Seems to be the solaris automounter not ldap 
> >> retaining the case sensitivity.
> > 
> > Yes, I'll think about this but multiple key values is still illegal from
> > my point of view, so we will see what further discussion brings.
> > 
> >> i will try the patch u sent me shortly and report back if it helped.
> >>
> >> *nail
> >>
> >> Ian Kent wrote:
> >>> On Wed, 2007-07-25 at 09:48 -0500, Wolfe, Allan wrote:
> >>>> To add a comment here. . .  The extra cn is for the benefit for 
> >>>> Solaris that requires the percent sign to qualify for the capital 
> >>>> letter in the string.  We will have to contend with the same issue 
> >>>> as we move toward autofs version 5.
> >>> OK, since the NIS schema isn't case sensitive, right.
> >>>
> >>> I know only what I need to know about LDAP and so I don't know what 
> >>> the % is supposed to do. Perhaps some of the LDAP folks here can
> > help.
> >>> Does it allow LDAP to retain the case sensitivity in a case 
> >>> insensitive attribute or does Solaris autofs do that bit?
> >>> Does the % apply to the whole entry or just the character following
> > it?
> >>> Never the less I think it's wrong to allow multiple keys for a mount
> > 
> >>> entry since the key is supposed to be unique.
> >>>
> >>>> -----Original Message-----
> >>>> From: autofs-bounces@linux.kernel.org 
> >>>> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Nail 
> >>>> El-Sourani
> >>>> Sent: Wednesday, July 25, 2007 7:54 AM
> >>>> To: autofs@linux.kernel.org
> >>>> Subject: [autofs] autofs5 duplicate entries
> >>>>
> >>>> hi everyone,
> >>>>
> >>>> i seem to have a problem with autofs+ldap on duplicate entries. i 
> >>>> migrated from autofs4 settings over to autofs5 quite successfully 
> >>>> and in general everything seems to work fine. ill give u a working 
> >>>> and nonworking example.
> >>>>
> >>>>
> >>>> auto.master contains:
> >>>> /share  ldap:nisMapName=auto_packages,ou=ivv5,dc=de -nosuid
> >>>>
> >>>> ldap queries on the path to automount give me:
> >>>>
> >>>> ldapsearch -x -LLL cn=java
> >>>>
> >>>> working:
> >>>> objectClass: nisObject
> >>>> objectClass: top
> >>>> cn: Java
> >>>> nisMapEntry: ...
> >>>> nisMapName: auto_package...
> >>>>
> >>>> like the above, the autofs5 mounts with no problem.
> >>>>
> >>>> but this one, not working:
> >>>> objectClass: nisObject
> >>>> objectClass: top
> >>>> cn: Java
> >>>> cn: %Java
> >>>> nisMapEntry: ...
> >>>> nisMapName: auto_package...
> >>>>
> >>>> gives in /var/log/messages a
> >>>>
> >>>> Jul 25 14:22:45 SEMTEX automount[4872]: attempting to mount entry 
> >>>> /share/java Jul 25 14:22:45 SEMTEX automount[4872]: lookup_one:
> >>>> lookup(ldap): key Java has duplicate entries Jul 25 14:22:45 SEMTEX
> >>>> automount[4872]: failed to mount /share/java
> >>>>
> >>>> As I believe, there seems to be a Problem with cn:Java and cn:%Java
> > 
> >>>> somehow. As I understand the % seems to be there to enable both 
> >>>> upper-and lowercase typing (java, Java) when entering the Path on 
> >>>> the commandline (cd /share/Java, /share/java). Anyhow. in autofs4 
> >>>> this didnt seem to be a problem.
> >>>>
> >>>> Any help would be appreciated.
> >>>>
> >>>> *nail
> >>>>
> >>>> _______________________________________________
> >>>> autofs mailing list
> >>>> autofs@linux.kernel.org
> >>>> http://linux.kernel.org/mailman/listinfo/autofs
> >>>> -----------------------------------------
> >>>>
> >>>> Anadarko Confidentiality Notice:  
> >>>> This electronic transmission and any attached documents or other 
> >>>> writings are intended only for the person or entity to which it is 
> >>>> addressed and may contain information that is privileged, 
> >>>> confidential or otherwise protected from disclosure.  If you have 
> >>>> received this communication in error, please immediately notify 
> >>>> sender by return e-mail and destroy the communication. Any 
> >>>> disclosure, copying, distribution or the taking of any action 
> >>>> concerning the contents of this communication or any attachments by
> > 
> >>>> anyone other than the named recipient is strictly prohibited.
> >>>>
> >>>> _______________________________________________
> >>>> autofs mailing list
> >>>> autofs@linux.kernel.org
> >>>> http://linux.kernel.org/mailman/listinfo/autofs
> >>> _______________________________________________
> >>> autofs mailing list
> >>> autofs@linux.kernel.org
> >>> http://linux.kernel.org/mailman/listinfo/autofs
> > 
> > -----------------------------------------
> > 
> > Anadarko Confidentiality Notice:  
> > This electronic transmission and any attached documents or other
> > writings are intended only for the person or entity to which it is
> > addressed and may contain information that is privileged,
> > confidential or otherwise protected from disclosure.  If you have
> > received this communication in error, please immediately notify
> > sender by return e-mail and destroy the communication. Any
> > disclosure, copying, distribution or the taking of any action
> > concerning the contents of this communication or any attachments by
> > anyone other than the named recipient is strictly prohibited.
> > 
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
