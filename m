From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS problem with OpenLDAP server
Date: Wed, 26 Jul 2006 17:52:52 -0400
Message-ID: <x49ejw8hw3v.fsf@segfault.boston.redhat.com>
References: <44C7CF32.7030501@soe.ucsc.edu> <44C7DD86.5050900@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44C7DD86.5050900@soe.ucsc.edu> (Erich Weiler's message of
	"Wed, 26 Jul 2006 14:24:22 -0700")
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
To: Erich Weiler <weiler@soe.ucsc.edu>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] AutoFS problem with OpenLDAP server; Erich Weiler <weiler@soe.ucsc.edu> adds:

weiler> OK, I figured out that AutoFS looks at "/etc/openldap/ldap.conf" and NOT 
weiler> "/etc/ldap.conf".  I'm one step closer.  However, when I copy my 
weiler> ldap.conf over to /etc/openldap/ldap.conf, and do a "/etc/init.d/autofs 
weiler> start", it still gives me the:

weiler> Starting automount: No Mountpoints Defined

weiler> Error at the command line.  I *DO* see traffic to the Openldap server 
weiler> this time though, and in the OpenLDAP logs I see:

weiler> ber_scanf fmt ({mm}) ber:
weiler> ber_scanf fmt ({mm}) ber:
weiler>      filter: (&(?=undefined)(?=undefined))
weiler> ber_scanf fmt ({M}}) ber:
weiler>      attrs: automountMapName automountInformation
==> limits_get: conn=10642 op=6 dn="[anonymous]"
weiler> => bdb_search
weiler> bdb_dn2entry("dc=domain,dc=com")

weiler> So it looks like the automounter is searching for
weiler> "automountMapName" and "automountInformation".  Which is bad,
weiler> because my maps are in the form of "nisMapName" and "nisMapEntry".
weiler> Does anyone know if there is an easy way to tell the automounter to
weiler> look for the other attributes?  Or do I have to try to set up some
weiler> kind of aliasing on my OpenLDAP server?

The autofs init script in autofs v4 will invoke a command,
autofs-ldap-auto-master, to determine if there is an auto.master available
on your ldap server.  It should try 3 schemas before giving up.

You didn't mention whether you actually had an auto.master in ldap.  Do you?

-Jeff
