From: raven@themaw.net
Subject: Re: LDAP binding
Date: Wed, 13 Oct 2004 23:08:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410132301350.8717@donald.themaw.net>
References: <be4ff6020410130412116e1f1f@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <be4ff6020410130412116e1f1f@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux user <linuxteam@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 13 Oct 2004, linux user wrote:

> Dear all,
> 
> We have Redhat Linux  clients that are migrating from NIS to LDAP
> using the RFC2307, the ldap server is a SUN ONE DS 5.1 which runing on
> a Solaris 8.0, The linux clients (different red hat releases 7.3,8.0,
> RHEL 2.1, and 3.0)
> 
> We could not do autofs lookups as they seem to be binding anonoumsly
> as seen from the log files, also from the code we can see that is the
> case as follows :
> 
> file modules/lookup_ldap.c:
>            ldap_simple_bind_s(ldap, NULL, NULL);   /*  LDAPv3 */
> 
> But in fact, according to the OpenLDAP header file (ldap.h):
>             ldap_simple_bind_s(LDAP *ld, char *who, char *passwd);
> 
> So, my question is would that be changed to bind using simple bind by
> passing the credniatls as seen in the configration files later on? the
> who, and the password in the above lookup_ldap.c function, as we do
> not have control over the ldap server as its run by different
> department, and they require us to do a simple bind passing
> credentials.

Possible. I don't have any sample code for grabing stuff from the config 
file. I hope this would be available within the LDAP api as we don't have 
any way of knowing where the config may be located.

> 
> also what is the status of autofs when it comes to using LDAPS instead
> over SSL/TLS instead of just standard ldap.

Drom what I've seen adding TLS support to the code is reasonably straight 
forward but again finding out if it's required and how, in a system 
independant manner is a problem. Additionally, there can be other 
related requirements for the exchange when using TLS.

Basically, I haven't looked into this at all yet.

Ian
