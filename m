From: Ian Kent <raven@themaw.net>
Subject: Re: Using autofs with Active directory
Date: Wed, 4 Oct 2017 11:21:07 +0800
Message-ID: <52bbfd4d-2623-4a5e-ce02-cda854573bd0@themaw.net>
References: <20171002192855.554d1e3a@devstation.samdom.example.com>
 <49527a45-8ba3-f9d1-30b9-8906dc8c19c4@themaw.net>
 <20171003155557.39eb1396@devstation.samdom.example.com>
 <9ff859d3-505b-98ce-b70b-117d133ec196@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=okkW53rZrxrP0YInQx
        zxnBlYwDT2clneUdQ79lR3P30=; b=UqrsrzSqs+DSTOCK9k2kXEVXQXpTuSp5SI
        U0FtYrPlS+x4k+jqhSAAdA3gs9hFQjARCr2iHz1dzDpnjgO0eDq5uo0CuWbC/Yh3
        upOuhulD2Pk0PWIyuSG2GxmyMygi2+61dhinyMyOYhBIA2nEc32HA2C+Y/8RIKGQ
        UF+edDhAeqh3JvOXkyKqGg+z44fJLcs7qIHbfNvHiwr//JFFxhDwuLzajqV5sHFL
        bLXwmGpWvsrZQxOjTDGlVMzPIYTHNy+XcSEHHZqYX8zBCBF/17v+eMDeqfFm8urs
        Xr8ARbNAK3gWZmgKQR4SprrcG/venQ1wkeGrst1i+I0XylSzjtpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=okkW53rZrxrP0YInQxzxnBlYwDT2clneUdQ79lR3P30=; b=a1AgL05x
        6B6uYfNaaRXWLqm2zTRrMNtFtVJlLN2ljsUlpCLVf40/mE0eP1hPvR4RlKoBpJ/i
        iZYPTHfM12I082bvGLC2DtaOhY+QfEM18mXvxNndEzbOV1euJR5r7iIoqo/25Cs6
        Jhxx3KMb3CulUaiygyJko52Rz1FLpkxvJ7N2JOBh/SM5D0x2zf4fSDhquUeYi6TC
        IdEO8xh8EWZLDMuH3The6tShzFffr5o4NBB4plhGfXL5ciyduNHEhSy3UtdcDq8K
        niUIZf++adHdX+jR10dKvTjAKskljf5W0fJAUmdgt072TJma9WvGXZ0/3CCF13Pp
        XKjky25urNFWnw==
In-Reply-To: <9ff859d3-505b-98ce-b70b-117d133ec196@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rowland Penny <rpenny@samba.org>, autofs@vger.kernel.org

On 04/10/17 10:21, Ian Kent wrote:
> On 03/10/17 22:55, Rowland Penny wrote:
>> On Tue, 3 Oct 2017 14:13:02 +0800
>> Ian Kent <raven@themaw.net> wrote:
>>
>>> On 03/10/17 02:28, Rowland Penny wrote:
>>>>
>>>> Hi, I hope this is the right place to send this to, but if not, can
>>>> you advise just where I should send it to ;-)
>>>>
>>>>
>>>> I am trying to get Automount to work with a Samba AD DC and I am
>>>> struggling. I think I might have read just about everything there
>>>> is on the internet, but there isn't much for using Autofs with ldap
>>>> and even less about AD.
>>>
>>> Yes, that is true but to change that would we would need input from
>>> people using this functionality.
>>
>> If I can get this to work, I will put something on the Samba wiki.
>>
>>
>>>
>>> Looks ok although I'm not sure about using CN, a case insensitive
>>> attribute.
>>
>> Everything is case insensitive on windows ;-)
>>
>>>
>>>>
>>>>
>>>> Set /etc/default/autofs to this:
>>>>
>>>> USE_MISC_DEVICE="yes"
>>>> #OPTIONS=""
>>>> MASTER_MAP_NAME="ldap:ou=auto.master,ou=automount,dc=example,dc=com"
>>>> #MASTER_MAP_NAME="ou=auto.master,ou=automount,dc=example,dc=com"
>>>> LDAP_URI="ldaps://dc1.example.com" # AD server name
>>>> SEARCH_BASE="ou=automount,dc=example,dc=com"
>>>> #LOGGING="verbose"
>>>> LOGGING="debug"
>>>> #LDAP_URI="ldap://dc1.example.com" # AD server name
>>>> #LDAP_URI="ldap:///dc=example,dc=com" # AD server name
>>>> MAP_OBJECT_CLASS="automountMap"
>>>> ENTRY_OBJECT_CLASS="automount"
>>>> MAP_ATTRIBUTE="automountMapName"
>>>> ENTRY_ATTRIBUTE="automountKey"
>>>> VALUE_ATTRIBUTE="automountInformation"
>>>> AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"
>>>
>>> Well, old style configuration but that should still work regardless
>>> of autofs version.
>>
>> I take it from that, there is a new style configuration, is this
>> documented anywhere ?
>>
>>>
>>>>
>>>> Set /etc/autofs_ldap_auth.conf to this:
>>>>
>>>> <?xml version="1.0" ?>
>>>> <!--
>>>> This files contains a single entry with multiple attributes tied to
>>>> it. See autofs_ldap_auth.conf(5) for more information.
>>>> -->
>>>>
>>>> <autofs_ldap_sasl_conf
>>>>         usetls="no"
>>>>         tlsrequired="yes"
>>>>         authrequired="yes"
>>>>         authtype="GSSAPI"
>>>>         clientprinc="asciiclient$@EXAMPLE.COM"
>>>> />
>>>>
>>>>
>>>> Set /etc/ldap/ldap.conf to this:
>>>>
>>>> BASE    dc=example,dc=com
>>>> URI     ldaps://dc1.example.com
>>>> HOST dc1.example.com
>>>> TLS_CACERT /etc/ssl/certs/dc1cert.pem
>>>> TLS_REQCERT never
>>>
>>> LDAP + Kerberos is not my favorite, anyway here are some things to
>>> think about.
>>
>> Sort of goes with an AD domain ;-)
>>
>>>
>>> Is EXAMPLE.COM is a valid Kerberos realm?
>>
>> Definitely.
>>
>>>
>>> Has it got a principle asciiclient$@EXAMPLE.COM that doesn't require
>>> a password?
>>
>> Oh dear, no it hasn't, but there is ASCIICLIENT$@EXAMPLE.COM
>> Feel a bit of a fool now, I should have known better.
>>
>> OK, fixing that got me a bit further, but I now cannot login to
>> asciiclient, the home dirs get overwritten, so I am now trying to
>> setup an indirect mount.
> 
> Overwritten?
> 
>>
>> The automount objects now look like this:
>>
>>  dn: OU=automount,DC=example,DC=com
>> objectClass: top
>> objectClass: organizationalUnit
>> ou: automount
>> name: automount
>>
>> dn: OU=auto.master,OU=automount,DC=example,DC=com
>> objectClass: top
>> objectClass: automountMap
>> objectClass: organizationalUnit
>> ou: auto.master
>> name: auto.master
>> automountMapName: auto.master
>>
>> dn: CN=*,OU=auto.master,OU=automount,DC=example,DC=com
>> objectClass: top
>> objectClass: automount
>> objectClass: container
>> cn: *
>> name: *
>> automountKey: *
>> automountInformation: -fstype=nfs4,rw,sec=krb5 dc1//:/home/users/&
> 
> Shouldn't that be "dc1:/home/users/&" or "dc1.example.com:/home/users/&".
> The / character isn't valid in host names.
> 
> The wildcard map key will work but you may find you get unexpected lookups
> trying to mount directories you probably think shouldn't be being accessed.
> 
> There's nothing autofs can do about that because if something tries to access
> a path in the automount base directory the kernel is duty bound to call back
> to the daemon, and the daemon will match the name to the wild card entry, and
> try and mount it.
> 
>>
>> dn: OU=auto.home,OU=automount,DC=example,DC=com
>> objectClass: top
>> objectClass: automountMap
>> objectClass: organizationalUnit
>> ou: auto.home
>> name: auto.home
>> automountMapName: auto.home
>>
>> Which leads to this:
>>
>> Oct  3 15:20:26 asciiclient automount[1587]: connected to uri ldaps://dc1.example.com
>> Oct  3 15:20:26 asciiclient automount[1587]: lookup_read_master: lookup(ldap): searching for "(objectclass=automount)" under "OU=auto.master,OU=automount,DC=example,DC=com"
>> Oct  3 15:20:26 asciiclient automount[1587]: lookup_read_master: lookup(ldap): examining entries
>> Oct  3 15:20:26 asciiclient automount[1587]: syntax error in map near [ * -fstype=nfs4,rw,sec=krb5 dc1 ]

Oh wait, there's no master map entry, this is trying to interpret the map
entry for auto.home as a master map entry which isn't going to work regardless
of the host name.

The automount maps in LDAP need to be something like:

Top level container:

dn: OU=automount,DC=example,DC=com
objectClass: top
objectClass: organizationalUnit
ou: automount
name: automount
distinguishedName: OU=automount,DC=example,DC=com

Master map container:

dn: OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automountMap
objectClass: organizationalUnit
ou: auto.master
name: auto.master
automountMapName: auto.master

Master map entries to define top level automount points, essentially these
amount to the master map entries that would be found in a file master map
(like /etc/auto.mastter):

dn: CN=/home,OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: /home
name: /home
automountKey: /home
automountInformation: ldap:ou=auto.home,ou=Automount,dc=example,dc=com rsize=8192,wsize=8192

for mounting /home that uses the auto.home map.

(but see below for using an unqualified map names in your entries)

Then a container for the auto.home map:

dn: OU=auto.home,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automountMap
objectClass: organizationalUnit
ou: auto.home
name: auto.home
automountMapName: auto.home

and entries for the auto.home map:

dn: CN=user,OU=auto.home,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: user
name: user
automountKey: user
automountInformation: -fstype=nfs4,rw,sec=krb5 dc1.example.com:/home/user/&

or, in your current case:

dn: CN=*,OU=auto.home,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: *
name: *
automountKey: *
automountInformation: -fstype=nfs4,rw,sec=krb5 dc1//:/home/users/&

There was a convention of using "/" as the wildcard map key.

I though it was needed because "/" had some special meaning in ldap but if this
works for you there's no need to change it (I'm pretty sure I look for either
* and /).

The container entries, for the master map and for the maps referred to by the
master map entries are used to calculate a basedn for entry lookup so things
like:
ldap:ou=auto.home,ou=Automount,dc=example,dc=com
shouldn't be needed.

TBH I can't remember now but if you really want to use these then I'd suggest
something like (I think):
ldap://<server name/ou=auto.home,ou=Automount,dc=example,dc=com
rather than the potentially ambiguous ldap:ou=....

or just use auto.home and let nsswitch fill in the bits from the (calculated)
basedn and other configuration in autofs and the client ldap configuration. For
that to work you would need to list ldap as a map source in /etc/nsswitch.conf,
like:
automount: ldap

and the master map entry for auto.home could then be:

dn: CN=/home,OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: /home
name: /home
automountKey: /home
automountInformation: auto.home rsize=8192,wsize=8192

Additionally that would also allow you to leave the
MASTER_MAP_NAME="ldap:ou=auto.master,ou=automount,dc=example,dc=com"
out so it just uses the (default) name auto.master and uses nsswitch
and the client ldap configuration to fill in the missing bits.

Also, you shouldn't need the:
MAP_OBJECT_CLASS="automountMap"
ENTRY_OBJECT_CLASS="automount"
MAP_ATTRIBUTE="automountMapName"
ENTRY_ATTRIBUTE="automountKey"
VALUE_ATTRIBUTE="automountInformation"

If your consistently using one of the expected schema autofs should
automatically detect the schema to use although there is a small
amount of overhead in working that out.

Another thing you might be interested in is using DNS SRV records to
get the list DC servers (and their priority order) but lets leave
that for now.

Keep in mind that you want to avoid using server names (other than in
actual mount targets) and protocol names (like ldap:) in you setup so
that you can leverage nsswitch and DNS SRV server name lookups at a
later stage.

So all that's probably a bit confusing, sorry, hopefully it will help
though.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
