From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs5: unable to locate ldap master map
Date: Mon, 03 Jul 2006 15:53:51 +0200
Message-ID: <44A9216F.1030102@inria.fr>
References: <44A25311.2040501@inria.fr>
	<1151554184.2929.45.camel@raven.themaw.net>
	<44A3B6CD.5030403@inria.fr>
	<1151585997.3915.36.camel@raven.themaw.net>
	<44A4E38D.7020004@inria.fr>
	<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>
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

Ian Kent wrote:
>>>>> The default name can be set in the autofs config by uncommenting the
>>>>> line:
>>>>>
>>>>> DEFAULT_MASTER_MAP_NAME="auto.master"
>>>>>
>>>>> and changing auto.master to what you require.
>>>> I'm still not sure however what is this file meant for: is this
>>>> automount daemon configuration file (aka read by it whatever way you
>>>> launch it) or the init script configuration file (aka read by the shell
>>>> init script to give additional configurations options, such as
>>>> command-line arguments) ?
>>> Is used whichever way you launch it.
>>> Except for the OPTIONS variable which is only used in the init script to
>>> pass command line options.
>>>
>>>> >From your answer, it seems it is both, which make me feels unconfortable.
>>> Why.
>>> Don't you like having the same configuration whether you launch autofs
>>> from the init script or the command line.
>> First, it is unusual and unexpected, hence my surprise.
>>
>> Second, it mix issues. As developer, you should only deal about software
>> itself, and you let packager deal with initscripts, that belongs to
>> specific distribution customisation. For instance, I use a mandriva
>> specific init script to deal with specific mandriva requirements, such
>> as parallel init system. If I want to achieve a standard setup, I have
>> to use:
>> - --configdir %sysconfdir/autofs option just to make automount use
>> standard configuration location
>> - and delete the unused OPTIONS from the example file
> 
> A third party packager can do what ever they wish.
> They don't have to use the init script in the package.
> The fact is this stuff has to go somewhere because autofs needs it.
> The sensible place for it it in the expected configuration directory.
And my point is: the expected configuration directory for package foobar
is /etc/foobar (%sysconfdir/foobar, actually), which is
distribution-agnostic, not any of `/etc/sysconfig', `/etc/default' and
`/etc/conf.d', which are merely used for storing distribution-specific
initialisation preferences.

> Your example above won't work.
> Have you actually read the INSTALL file which tells you what options 
> autofs configure understands?
I didn't tested it, and I indeed meant --with-confdir. I just wanted to
express that it was quite weird to have to ressort to explicit option to
stick to standards.

> Fact is that for configuration to be at all usefull autofs has to 
> understand it and cooperate with it. The only reason I added these 
> configure options was in an effort to make it easier for those who wish to 
> use different locations to customise them. If it doesn't meet with your 
> approval then I'm sorry but I like it and it works well for me. And I 
> don't see any patch submissions from you for discussion so I guess you'll 
> just have to live with it.
I don't see the point of investing time to produce patches that will be
rejected, so I usually try to reach agreement before. Now, if all you
want is a patch, I can easily produce one, once we agree on the
following points:
- is is desirable to have distinct directories for automount
configuration and master map location (aka --with-confdir and
--with-mapdir switches) ?
- if they differ does, autofs_ldap_auth.conf belongs to automount
configuration or master map location ?
- is is really desirable to make those directories configurable, whereas
a fixed /etc/autofs would be perfectly fine ?
- do you want initscript-related corresponding options, such as
--with-initscriptdir and --with-initscriptconfigdir ?

[..]
>>>>>> - what are precedence with system configuration for openldap libraries ?
>>>>> Don't understand what you mean here?
>>>>>
>>>>> If you specify a server name it will be used.
>>>>> If not the LDAP default will be used.
>>>>> If you specify a map only like:
>>>>>
>>>>> ldap:auto.master
>>>>>
>>>>> This should use the the LDAP default base and autofs default or
>>>>> configured schema.
>>>>>
>>>>> Otherwise you must use a full dn such as:
>>>>>
>>>>> ldap:ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
>>>>>
>>>>> consistent with requirements of LDAP utility commands.
>>>> I was purely speaking of LDAP connection parameters, not LDAP content
>>>> handling.
>>>>
>>>> I have no idea about openldap librarie API or usage in C, so I may be
>>>> absolutly wrong here, but basically, openldap library configuration
>>>> (classicaly, /etc/openldap/ldap.conf) already handle everything needed
>>>> to contact (including secure connection parameters) LDAP server. So what
>>>> is the use of distinct LDAP configuration for autofs, and additional
>>>> SSL/TLS support there ?
>>> Again I'm not clear on which configuration you are talking about.
>>> Can you be specific as to the configuration options that are duplicated?
>> Here is my current openldap configuration:
>> BASE            dc=village,dc=inria,dc=fr
>> URI             ldaps://yquem.inria.fr ldaps://julien.inria.fr
>> TLS_CACERT      /etc/ssl/ca.pem
>> TLS_REQCERT     demand
>> TIMELIMIT       3
>>
>> It has everything needed for openldap clients to contact servers,
>> including the need to use SSL connection. I just realized however it
>> doesn't allow to start encrypted communication on standard port, so I
>> guess that's the reason you need an additional configuration file if you
>> want to use TLS, right ?
> 
> The bug below means that LDAP auth config may not be installed.
> A patch, coming soon, makes the defaults in this file more sensible and 
> adds explanations of each possible entry.
> 
> The only configuration in autofs for TLS is a "yes" I want to use it 
> (which implies you have setup your certificates in your LDAP 
> configuration) or "no" don't use it.
> 
> Other configuration is such things as authentication type like DIGEST-MD5 
> and a userid and secret if required. These things aren't in the LDAP 
> config either.
> 
> The default values are used by the LDAP library if they are not 
> otherwise specified. What if your map is several more levels deep in the 
> tree. In this case, as is the case with LDAP utilities, you need to 
> specify the full dn in your specification. LDAP doesn't seem at all good at 
> filling in parts of a specification. Anuway that's my impression.
> 
> autofs needs to know what LDAP objects and attributes your map data is 
> held in. This is also not in the default LDAP configuration.
> 
> I'm still not clear which parts of the configuration you think shouldn't 
> be present?
None. I was just wondering at what specific connection directives it was
meant for, and you just replied:
- tls support
- secure autentication
Basically, if you don't use them, you don't need a autofs_ldap_auth.conf
file.

>>>> [..]
>>>>>> - are they supposed to be exported in environment before launching
>>>>>> automount, passed to it through a bunch of -Dkey=value ?
>>>>> Not needed.
>>>>> The values in the config are read at startup by /usr/sbin/automount.
>>>>> They may be overridden by values that are exported in the environment
>>>>> prior to running /usr/sbin/automount.
>>>> See my previous comment about distinction between program configuration
>>>> and init script configuration. Only init script configuration should use
>>>> /etc/sysconfdir (which happens to be /etc/default under Debian), and
>>>> program configuration should use plain /etc or /etc/autofs location.
>>> And /etc/default should be used by configure on a Debian system
>>> and /etc/conf.d on a Gentoo system.
>>>
>>> I think the division is OK myself.
>> Those directories are generally made for storing init parameters only,
>> not plain configuration, wich belongs to /etc directly (or /etc/autofs
>> eventually). And you would save yourself some troubles (such as a
>> configure switch) if you let this kind of issues to packagers (that's
>> their work, not yours).
>>
>> I just used beta6, it seems to work. However:
>> - I have to explicitely define a LDAP dn in auto.master file, otherwise
>> it doesn't work. it seems a bit logic, but it worked without
>> automagically with autofs 4 :)
> 
> No you don't.
If I don't specify a master map name anywhere, it won't work, right ?
With autofs4, I didn't had too, apparently autofs-ldap-auto-master was
able to identify it alone.

>> - as I have to use a master file, I can't use nss master map lookup, as
> 
> No you don't.
> In the configuration uncomment 
> DEFAULT_MASTER_MAP_NAME="your_ldap_object_name"
> and ensure that either the nsswitch.conf "automount:" entry doesn't have 
> files in it or there is no file of the same name in the map directory.
AHHHHHHH... I know understand than nss-based lookup only means 'ask nss
what facilities are available for automount, I'll interpret them
myself', whereas I was misleaded it was 'let nss compute what my master
map is'.

I'll submit a patch for the man page ASAP.

>> I didn't found how to define this base in autofs configuration
> 
> If there is nothing else but a map name alone then LDAP configured 
> defaults are used.
> 
> There are some examples in the samples directory of the tarball.
> They should be present in the normal doc directory if you built an rpm.
I got no trouble with LDAP content, just with changes between autofs4
and autofs5 for configuring its use.

> An example of an ldap master map might be:
> 
> DEFAULT_MASTER_MAP_NAME="nisMapName=auto_master,dc=themaw,dc=net"
> 
> Then the LDAP configured hosts should be used for the connection.
> 
>> - automount -d -v doesn't produce any sensible output
> 
> Configure syslog to send deamon.* somewhere.
> The output is meant for debuging purposes and is possibly not that 
> meaninful to most. You will be expected to provide it you have a 
> bug that you would us to try and fix.
I was refering to log content.
With a wrong setup, launching automount without -d -v produces 3 lines
out output:
Jul  3 15:19:46 alceste automount[32750]: parse_ldap_config:
lookup(ldap): stat(2) failed with error No such file or directory.
Jul  3 15:19:46 alceste automount[32750]: lookup_init: lookup(ldap):
failed to get query dn
Jul  3 15:19:46 alceste automount[32750]: master_read_master: can't read
master map auto.master

With those additional -d -v flags, it just produce one additional line:
Jul  3 15:19:33 alceste automount[32741]: Starting automounter version
5.0.0_beta6, master map auto.master
Jul  3 15:19:33 alceste automount[32741]: parse_ldap_config:
lookup(ldap): stat(2) failed with error No such file or directory.
Jul  3 15:19:33 alceste automount[32741]: lookup_init: lookup(ldap):
failed to get query dn
Jul  3 15:19:33 alceste automount[32741]: master_read_master: can't read
master map auto.master

But I guess there is not many more information to display.

>> - error message in logs for missing ldap configuration is a bit
>> excessive for an optional file:
>> parse_ldap_config: lookup(ldap): stat(2) failed with error No such file
>> or directory.
> 
> That bug should have been fixed in beta6.
> You will need to provide appropriate information if I'm to understand 
> what's wrong and hopefully fix it.
I'm using beta6, and this message appears if
/etc/autofs/autofs_ldap_auth.conf doesn't exist. If I create it with
touch, the error message becomes:
 stat(2) failed with error Inappropriate ioctl for device.

The only configure flag used is --with-mapdir=%{_sysconfdir}/autofs

> This problem, as it seems it still exists, will stop autofs from 
> working with LDAP almost completely, as you have seen.
> 
> This works OK for me so unless I get more information I can't fix it.
> 
>> I made some tests with strace, it seems automount scan all existing
>> process at startup, is it normal ?
> 
> It's checking to see if another instance is already running.
> I will be adding a command line option at some point to optionally disable 
> the check.
It doesn't hurt, I was just curious.

-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
