From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Re: AutoFS problem with OpenLDAP server
Date: Wed, 26 Jul 2006 17:46:23 -0700
Message-ID: <44C80CDF.60206@soe.ucsc.edu>
References: <44C7CF32.7030501@soe.ucsc.edu> <44C7DD86.5050900@soe.ucsc.edu>
	<x49ejw8hw3v.fsf@segfault.boston.redhat.com>
	<44C7EA7A.6060304@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44C7EA7A.6060304@soe.ucsc.edu>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Somehow I feel I didn't send this correctly last time, resending:

Hi Jeff,

 > The autofs init script in autofs v4 will invoke a command,
 > autofs-ldap-auto-master, to determine if there is an auto.master 
available
 > on your ldap server.  It should try 3 schemas before giving up.
 >
 > You didn't mention whether you actually had an auto.master in ldap. 
Do you?

No, I don't have an auto.master in LDAP, I guess I was figuring Linux's 
AutoFS would kind of figure it out like it does with Solaris.  So AutoFS 
requires a auto.master in LDAP?  Do you know what I need to do to tweak 
this by any chance?  Or maybe point me to a how-to or something of that 
nature?

Thanks for the response!

ciao, erich
