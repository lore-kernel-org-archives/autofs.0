From: Thorild Selen <thorild@Update.UU.SE>
Subject: Re: Proposal for map refresh logic
Date: Sun, 23 May 2004 05:19:01 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <x3kisen25lm.fsf@Psilocybe.Update.UU.SE>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
	<Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
	<Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
	(raven@themaw.net's message of "22 May 04 04:37:32 GMT")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

raven@themaw.net writes:
> I'm aware of the NIS order number but don't have an idea of how this ca=
n=20
> be done for LDAP maps. I want the handling to remain as consistent as=20
> possible between map types. This will be an advantage when I add=20
> ghosting of nis+ maps.

With servers that use the modifyTimestamp and createTimestamp
operational attributes (these SHOULD be set when an object is added or
changed, according to RFC 2252), these could be used to detect if any
entry has been changed or added since last time you checked. However,
this would fail to detect any removed entries.

What you really want is probably something like lcup ("LDAP Client
Update Protocol",
<URL:http://www.ietf.org/internet-drafts/draft-ietf-ldup-lcup-06.txt>)
or ldapsync ("The LDAP Content Synchronization Operation",
<URL:http://www.ietf.org/internet-drafts/draft-zeilenga-ldup-sync-05.txt>=
),
which both address this problem. It appears that recent versions of
OpenLDAP support ldapsync, but neither solution is even close to
de-facto standard status.

For some years to come, any useful and portable implementation would
need to support the case where there are no timestamps and no cool
synchronization operations to help you, I'm afraid.


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
