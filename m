From: Ian Kent <raven@themaw.net>
Subject: Re: Using autofs with Active directory
Date: Wed, 4 Oct 2017 10:21:26 +0800
Message-ID: <9ff859d3-505b-98ce-b70b-117d133ec196@themaw.net>
References: <20171002192855.554d1e3a@devstation.samdom.example.com>
 <49527a45-8ba3-f9d1-30b9-8906dc8c19c4@themaw.net>
 <20171003155557.39eb1396@devstation.samdom.example.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=mueEuDKq1Vfg1VdKzq
        0n4MI2LjOdXhHJGULyAyBQo3w=; b=eBGBoQPykV56GDAUEQE6ue6PvsQqbH+LF5
        cgVTmVgBCuiXj29zFIn6JtLCQdrGEoHmJUZlYWwyIk3MN6ljMOXESp87vRt4++pb
        61fEzmBHmNG9w+Eo3M+pdpJaval4abVg4YV6kwkd2lHrVkAYLLBW/FfTaTmT/v49
        amM1xXmzkCNxNGHA7nJbSb3NlKOtPI3STfijmIo26QLn4NH78pOBIMYpc0RQ3uDJ
        thyt4RZ+CAXq06IZXq3uDeoNJT6S6PWUxLo/N6bEoTQA0/vZ8mNUfqEH/XtX351f
        CsKKyNuRaE/U4OxQtBsshlQ+CXJtKQ5okI3Vh0mKdKN0qzzGF4+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=mueEuDKq1Vfg1VdKzq0n4MI2LjOdXhHJGULyAyBQo3w=; b=W1u3VNRe
        m69VSw+F4dZmRjytbCG/22e5YqP74bE+kxejgDdPckVgS5aMovRRk4UxBg3bUXtK
        curk/SAAT+FqJXP+oEmNE7vPRsGhLECTzpyfP1NNoe2z5qQDc07VEBwlkoTznzVI
        2wyD4RcmDf+6dKuTO5DXti29KVPYp4u/2DamzDTmAUXHZDbWynpGupxqg7bT45tf
        ZANRqEefc2h5+KvcyWA0YqatuiHaXkjlpVKtGxja7uG7PrsOuPn4u/GzDvrv5/ai
        D6zePmijG7L/tU6cIIUp68geRv6z22AXmI4JiGAeCImiFhLrJ0uuGJQ+9DHDXq+/
        mJO/FXaPCgVQ0w==
In-Reply-To: <20171003155557.39eb1396@devstation.samdom.example.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rowland Penny <rpenny@samba.org>, autofs@vger.kernel.org

On 03/10/17 22:55, Rowland Penny wrote:
> On Tue, 3 Oct 2017 14:13:02 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
>> On 03/10/17 02:28, Rowland Penny wrote:
>>>
>>> Hi, I hope this is the right place to send this to, but if not, can
>>> you advise just where I should send it to ;-)
>>>
>>>
>>> I am trying to get Automount to work with a Samba AD DC and I am
>>> struggling. I think I might have read just about everything there
>>> is on the internet, but there isn't much for using Autofs with ldap
>>> and even less about AD.
>>
>> Yes, that is true but to change that would we would need input from
>> people using this functionality.
> 
> If I can get this to work, I will put something on the Samba wiki.
> 
> 
>>
>> Looks ok although I'm not sure about using CN, a case insensitive
>> attribute.
> 
> Everything is case insensitive on windows ;-)
> 
>>
>>>
>>>
>>> Set /etc/default/autofs to this:
>>>
>>> USE_MISC_DEVICE="yes"
>>> #OPTIONS=""
>>> MASTER_MAP_NAME="ldap:ou=auto.master,ou=automount,dc=example,dc=com"
>>> #MASTER_MAP_NAME="ou=auto.master,ou=automount,dc=example,dc=com"
>>> LDAP_URI="ldaps://dc1.example.com" # AD server name
>>> SEARCH_BASE="ou=automount,dc=example,dc=com"
>>> #LOGGING="verbose"
>>> LOGGING="debug"
>>> #LDAP_URI="ldap://dc1.example.com" # AD server name
>>> #LDAP_URI="ldap:///dc=example,dc=com" # AD server name
>>> MAP_OBJECT_CLASS="automountMap"
>>> ENTRY_OBJECT_CLASS="automount"
>>> MAP_ATTRIBUTE="automountMapName"
>>> ENTRY_ATTRIBUTE="automountKey"
>>> VALUE_ATTRIBUTE="automountInformation"
>>> AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"
>>
>> Well, old style configuration but that should still work regardless
>> of autofs version.
> 
> I take it from that, there is a new style configuration, is this
> documented anywhere ?
> 
>>
>>>
>>> Set /etc/autofs_ldap_auth.conf to this:
>>>
>>> <?xml version="1.0" ?>
>>> <!--
>>> This files contains a single entry with multiple attributes tied to
>>> it. See autofs_ldap_auth.conf(5) for more information.
>>> -->
>>>
>>> <autofs_ldap_sasl_conf
>>>         usetls="no"
>>>         tlsrequired="yes"
>>>         authrequired="yes"
>>>         authtype="GSSAPI"
>>>         clientprinc="asciiclient$@EXAMPLE.COM"
>>> />
>>>
>>>
>>> Set /etc/ldap/ldap.conf to this:
>>>
>>> BASE    dc=example,dc=com
>>> URI     ldaps://dc1.example.com
>>> HOST dc1.example.com
>>> TLS_CACERT /etc/ssl/certs/dc1cert.pem
>>> TLS_REQCERT never
>>
>> LDAP + Kerberos is not my favorite, anyway here are some things to
>> think about.
> 
> Sort of goes with an AD domain ;-)
> 
>>
>> Is EXAMPLE.COM is a valid Kerberos realm?
> 
> Definitely.
> 
>>
>> Has it got a principle asciiclient$@EXAMPLE.COM that doesn't require
>> a password?
> 
> Oh dear, no it hasn't, but there is ASCIICLIENT$@EXAMPLE.COM
> Feel a bit of a fool now, I should have known better.
> 
> OK, fixing that got me a bit further, but I now cannot login to
> asciiclient, the home dirs get overwritten, so I am now trying to
> setup an indirect mount.

Overwritten?

> 
> The automount objects now look like this:
> 
>  dn: OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: organizationalUnit
> ou: automount
> name: automount
> 
> dn: OU=auto.master,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automountMap
> objectClass: organizationalUnit
> ou: auto.master
> name: auto.master
> automountMapName: auto.master
> 
> dn: CN=*,OU=auto.master,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automount
> objectClass: container
> cn: *
> name: *
> automountKey: *
> automountInformation: -fstype=nfs4,rw,sec=krb5 dc1//:/home/users/&

Shouldn't that be "dc1:/home/users/&" or "dc1.example.com:/home/users/&".
The / character isn't valid in host names.

The wildcard map key will work but you may find you get unexpected lookups
trying to mount directories you probably think shouldn't be being accessed.

There's nothing autofs can do about that because if something tries to access
a path in the automount base directory the kernel is duty bound to call back
to the daemon, and the daemon will match the name to the wild card entry, and
try and mount it.

> 
> dn: OU=auto.home,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automountMap
> objectClass: organizationalUnit
> ou: auto.home
> name: auto.home
> automountMapName: auto.home
> 
> Which leads to this:
> 
> Oct  3 15:20:26 asciiclient automount[1587]: connected to uri ldaps://dc1.example.com
> Oct  3 15:20:26 asciiclient automount[1587]: lookup_read_master: lookup(ldap): searching for "(objectclass=automount)" under "OU=auto.master,OU=automount,DC=example,DC=com"
> Oct  3 15:20:26 asciiclient automount[1587]: lookup_read_master: lookup(ldap): examining entries
> Oct  3 15:20:26 asciiclient automount[1587]: syntax error in map near [ * -fstype=nfs4,rw,sec=krb5 dc1 ]

Which looks like that's what it's complaining about.

NFS using Kerberos is a bit strange judging by what I've seen recently.
Hopefully it will work ok for you.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
