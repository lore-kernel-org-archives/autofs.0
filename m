From: wengang wang <wen.gang.wang@oracle.com>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Mon, 10 Sep 2007 09:44:32 +0800
Message-ID: <46E4A180.2000409@oracle.com>
References: <46DE1128.2020109@oracle.com>	
	<1188994602.3119.5.camel@raven.themaw.net>
	<46DF5F67.7030901@oracle.com>
	<1189050061.3102.27.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2569417243501395149=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1189050061.3102.27.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============2569417243501395149==
Content-Type: multipart/alternative;
	boundary="------------080402060503080002000509"

This is a multi-part message in MIME format.
--------------080402060503080002000509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian,

reply from custom:
==>
Just to clarify:
 
1. We use different basedn for authentication and automount in our 
directory. The basedn for authentoication is used from /etc/ldap.conf. 
However we need to specify a separate basedn for automount maps because 
they are regional.
 
2. We do not have multiple master maps just one.
 
If it possible to use the MASTER_MAP_NAME without specifying the server 
then that should solve our problem. I will test this and let you know if 
it works.
<==

thanks,
wengang.

Ian Kent wrote:
> On Thu, 2007-09-06 at 10:01 +0800, wengang wang wrote:
>   
>> Hi Ian,
>>
>> here is the exchangings:
>>     
>
> It's not clear from this what the problem is.
>
> snip ...
>
>   
>> *** PLAKDAWA  08/14/07 02:06 pm *** 
>> Just to give you a little more information: Our automount schema is
>> based on 
>> the "automountmapname", "automountkey" and "automountinformation"
>> attributes. 
>> This works properly with the relevant settings in
>> the /etc/sysconfig/autofs 
>> file on RHEL5 if the basedn is set manually in
>> the /etc/openldap/ldap.conf 
>>     
>
> But doesn't work if you don't set basdn in ldap.conf?
> Are you saying that there are multiple master maps and maps of the same
> name under different basedns in this setup?
>
>   
>> file. However, since the openldap/ldap.conf file can be used by other 
>> applications, we don't want our automounter's basedn to depend on
>> this. 
>>
>> The LDAP attributes of the automount maps are as shown below: 
>>
>> [porus@rattlebag ~]$ ldapsearch -LLL -x -b 
>> "ou=sc,ou=ca,ou=na,dc=hyperion,dc=com"
>> "automountmapname=auto_nfshome" 
>> dn:
>> automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com 
>> objectClass: top 
>> objectClass: automountMap 
>> automountMapName: auto_nfshome 
>>   
>> [porus@rattlebag ~]$ ldapsearch -LLL -x -b 
>> "automountmapname=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com" 
>> "automountkey=plakdawa" 
>> dn: 
>> automountkey=plakdawa,automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=h 
>>  yperion,dc=com 
>> automountInformation: scfs3:/vol/vol2/homes/& 
>> automountKey: plakdawa 
>> objectClass: top 
>> objectClass: automount 
>>     
>
> snip ...
>
>   
>> *** PLAKDAWA  08/20/07 11:51 am *** 
>> The other issue with the DEFAULT_MASTER_MAP_NAME is that providing the full 
>> URL, will prevent the failover to the secondary LDAP server should the one 
>> mentioned in the URL fail. Or is it possible to add secondary entries?
>>     
>
> It's possible to specify the map (master or other) without the server
> name.
>
> eg.
> MASTER_MAP_NAME="ou=auto.master,dc=themaw,dc=net"
>
> This will then use the above basedn for finding the master map.
>
> However, this can't be used when autofs searches for the basedn for the
> maps referred to in the above master map which may not be a sensible
> thing to do but cannot be practically done another way. 
>
> The only workaround for this at the moment would be to specify the
> basedn in the master map entries as well as in the master map as above.
>
> eg.
> # /ldap, auto.master, themaw.net
> dn: cn=/ldap,ou=auto.master,dc=themaw,dc=net
> objectClass: automount
> cn: /ldap
> automountInformation: ou=auto.indirect,dc=themaw,dc=net
>
> Ian
>
>
>   

-- 
Wengang Wang
Member of Technical Staff
Oracle Asia R&D Center
Open Source Technologies Development

Tel:      +86 10 8278 6265
Mobile:   +86 13381078925


--------------080402060503080002000509
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id l8B2oYSd023396

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Hi Ian,<br>
<br>
reply from custom:<br>
=3D=3D&gt;<br>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"><font
 color=3D"#0000ff" face=3D"Arial" size=3D"2">Just to clarify:</font></spa=
n></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"></span=
>=C2=A0</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"><font
 color=3D"#0000ff" face=3D"Arial" size=3D"2">1. We use different basedn f=
or
authentication and automount in our directory. The basedn for
authentoication is used from /etc/ldap.conf. However we need to specify
a separate basedn for automount maps because they are regional.</font></s=
pan></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"></span=
>=C2=A0</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"><font
 color=3D"#0000ff" face=3D"Arial" size=3D"2">2. We do not have multiple
master maps just one.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"></span=
>=C2=A0</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"453330318-07092007"><font
 color=3D"#0000ff" face=3D"Arial" size=3D"2">If it possible to use the
MASTER_MAP_NAME without specifying the server then that should solve
our problem. I will test this and let you know if it works.</font></span>=
</div>
&lt;=3D=3D<br>
<br>
thanks,<br>
wengang.<br>
<br>
Ian Kent wrote:
<blockquote cite=3D"mid1189050061.3102.27.camel@raven.themaw.net"
 type=3D"cite">
  <pre wrap=3D"">On Thu, 2007-09-06 at 10:01 +0800, wengang wang wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Hi Ian,

here is the exchangings:
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
It's not clear from this what the problem is.

snip ...

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">*** PLAKDAWA  08/14/07 02:06 pm ***=20
Just to give you a little more information: Our automount schema is
based on=20
the "automountmapname", "automountkey" and "automountinformation"
attributes.=20
This works properly with the relevant settings in
the /etc/sysconfig/autofs=20
file on RHEL5 if the basedn is set manually in
the /etc/openldap/ldap.conf=20
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
But doesn't work if you don't set basdn in ldap.conf?
Are you saying that there are multiple master maps and maps of the same
name under different basedns in this setup?

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">file. However, since the openldap/ldap.conf file can b=
e used by other=20
applications, we don't want our automounter's basedn to depend on
this.=20

The LDAP attributes of the automount maps are as shown below:=20

[porus@rattlebag ~]$ ldapsearch -LLL -x -b=20
"ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom"
"automountmapname=3Dauto_nfshome"=20
dn:
automountMapName=3Dauto_nfshome,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3D=
com=20
objectClass: top=20
objectClass: automountMap=20
automountMapName: auto_nfshome=20
 =20
[porus@rattlebag ~]$ ldapsearch -LLL -x -b=20
"automountmapname=3Dauto_nfshome,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=
=3Dcom"=20
"automountkey=3Dplakdawa"=20
dn:=20
automountkey=3Dplakdawa,automountMapName=3Dauto_nfshome,ou=3Dsc,ou=3Dca,o=
u=3Dna,dc=3Dh=20
 yperion,dc=3Dcom=20
automountInformation: scfs3:/vol/vol2/homes/&amp;=20
automountKey: plakdawa=20
objectClass: top=20
objectClass: automount=20
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
snip ...

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">*** PLAKDAWA  08/20/07 11:51 am ***=20
The other issue with the DEFAULT_MASTER_MAP_NAME is that providing the fu=
ll=20
URL, will prevent the failover to the secondary LDAP server should the on=
e=20
mentioned in the URL fail. Or is it possible to add secondary entries?
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
It's possible to specify the map (master or other) without the server
name.

eg.
MASTER_MAP_NAME=3D"ou=3Dauto.master,dc=3Dthemaw,dc=3Dnet"

This will then use the above basedn for finding the master map.

However, this can't be used when autofs searches for the basedn for the
maps referred to in the above master map which may not be a sensible
thing to do but cannot be practically done another way.=20

The only workaround for this at the moment would be to specify the
basedn in the master map entries as well as in the master map as above.

eg.
# /ldap, auto.master, themaw.net
dn: cn=3D/ldap,ou=3Dauto.master,dc=3Dthemaw,dc=3Dnet
objectClass: automount
cn: /ldap
automountInformation: ou=3Dauto.indirect,dc=3Dthemaw,dc=3Dnet

Ian


  </pre>
</blockquote>
<br>
<pre class=3D"moz-signature" cols=3D"72">--=20
Wengang Wang
Member of Technical Staff
Oracle Asia R&amp;D Center
Open Source Technologies Development

Tel:      +86 10 8278 6265
Mobile:   +86 13381078925
</pre>
</body>
</html>

--------------080402060503080002000509--


--===============2569417243501395149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2569417243501395149==--

