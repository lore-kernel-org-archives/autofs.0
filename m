From: Ian Kent <raven@themaw.net>
Subject: Re: nesting automount maps in ldap
Date: Sat, 18 Jun 2011 18:30:32 +0800
Message-ID: <1308393032.12881.24.camel@perseus.themaw.net>
References: <4DFB6745.3040805@phy.duke.edu>  <4DFBBBD1.3020504@phy.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=tZ36sqgdsJcnzG3cOqb9FCGXm6A=;
	b=cJmToD7hccMWMoki99oipukogfDMrZnIa0wt42zlw9G+BU8nDTawHvD2f1R2GeHzLkMXCNPBIsGLjCZXFjaMy08TaUkCO8EVLAM4/wdFB3XOxd6KOOZFMrL0EvNGjAYQic6jWDOwY0k/0GwhN0TiKRWv7OpFnRaZIL0F6mpwXwU=
In-Reply-To: <4DFBBBD1.3020504@phy.duke.edu>
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
To: Jimmy Dorff <jdorff@phy.duke.edu>
Cc: autofs@linux.kernel.org

On Fri, 2011-06-17 at 16:40 -0400, Jimmy Dorff wrote:
> On 06/17/2011 10:40 AM, Jimmy Dorff wrote:
> > # here is my attempt at nesting another level
> > dn: cn=project, ou=auto.phy,dc=phy,dc=duke,dc=edu
> > objectClass: automount
> > cn: project
> > automountInformation: ldap ldapserver:ou=auto.project,dc=phy,dc=duke,dc=edu
> 
> My problem was the lack of "-fstype=autofs".

Oh .. yeah, that may well be it, but that should have been needed in the
original map. Maybe a look at a debug log would be useful and that
should show pretty quickly if it is just the missing fstype option.

> 
> This works:
> dn: cn=project,ou=auto.phy,dc=phy,dc=duke,dc=edu
> objectClass: automount
> cn: project
> automountInformation: -fstype=autofs ou=auto.project,dc=phy,dc=duke,dc=edu
> 
> I also think this is called "layering" rather than "nesting".. but I'm 
> not sure.

Maybe, but the terminology I've always used for these is "submount", as
in a sub autofs mount.

Ian
