From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs TLS and binddn/bindpw patch.
Date: Mon, 4 Apr 2005 10:44:28 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504041029450.27508@wombat.indigo.net.au>
References: <424B6F70.8060802@ad2u.gr>
	<Pine.LNX.4.62.0504031757570.1663@donald.themaw.net>
	<424FF392.6070300@ad2u.gr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <424FF392.6070300@ad2u.gr>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mzozd <mzozd@ad2u.gr>
Cc: autofs@linux.kernel.org, root@ad2u.ath.cx

On Sun, 3 Apr 2005, mzozd wrote:

> Dear Raven,
> 
> please DISREGARD MY PREVIOUS PATCH. I have created two seperate patches
> to address this issue more seriously.
> 
> I am attaching the patches in this e-mail and i am going to give you a
> short explanation of what is changed and why:
> 
> The problem is that if an ldap server is NOT allowing anonymous binds,
> there is no way for autofs to acquire the information from the autofs
> schema in ldap. Thus, it is also impossible to query for the schema if
> the ldap server ENFORCES a TLS only authenticatiion.
> 
> The attached two patches address that issue by doing the following:
> 
> a) Open /etc/ldap.conf to read any rootbinddn option.
> b) Open /etc/ldap.secret to read any password if the rootbinddn option
> is in the conf.
> c) Try to initiate TLS with the server (assuming the path to the
> certifacte(s) is defined in /etc/openldap/ldap.conf).

We shouldn't need care about the certificate. This should be taken care of 
with an API call either succeeding or failing.

> d) Bind with rootdn and password defines in the configuration files.

All this stuff is openldap specific.

Can we do this via an LDAP API?
How much of this can be done using a generalised dn?

This may already be the case as I haven't had a look yet but can we 
seperate out the LDAP implementation specific stuff to a seperate module?

> 
> I have successfully tested this patch with the latest autofs and
> openldap autofs schema and it works. It may be needed some minor
> adjustments. I have tried, and as far as i tested succeed, to maintain
> the previous behaviour of the program but other people should verify
> that via testing.

I have another patch that generalises the dn format and cleans up the LDAP 
module. It looks quite good but is very much out of date. The LDAP module 
is quite ugly and certainly needs work.

It's going to be quite a big job to merge these patches. Hopefully 
we can work together on this.

Ian
