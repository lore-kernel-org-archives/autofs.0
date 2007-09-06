From: wengang wang <wen.gang.wang@oracle.com>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Thu, 06 Sep 2007 10:01:11 +0800
Message-ID: <46DF5F67.7030901@oracle.com>
References: <46DE1128.2020109@oracle.com>
	<1188994602.3119.5.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1557272275571098684=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1188994602.3119.5.camel@raven.themaw.net>
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
--===============1557272275571098684==
Content-Type: multipart/alternative;
	boundary="------------010307010606050407010809"

This is a multi-part message in MIME format.
--------------010307010606050407010809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian,

here is the exchangings:

**** PLAKDAWA 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=PLAKDAWA> 
<mailto:porus.lakdawala@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
07/31/07 04:41 pm ****
In RHEL4 it was possible to set a "basedn" variable in the
/etc/sysconfig/autofs file which served as a basedn for LDAP lookups
performed by the automounter.

However, this has been removed in RHEL5.

This functionality is critical for us because we separate automounter 
maps by
region, but look up accounts and groups in the entire directory. So 
different
basedn are required for each of these lookups.

Can this functonality please be restored?

Thank you.
****** BBARBE 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=BBARBE> 
<mailto:bert.barbe@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/01/07 03:58 am ****
/@ BASEDN was introduced in the following errata /
/@ http://rhn.redhat.com/errata/RHBA-2006-0464.html/
/@ It is present in Update 4 and up/
****** PLAKDAWA 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=PLAKDAWA> 
<mailto:porus.lakdawala@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/13/07 10:47 am ****
We set the autofs basedn using /etc/sysconfig/autofs.

We do not use /etc/openldap/ldap.conf because this file is automatically
edited by the redhat config tools authconfig and
system-config-authentication. These tools setup identical basedn entries 
for
the two files /etc/ldap.conf and /etc/openldap/ldap.conf.

The /etc/sysconfig/autofs settings for us in RHEL AS4 are as follows:

[porus@rattlebag ~]$ cat /etc/sysconfig/autofs
# Define custom options in /etc/sysconfig/autofs
# Use LOCALOPTIONS for defining variables, e.g. OSREL
# Use DAEMONOPTIONS to define the unmount timeout
# Define UNDERSCORETODOT as 1 to convert
#     auto_home to auto.home and auto_mnt to auto.mnt
# Mount options, e.g. rsize=8192, should go in auto.master or
#     the auto_* map entry for a specific mount point
#
LOCALOPTIONS=""
DAEMONOPTIONS="--timeout=60"
LDAPAUTOMASTER=""
#  UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to auto.mnt
UNDERSCORETODOT=1
DISABLE_DIRECT=1
# Only source one master map if set to 1.  This would mimic Sun behaviour.
# The default is 0 to maintain backwards compatibility.
ONE_AUTO_MASTER=0
# List of directories to be ghosted, separated by white space.
GHOSTDIRS=""
# Base DN to use when searching for the master map
BASEDN=ou=sc,ou=ca,ou=na,dc=hyperion,dc=com

****** PLAKDAWA 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=PLAKDAWA> 
<mailto:porus.lakdawala@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/14/07 02:06 pm ****
Just to give you a little more information: Our automount schema is 
based on
the "automountmapname", "automountkey" and "automountinformation" 
attributes.
This works properly with the relevant settings in the /etc/sysconfig/autofs
file on RHEL5 if the basedn is set manually in the /etc/openldap/ldap.conf
file. However, since the openldap/ldap.conf file can be used by other
applications, we don't want our automounter's basedn to depend on this.

The LDAP attributes of the automount maps are as shown below:

[porus@rattlebag ~]$ ldapsearch -LLL -x -b
"ou=sc,ou=ca,ou=na,dc=hyperion,dc=com" "automountmapname=auto_nfshome"
dn: automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
objectClass: top
objectClass: automountMap
automountMapName: auto_nfshome
 
[porus@rattlebag ~]$ ldapsearch -LLL -x -b
"automountmapname=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com"
"automountkey=plakdawa"
dn:
automountkey=plakdawa,automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=h
 yperion,dc=com
automountInformation: scfs3:/vol/vol2/homes/&
automountKey: plakdawa
objectClass: top
objectClass: automount
**** PLAKDAWA 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=PLAKDAWA> 
<mailto:porus.lakdawala@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/14/07 02:12 pm ****
I am not certain if the lab server will be reachable from your subnets. We
are part of hyperion (was recently acquired by Oracle). Please try the
/@ following IP address /

/@ Name:   labldap02.hyperion.com/
Address: 172.27.33.46

The LDAP basedn for all account lookups is "dc=hyperion,dc=com".

The LDAP basedn for automount lookups is
"ou=sc,ou=ca,ou=na,dc=hyperion,dc=com"
**** WWG 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=WWG> 
<mailto:wen.gang.wang@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/15/07 12:34 am ****
/@ yes, as you said, BASEDN set in /etc/sysconfig/autofs doesn't work./
/@ while, you can specify the auto master entry by add one line in to /
/@ /etc/sysconfig/autofs/
/@ 
DEFAULT_MASTER_MAP_NAME="//172.27.33.46/automountmapname=auto_nfshome,ou=sc,ou/ 

/@ =ca,ou=na,dc=hyperion,dc=com"/
**** PLAKDAWA 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=PLAKDAWA> 
<mailto:porus.lakdawala@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/20/07 11:46 am ****
We have multiple automount maps in ou=sc,ou=ca,ou=na,dc=hyperion,dc=com.

So should the DEFAULT_MASTER_MAP_NAME be set to the auto.master map?

[porus@rattlebag ~]$ ldapsearch -LLL -x -b
"ou=sc,ou=ca,ou=na,dc=hyperion,dc=com" "objectclass=automountmap"
dn: automountMapName=auto_automnt,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
automountMapName: auto_automnt
objectClass: top
objectClass: automountMap

dn: automountMapName=auto_master,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
automountMapName: auto_master
objectClass: top
objectClass: automountMap

dn: automountMapName=auto.master,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
automountMapName: auto.master
objectClass: top
objectClass: automountMap

dn: automountMapName=auto_scfs3,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
objectClass: top
objectClass: automountMap
automountMapName: auto_scfs3

dn: automountMapName=auto_scfs4,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
objectClass: top
objectClass: automountMap
automountMapName: auto_scfs4

dn: automountMapName=auto_nar200,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
objectClass: top
objectClass: automountMap
automountMapName: auto_nar200

dn: automountMapName=auto_nfshome,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
objectClass: top
objectClass: automountMap
automountMapName: auto_nfshome

dn: automountMapName=auto_products,ou=sc,ou=ca,ou=na,dc=hyperion,dc=com
objectClass: top
objectClass: automountMap
automountMapName: auto_products
**** PLAKDAWA 
<https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_username=PLAKDAWA> 
<mailto:porus.lakdawala@oracle.com?subject=Bug%23%206315017%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&body=Bug%23%20%3Ca%20href=http://bug.us.oracle.com/pls/bug/webbug_print.show?c_rptno=6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP> 
08/20/07 11:51 am ****
The other issue with the DEFAULT_MASTER_MAP_NAME is that providing the full
URL, will prevent the failover to the secondary LDAP server should the one
mentioned in the URL fail. Or is it possible to add secondary entries?

over.

thanks
wengang.

Ian Kent wrote:
> On Wed, 2007-09-05 at 10:15 +0800, wengang wang wrote:
>   
>> Hi,
>> A custom complained that:
>> //<==
>> In RHEL4 it was possible to set a "basedn" variable in the
>> /etc/sysconfig/autofs file which served as a basedn for LDAP lookups
>> performed by the automounter.
>>
>> However, this has been removed in RHEL5.
>> //<==
>> It is true that setting it in /etc/openldap/ldap.conf is an alternative, 
>>     
>
> No.
>
>   
>> the custom doesn't want do as that because /etc/openldap/ldap.conf is 
>> automatically edited by the redhat config tools authconfig and 
>> system-config-authentication.
>> So I want to know for what the basedn is removed from 
>> /etc/sysconfig/autofs.  I checked all the change logs and readmes in 
>> autofs-5.0.1, but didn't find basedn metioned.
>>     
>
> In version 5 the base dn is calculated, depending on how you specify the
> map.
>
> Describe the problem and I'll try and give a sensible answer.
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


--------------010307010606050407010809
Content-Type: multipart/related;
	boundary="------------080608040509010400010608"


--------------080608040509010400010608
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id l86EcOKa007560

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Hi Ian,<br>
<br>
here is the exchangings:<br>
<br>
<tt><b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DPLAKDAWA">PLAKDAWA</a>
<a
 href=3D"mailto:porus.lakdawala@oracle.com?subject=3DBug%23%206315017%20-=
%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LD=
AP&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/web=
bug_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LO=
NGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
07/31/07 04:41 pm ***</b>
<br>
In RHEL4 it was possible to set a "basedn" variable in the <br>
/etc/sysconfig/autofs file which served as a basedn for LDAP lookups <br>
performed by the automounter.
<br>
<br>
However, this has been removed in RHEL5.
<br>
<br>
This functionality is critical for us because we separate automounter
maps by <br>
region, but look up accounts and groups in the entire directory. So
different <br>
basedn are required for each of these lookups.
<br>
<br>
Can this functonality please be restored?
<br>
<br>
Thank you.
<br>
<b></b><b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DBBARBE">BBARBE</a>
<a
 href=3D"mailto:bert.barbe@oracle.com?subject=3DBug%23%206315017%20-%20BA=
SEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP&am=
p;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/webbug_p=
rint.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONGER%=
20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/01/07 03:58 am ***</b>
<br>
<i>@ BASEDN was introduced in the following errata </i>
<br>
<i>@ <a href=3D"http://rhn.redhat.com/errata/RHBA-2006-0464.html"
 target=3D"_blank">http://rhn.redhat.com/errata/RHBA-2006-0464.html</a></=
i>
<br>
<i>@ It is present in Update 4 and up</i>
<br>
<b></b><b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DPLAKDAWA">PLAKDAWA</a>
<a
 href=3D"mailto:porus.lakdawala@oracle.com?subject=3DBug%23%206315017%20-=
%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LD=
AP&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/web=
bug_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LO=
NGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/13/07 10:47 am ***</b>
<br>
We set the autofs basedn using /etc/sysconfig/autofs.
<br>
<br>
We do not use /etc/openldap/ldap.conf because this file is
automatically <br>
edited by the redhat config tools authconfig and <br>
system-config-authentication. These tools setup identical basedn
entries for <br>
the two files /etc/ldap.conf and /etc/openldap/ldap.conf.
<br>
<br>
The /etc/sysconfig/autofs settings for us in RHEL AS4 are as follows:
<br>
<br>
[porus@rattlebag ~]$ cat /etc/sysconfig/autofs
<br>
# Define custom options in /etc/sysconfig/autofs
<br>
# Use LOCALOPTIONS for defining variables, e.g. OSREL
<br>
# Use DAEMONOPTIONS to define the unmount timeout
<br>
# Define UNDERSCORETODOT as 1 to convert
<br>
#=C2=A0=C2=A0=C2=A0=C2=A0 auto_home to auto.home and auto_mnt to auto.mnt
<br>
# Mount options, e.g. rsize=3D8192, should go in auto.master or
<br>
#=C2=A0=C2=A0=C2=A0=C2=A0 the auto_* map entry for a specific mount point
<br>
#
<br>
LOCALOPTIONS=3D""
<br>
DAEMONOPTIONS=3D"--timeout=3D60"
<br>
LDAPAUTOMASTER=3D""
<br>
#=C2=A0=C2=A0UNDERSCORETODOT changes auto_home to auto.home and auto_mnt =
to
auto.mnt
<br>
UNDERSCORETODOT=3D1
<br>
DISABLE_DIRECT=3D1
<br>
# Only source one master map if set to 1.=C2=A0=C2=A0This would mimic Sun
behaviour.
<br>
# The default is 0 to maintain backwards compatibility.
<br>
ONE_AUTO_MASTER=3D0
<br>
# List of directories to be ghosted, separated by white space.
<br>
GHOSTDIRS=3D""
<br>
# Base DN to use when searching for the master map
<br>
BASEDN=3Dou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom
<br>
<br>
<b></b><b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DPLAKDAWA">PLAKDAWA</a>
<a
 href=3D"mailto:porus.lakdawala@oracle.com?subject=3DBug%23%206315017%20-=
%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LD=
AP&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/web=
bug_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LO=
NGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/14/07 02:06 pm ***</b>
<br>
Just to give you a little more information: Our automount schema is
based on <br>
the "automountmapname", "automountkey" and "automountinformation"
attributes. <br>
This works properly with the relevant settings in the
/etc/sysconfig/autofs <br>
file on RHEL5 if the basedn is set manually in the
/etc/openldap/ldap.conf <br>
file. However, since the openldap/ldap.conf file can be used by other <br=
>
applications, we don't want our automounter's basedn to depend on this.
<br>
<br>
The LDAP attributes of the automount maps are as shown below:
<br>
<br>
[porus@rattlebag ~]$ ldapsearch -LLL -x -b <br>
"ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom" "automountmapname=3Dauto=
_nfshome" <br>
dn: automountMapName=3Dauto_nfshome,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion=
,dc=3Dcom <br>
objectClass: top <br>
objectClass: automountMap <br>
automountMapName: auto_nfshome <br>
=C2=A0
<br>
[porus@rattlebag ~]$ ldapsearch -LLL -x -b <br>
"automountmapname=3Dauto_nfshome,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=
=3Dcom" <br>
"automountkey=3Dplakdawa" <br>
dn: <br>
automountkey=3Dplakdawa,automountMapName=3Dauto_nfshome,ou=3Dsc,ou=3Dca,o=
u=3Dna,dc=3Dh
<br>
=C2=A0yperion,dc=3Dcom <br>
automountInformation: scfs3:/vol/vol2/homes/&amp; <br>
automountKey: plakdawa <br>
objectClass: top <br>
objectClass: automount <br>
<b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DPLAKDAWA">PLAKDAWA</a>
<a
 href=3D"mailto:porus.lakdawala@oracle.com?subject=3DBug%23%206315017%20-=
%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LD=
AP&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/web=
bug_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LO=
NGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/14/07 02:12 pm ***</b>
<br>
I am not certain if the lab server will be reachable from your subnets.
We <br>
are part of hyperion (was recently acquired by Oracle). Please try the <b=
r>
<i>@ following IP address </i>
<br>
<br>
<i>@ Name:=C2=A0=C2=A0 labldap02.hyperion.com</i>
<br>
Address: 172.27.33.46
<br>
<br>
The LDAP basedn for all account lookups is "dc=3Dhyperion,dc=3Dcom".
<br>
<br>
The LDAP basedn for automount lookups is <br>
"ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom"
<br>
<b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DWWG">WWG</a>
<a
 href=3D"mailto:wen.gang.wang@oracle.com?subject=3DBug%23%206315017%20-%2=
0BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP=
&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/webbu=
g_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LONG=
ER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/15/07 12:34 am ***</b>
<br>
<i>@ yes, as you said, BASEDN set in /etc/sysconfig/autofs doesn't work.<=
/i>
<br>
<i>@ while, you can specify the auto master entry by add one line in to
</i>
<br>
<i>@ /etc/sysconfig/autofs</i>
<br>
<i>@
DEFAULT_MASTER_MAP_NAME=3D"//172.27.33.46/automountmapname=3Dauto_nfshome=
,ou=3Dsc,ou</i>
<br>
<i>@ =3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom"</i>
<br>
<b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DPLAKDAWA">PLAKDAWA</a>
<a
 href=3D"mailto:porus.lakdawala@oracle.com?subject=3DBug%23%206315017%20-=
%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LD=
AP&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/web=
bug_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LO=
NGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/20/07 11:46 am ***</b>
<br>
We have multiple automount maps in
ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom.
<br>
<br>
So should the DEFAULT_MASTER_MAP_NAME be set to the auto.master map?
<br>
<br>
[porus@rattlebag ~]$ ldapsearch -LLL -x -b <br>
"ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,dc=3Dcom" "objectclass=3Dautomount=
map"
<br>
dn: automountMapName=3Dauto_automnt,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion=
,dc=3Dcom
<br>
automountMapName: auto_automnt
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
<br>
dn: automountMapName=3Dauto_master,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,=
dc=3Dcom
<br>
automountMapName: auto_master
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
<br>
dn: automountMapName=3Dauto.master,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,=
dc=3Dcom
<br>
automountMapName: auto.master
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
<br>
dn: automountMapName=3Dauto_scfs3,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,d=
c=3Dcom
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
automountMapName: auto_scfs3
<br>
<br>
dn: automountMapName=3Dauto_scfs4,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,d=
c=3Dcom
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
automountMapName: auto_scfs4
<br>
<br>
dn: automountMapName=3Dauto_nar200,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion,=
dc=3Dcom
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
automountMapName: auto_nar200
<br>
<br>
dn: automountMapName=3Dauto_nfshome,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperion=
,dc=3Dcom
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
automountMapName: auto_nfshome
<br>
<br>
dn: automountMapName=3Dauto_products,ou=3Dsc,ou=3Dca,ou=3Dna,dc=3Dhyperio=
n,dc=3Dcom
<br>
objectClass: top
<br>
objectClass: automountMap
<br>
automountMapName: auto_products
<br>
<b>*** <a target=3D"_BLANK"
 href=3D"https://bug.oraclecorp.com/pls/bug/WEBBUG_EDIT.User_Profile?p_us=
ername=3DPLAKDAWA">PLAKDAWA</a>
<a
 href=3D"mailto:porus.lakdawala@oracle.com?subject=3DBug%23%206315017%20-=
%20BASEDN%20NO%20LONGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LD=
AP&amp;body=3DBug%23%20%3Ca%20href=3Dhttp://bug.us.oracle.com/pls/bug/web=
bug_print.show?c_rptno=3D6315017%3E6315017%3C/a%3E%20-%20BASEDN%20NO%20LO=
NGER%20AVAILABLE%20TO%20SET%20FOR%20AUTOFS%20WITH%20LDAP"><img
 src=3D"cid:part1.00070909.00060300@oracle.com" align=3D"bottom" border=3D=
"0"></a>
08/20/07 11:51 am ***</b>
<br>
The other issue with the DEFAULT_MASTER_MAP_NAME is that providing the
full <br>
URL, will prevent the failover to the secondary LDAP server should the
one <br>
mentioned in the URL fail. Or is it possible to add secondary entries?
</tt><br>
<br>
over.<br>
<br>
thanks<br>
wengang.<br>
<br>
Ian Kent wrote:
<blockquote cite=3D"mid1188994602.3119.5.camel@raven.themaw.net"
 type=3D"cite">
  <pre wrap=3D"">On Wed, 2007-09-05 at 10:15 +0800, wengang wang wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Hi,
A custom complained that:
//&lt;=3D=3D
In RHEL4 it was possible to set a "basedn" variable in the
/etc/sysconfig/autofs file which served as a basedn for LDAP lookups
performed by the automounter.

However, this has been removed in RHEL5.
//&lt;=3D=3D
It is true that setting it in /etc/openldap/ldap.conf is an alternative,=20
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
No.

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">the custom doesn't want do as that because /etc/openld=
ap/ldap.conf is=20
automatically edited by the redhat config tools authconfig and=20
system-config-authentication.
So I want to know for what the basedn is removed from=20
/etc/sysconfig/autofs.  I checked all the change logs and readmes in=20
autofs-5.0.1, but didn't find basedn metioned.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
In version 5 the base dn is calculated, depending on how you specify the
map.

Describe the problem and I'll try and give a sensible answer.

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

--------------080608040509010400010608
Content-Type: image/gif;
 name="mailto.gif"
Content-ID: <part1.00070909.00060300@oracle.com>
Content-Disposition: inline;
 filename="mailto.gif"
Content-Transfer-Encoding: base64

R0lGODdhDgAKAKIAAP////r7v+rrl8TFDKOkAH1+AElKAAAAACwAAAAADgAKAAADLWi63AQw
ynEMKCLrXEgFAraFgmdxm2iCpdhla8mpZRUQo0aYw+7/u8phSCwSEwA7
--------------080608040509010400010608--

--------------010307010606050407010809--


--===============1557272275571098684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1557272275571098684==--

