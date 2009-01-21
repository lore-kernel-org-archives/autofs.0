From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: auto.master in ldap + simple bind
Date: Wed, 21 Jan 2009 14:29:02 +0100
Message-ID: <4977231E.9090306@s3group.cz>
References: <49709FA6.1040203@s3group.cz>	
	<1232122347.3166.102.camel@zeus.themaw.net>	
	<1232168581.3072.0.camel@zeus.themaw.net>	
	<4608.82.208.2.231.1232305306.squirrel@webmail.s3group.com>	
	<1232332943.3136.28.camel@zeus.themaw.net>
	<4976ECB9.6090207@s3group.cz>	
	<1232542998.3931.37.camel@zeus.themaw.net>
	<49771F04.102@s3group.cz>
	<1232544158.3931.40.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232544158.3931.40.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

>
> What is the actual SASL user dn?
> Does your ldapsearch work without the -b option?
>
>   

With SASL, we do not talk about user DN, we talk about authentication ID
for SASL bind instead.
This is an example of ldapsearch that works for me against Win2k8:
ldapsearch -H ldap://192.168.60.172 -Y DIGEST-MD5 -U "ldapproxy" -w
1234proxy$ -b "cn=praguetest,cn=prague,dc=ad,dc=s3group,dc=cz"
objectClass=* cn objectClass nisMapName nisMapEntry
