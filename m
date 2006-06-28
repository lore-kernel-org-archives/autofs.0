From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: autofs5: unable to locate ldap master map
Date: Wed, 28 Jun 2006 11:59:45 +0200
Message-ID: <44A25311.2040501@inria.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@linux.kernel.org>

I just tested autofs5 (beta5), and I'm a bit confused about using
LDAP-defined master map... Especially when eveything worked out of the
box with autofs 4 :)

First, how the master map is located is still a bit obscure for me...
From the man page, it seems they are two different way to find it:
- file based
- nss based
The first occurs when automount argument or default value for this
argument is an explicit filename, the second occurs otherwise

nss-based master map lookup use the line 'automount' in
/etc/nsswitch.conf, and may use at least the following values (from
autofs4 init script):
- file
- ldap
- nis

Explanations about how behave each of those option is missing, but I
expect ldap value to behave as previously, meaning automagically using
openldap libraries.

So, to use a an ldap master map, I could either
1) used file-based master map lookup, by using "/usr/sbin/automount
/etc/autofs/auto.master" (or just "/usr/sbin/automount" as it is the
default value), and insert something as:
+ldap:ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr

2) using nss-based master map lookup, by using "/usr/sbin/automount
name-without-path", and insert a "ldap" value in "automount" line in
"/etc/nsswitch.conf"

However, the only way I found to force nss-based master map lookup was
"/usr/sbin/automount +auto.master" (where description says: name has no
 path), or to add +auto.master in auto.master file (where documentation
says: + [map-type,format:]map[options]) and use file-based lookup.

Second, searching master map in ldap doesn't work either, and I'm unable
to understand why:
- what is supposed to happen in the absence of autofs_ldap_auth.conf ?
- what are configuration options available there, beyond the one given
in example (ssl or just tls, for instance) ?
- what are precedence with system configuration for openldap libraries ?
- are the various variables defined in /etc/sysconfig/autofs mandatory,
or are they just alternate default values ?
- are they supposed to be exported in environment before launching
automount, passed to it through a bunch of -Dkey=value ?

The only hints I was able to collect were those error messages in the logs:
Jun 28 11:45:13 alceste automount[4191]: get_server_SASL_mechanisms: No
SASL authentication mechanisms are supported by the LDAP server.
Jun 28 11:45:13 alceste automount[4191]: lookup_init: lookup(ldap):
cannot initialize auth setup

If this matter, I build autofs with --with-mapdir=/etc/autofs as
argument, on x86_64 running mandriva cooker. And i'm running a 2.6.17
kernel.

Thanks for your help.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
