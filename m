From: "jehan.procaccia" <jehan.procaccia@int-evry.fr>
Subject: Re: Autofs + LDAP + STARTTLS
Date: Mon, 31 Jan 2005 21:36:02 +0100
Message-ID: <41FE96B2.4070602@int-evry.fr>
References: <87hdkxe6jp.fsf@tango.dre.vanderbilt.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <87hdkxe6jp.fsf@tango.dre.vanderbilt.edu>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Krishnakumar B <kitty@dre.vanderbilt.edu>
Cc: autofs@linux.kernel.org

Krishnakumar B wrote:

>Hi,
>
>Is there any configuration option that I can use to make autofs execute a
>STARTTLS request before it tries to search the LDAP directory?  I have
>enabled searching the RootDSE in my access control list.  So it should be
>possible for a DUA to get information about
>
>supportedExtension: 1.3.6.1.4.1.1466.20037
>
>and then STARTTLS.  But I am unable to get
>/usr/lib/autofs/autofs-ldap-auto-master to talk to my LDAP server at all if
>I enable
>
>security ssf=1
>
>in /etc/openldap/slapd.conf (openldap-2.2.13, RHEL 3, autofs-4.1.3-47).  Is
>this a known problem?  Is there some configuration setting, patch or fixed
>version of autofs that supports STARTTLS?
>
>-kitty.
>
>  
>
I didn't tried it (autofs with TLS) but I know that autofs reads ldap 
configuration in /etc/openldap/ldap.conf on redhat config! not 
/etc/ldap.conf , did you put a TLS_CACERT directive in 
/etc/openldap/ldap.conf ?
