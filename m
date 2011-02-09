From: "Wolfe, Allan" <Allan.Wolfe@anadarko.com>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
	servers
Date: Wed, 9 Feb 2011 08:57:29 -0600
Message-ID: <AE70589A6589BA448AC7222D2428F8DE792AE7@houmsmsgexg001.anadarko.com>
References: <4D18885D.6010601@s3group.cz>
	<1293503090.5923.2.camel@perseus><4D21A19D.3050303@s3group.cz>
	<1294297764.3010.8.camel@perseus><4D2581F0.8020607@s3group.cz>
	<1294322864.2852.3.camel@perseus><4D27115A.9010805@s3group.cz>
	<4D496CF9.5040001@s3group.cz><1297137397.10090.4.camel@perseus>
	<4D5109EF.7040800@s3group.cz> <1297223424.2771.7.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1297223424.2771.7.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

A copy of the RFC for LDAP URI formatting can be found at
http://www.faqs.org/rfcs/rfc2255.html it documents how the URI should be
constructed/interpreted.

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
Sent: Tuesday, February 08, 2011 9:50 PM
To: Ondrej Valousek
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] autofs misbehaves when DNS RRs returns more ldap
servers

On Tue, 2011-02-08 at 10:16 +0100, Ondrej Valousek wrote:
> 
> > Yes, and replied on the 11/01, did you miss it?
> > 
> Ok I must have missed it - now I see you have taken a different 
> approach - you are constructing a single looong string with all ldap 
> uris and then you parse them again.
> I must say I do not like it too much as:
> a) it is wasted effort (merging together and then splitting again)
> b) potentially can ldap uri contain spaces I think

Don't think so, in this case anyway.

The uris used here aren't full uris, they can only have the proto, host
name and port. AFAIK, host names can't have spaces in them yet.

> 
> But if you like it more, I am fine with it, too.

Yeah, your points above are well taken but had already been done and
committed to the repo so to change would be more work with the potential
for mistakes.

Ian


_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

Anadarko Confidentiality Notice: This electronic transmission and any 
attached documents or other writings are intended only for the person 
or entity to which it is addressed and may contain information that is 
privileged, confidential or otherwise protected from disclosure. If you 
have received this communication in error, please immediately notify 
sender by return e-mail and destroy the communication. Any disclosure, 
copying, distribution or the taking of any action concerning the contents 
of this communication or any attachments by anyone other than the 
named recipient is strictly prohibited.
