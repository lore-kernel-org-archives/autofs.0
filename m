From: mzozd <mzozd@ad2u.gr>
Subject: Re: Autofs TLS and binddn/bindpw patch.
Date: Mon, 04 Apr 2005 23:03:14 +0100
Message-ID: <4251B9A2.8070400@ad2u.gr>
References: <424B6F70.8060802@ad2u.gr>
	<Pine.LNX.4.62.0504031757570.1663@donald.themaw.net>
	<424FF392.6070300@ad2u.gr>
	<Pine.LNX.4.58.0504041029450.27508@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504041029450.27508@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, root@ad2u.ath.cx

Ian Kent wrote:
> On Sun, 3 Apr 2005, mzozd wrote:
>>
>>a) Open /etc/ldap.conf to read any rootbinddn option.
>>b) Open /etc/ldap.secret to read any password if the rootbinddn option
>>is in the conf.
>>c) Try to initiate TLS with the server (assuming the path to the
>>certifacte(s) is defined in /etc/openldap/ldap.conf).
> 
> 
> We shouldn't need care about the certificate. This should be taken care of 
> with an API call either succeeding or failing.
That is exactly what the patch does. the start_tls function is taking
care of the certificate. The current patches interact with
/etc/ldap.conf(pam/nss_ldap conf file) and NOT /etc/openldap/ldap.conf.
Sorry if i didn't put it right. In my point of view it was obvious that
the patch was not doing any "library" work.
> 
> 
>>d) Bind with rootdn and password defines in the configuration files.
> 
> 
> All this stuff is openldap specific.
> 
> Can we do this via an LDAP API?
There is no ldap library, as far as i know, capable of parsing the
config file. Other programs (like sudo) use the same approach.

> How much of this can be done using a generalised dn?
The patch is parsing the /etc/ldap.conf file in order to find any user
supplied DN and /etc/ldap.secret for the password. What do you mean
generalised dn?

> 
> This may already be the case as I haven't had a look yet but can we 
> seperate out the LDAP implementation specific stuff to a seperate module?
It is already seperated. Any further changes suggest major rewrite for
the autofs module. autofs has to query TWICE (three times actually
including the ldap bind test) the ldap server in order get 1) the autofs
ldap auto master entries(via /usr/lib/autofs-ldap-auto-master) and 2)
retrieving the e.g ldap auto.home entries via automount daemon.
> 
> 
> 
> I have another patch that generalises the dn format and cleans up the LDAP 
> module. It looks quite good but is very much out of date. The LDAP module 
> is quite ugly and certainly needs work.
Please, supply a url where i can see that patch.
> 
> It's going to be quite a big job to merge these patches. Hopefully 
> we can work together on this.
We can try to work together on that. What troubles me, is the enormous
number of patches available at the autofs directory. What is the policy
for patching autofs ?

Please note:
Me, and other people using CRUX, are already using this patch with no
problems.

Thank you for your reply,

MzOzD
> 
> Ian
> 
> 
