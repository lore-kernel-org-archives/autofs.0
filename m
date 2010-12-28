From: Ian Kent <ikent@redhat.com>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
	servers
Date: Tue, 28 Dec 2010 10:24:50 +0800
Message-ID: <1293503090.5923.2.camel@perseus>
References: <4D18885D.6010601@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D18885D.6010601@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Mon, 2010-12-27 at 13:36 +0100, Ondrej Valousek wrote:
> Hi Ian,
> 
> I just found out that when using DNS RRs to find a suitable ldapserver
> to connect to, we do not handle correctly the situation where the
> multiple servers are found. We end up with something like this:
> 
> automount[2712]: find_server: trying server uri
> ldap://dccorka.dublin.ad.s3group.com:389
> ldap://dclisaa.dublin.ad.s3group.com:389
> ldap://dcdub1.dublin.ad.s3group.com:389
> ldap://dcduba.dublin.ad.s3group.com:389
> ldap://dcdubb.dublin.ad.s3group.com:389
> ldap://dcpra1.dublin.ad.s3group.com:389
> ldap://dcsjc1.dublin.ad.s3group.com:389
> ldap://dcsjca.dublin.ad.s3group.com:389
> ldap://dcwro1.dublin.ad.s3group.com:389
> ldap://dccork1.dublin.ad.s3group.com:389
> 
> Looking at the source code, this uri does not look valid to me.
> Ok "man auto.master" says that LDAP_URI might contain "A space
> seperated list of server uris of the form <proto>://<server>[/]", but
> ldap_initialize() does not look like it actually supports this - a
> single server is assumed instead.

That's right.
I'm supposed to break that list into individual server entries and
attempt a connection to each in turn.

Can you get a debug log for me please.

> 
> Can you clarify this?
> 
> In my case above, if connection to
> ldap://dccorka.dublin.ad.s3group.com:389 fails, autofs never tries the
> other servers in the list.
> 
> Many thanks & happy new year!
> 
> Ondrej
> 
> 
> ______________________________________________________________________
> The information contained in this e-mail and in any attachments is
> confidential and is designated solely for the attention of the
> intended recipient(s). If you are not an intended recipient, you must
> not use, disclose, copy, distribute or retain this e-mail or any part
> thereof. If you have received this e-mail in error, please notify the
> sender by return e-mail and delete all copies of this e-mail from your
> computer system(s). Please direct any additional queries to:
> communications@s3group.com. Thank You. Silicon and Software Systems
> Limited. Registered in Ireland no. 378073. Registered Office: Whelan
> House, South County Business Park, Leopardstown, Dublin 18 
> 
> ______________________________________________________________________
> 
