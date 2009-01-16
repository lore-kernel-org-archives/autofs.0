From: Ondrej Valousek <webserv@s3group.cz>
Subject: auto.master in ldap + simple bind
Date: Fri, 16 Jan 2009 15:54:30 +0100
Message-ID: <49709FA6.1040203@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi all,
I am trying to configure autofs (RHEL 5.2) to gather all maps from
Active Directory using simple bind using proxy user.
I have already managed to configure the PADL nss switch to do so using this:

host 192.168.60.172
base dc=ad,dc=s3group,dc=cz
binddn cn=ldapproxy,cn=Users,dc=ad,dc=s3group,dc=cz
bindpw password

Now I am wondering how to do the same with the automounter. Does anyone
know?
I see lots of options on how to configure TLS or SASL, but I just need a
simple bind.
Many thanks,

Ondrej
