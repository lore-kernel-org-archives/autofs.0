From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: problem with autofs
Date: Tue, 07 Nov 2006 08:44:41 -0500
Message-ID: <x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	(Syed Khader's message of "Mon, 6 Nov 2006 22:20:20 +0530")
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] problem with autofs; "Syed Khader" <syedk@google.com> adds:

syedk> Hello Evrybuddy,
syedk> I had configured Openldap and succesfully configured for authentication of
syedk> users.I'm facing problem with autofs.

syedk> I'm using Rhel4.When i say service autofs start it says

syedk> No mount points defined.

syedk> I have written the correct entries in /etc/exports file.

syedk> I have sucessfully mounted directories using /etc/auto.master and
syedk> indirect maps on the client side But when i'm using the ldap maps
syedk> it's giving me problems How can i make my autofs service to read the
syedk> auto.master from LDAP Ou= auto.master.

syedk> I have changed in the /etc/nsswitch.conf file to Automount: ldap but
syedk> no use

syedk> when i use service autofs start it says "No mountpoints defined".

syedk> Are they any bugs with RHEL4?

Bugs?  In software?  Nooo, none here.  ;)

syedk> Or am i going wrong somewhere?

Since you can authenticate users using ldap, I'm guessing that your
/etc/openldap/ldap.conf file points to the right server with the right base
DN.  If that is the case, then we'll need to see the ldif for your master
map, as Ian noted in his reply.

What version of autofs are you using?  What LDAP schema are you using?

-Jeff
