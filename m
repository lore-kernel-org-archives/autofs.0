From: Ian Kent <raven@themaw.net>
Subject: Re: nesting automount maps in ldap
Date: Sat, 18 Jun 2011 18:26:48 +0800
Message-ID: <1308392808.12881.20.camel@perseus.themaw.net>
References: <4DFB6745.3040805@phy.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=nuoCjFKfq8T+LLI1w5Ffak4+Trw=;
	b=o22f4Fu0GBfSYUPHUTHKHWG4WC0uHquYADXGQyNbt1xd58wm5CG+k6rkkH88jxH8OYEazl5Sv+BFrblbwdv98z7FBSJHGKcaQXNKdZ+9lfqOitRaYLCC6Y3QL00bidqItTY9+VbpShyLoXGuxD1U66IZr+PCbZ+O1URvni62dNY=
In-Reply-To: <4DFB6745.3040805@phy.duke.edu>
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

On Fri, 2011-06-17 at 10:40 -0400, Jimmy Dorff wrote:
> Hello,
> 
> I'm attempting to migrate an existing (and working) nis automount system 
> to ldap. We have several layers of nested maps and I'm attempting to 
> recreate that in LDAP.
> 
> # Automount master for "/foo"
> dn: cn=/foo, ou=auto.master,dc=phy,dc=duke,dc=edu
> objectClass: automount
> cn: /foo
> automountInformation: ldap ldapserver:ou=auto.phy,dc=phy,dc=duke,dc=edu
> 
> dn: ou=auto.phy, dc=phy,dc=duke,dc=edu
> objectClass: top
> objectClass: automountMap
> ou: auto.phy
> 
> # mounting "/foo/web" works great!
> dn: cn=web, ou=auto.phy, dc=phy,dc=duke,dc=edu
> objectClass: automount
> cn: web
> automountInformation: -fstype=nfs nfsserver01:/srv/httpd
> 
> # here is my attempt at nesting another level
> dn: cn=project, ou=auto.phy,dc=phy,dc=duke,dc=edu
> objectClass: automount
> cn: project
> automountInformation: ldap ldapserver:ou=auto.project,dc=phy,dc=duke,dc=edu

I'm not sure about using this older syntax.
Even if it is correct and we find a bug with it I'd be inclined to
recommend using the newer syntax if possible.

That would be (IIRC):
automountInformation: ldap://ldapserver/ou=auto.project,dc=phy,dc=duke,dc=edu

> 
> # This fails. I get "automount: failed to mount /foo/project
> dn: ou=auto.project, dc=phy,dc=duke,dc=edu
> objectClass: top
> objectClass: automountMap
> ou: auto.project
> 
> # this never shows up (ghosting enabled)
> dn: cn=linux, ou=auto.project, dc=phy,dc=duke,dc=edu
> objectClass: automount
> cn: linux
> automountInformation: -fstype=nfs nfsserver02:/srv/linux
> 
> I can't see to find an example of nest ldap maps. I'm using 
> autofs-5.0.5-31.el6 if that makes any difference.

Log a RHEL bug (you probably should go via support actually) and include
a full debug log.

That is set LOGGING="debug" in /etc/sysconfig/autofs "and" ensure that
daemon.* output is being captured by syslog.

> 
> Thanks!
> Jimmy Dorff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
