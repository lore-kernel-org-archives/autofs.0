From: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Subject: Re: LDAP binding
Date: Wed, 13 Oct 2004 21:03:36 +0200 (CEST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410132057180.27709@uranos.quantum.physik.uni-potsdam.de>
References: <be4ff6020410130412116e1f1f@mail.gmail.com>
Reply-To: Timo.Felbinger@physik.uni-potsdam.de
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
To: autofs@linux.kernel.org


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

I don't know about simple bind with credentials; I've never tried that.
However if "SASL external" (ie, basically RSA public key authentication
via client certificates) would work for you as a client authentication
mechanism, I can confirm that it is possible to get this to work with
autofs. Since you are asking for TLS, your server is probably already
using server certificates to authenticate itself to the clients. I'm
currently configuring our clients to do essentially the reverse and use
the ssh_host_rsa_key (which every client has anyway) to authenticate
itself to the server.

I can post a patch if someone is interested, but I need to put some
more work into it to make it a little less ugly...

> also what is the status of autofs when it comes to using LDAPS instead
> over SSL/TLS instead of just standard ldap.

This part is already working fine and stable here.
I posted a link to a modified lookup_ldap module which can speak TLS a
little while ago (http://www.timof.qipc.org/autofs-4.1.3-patch).


Regards,

Timo Felbinger


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany
