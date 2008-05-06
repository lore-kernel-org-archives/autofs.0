From: Luciana Romeiro Rodrigues <luciana.romeiro@cptec.inpe.br>
Subject: autofs and ldap
Date: Tue, 06 May 2008 10:14:51 -0300
Message-ID: <482059CB.8050808@cptec.inpe.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2981094570694235248=="
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============2981094570694235248==
Content-Type: multipart/alternative;
	boundary="------------040007070606080505020903"

This is a multi-part message in MIME format.
--------------040007070606080505020903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I run SLES 10.0 with openldap-stable-20071118.

Could anyone offer me some advice, or point me in the right direction?

Thanks,

Luciana




Follows the settings:


1- /etc/nsswitch.conf:
automount: ldap

2- ldif:

dn: ou=automount,dc=cp,dc=br
ou: automount
objectClass: top
objectClass: organizationalUnit

dn: ou=auto.master,ou=automount,dc=cp,dc=br
ou: auto.master
objectClass: top
objectClass: automountMap

dn: cn=/home, ou=auto.master,ou=automount,dc=cp,dc=br
objectClass: top
objectClass: automount
automountInformation: ldap: server-ldap.cp.br:ou=auto.home,ou=automount,dc=
cp,dc=br
cn: /home

dn: ou=auto.home, ou=automount,dc=cp,dc=br
ou: auto.home
objectClass: top
objectClass: automountMap


Users:

dn: uid=lu,ou=auto.home,ou=automount,dc=cp,dc=br
uid: lu
cn: teste
objectClass: automount
automountInformation: -rw,soft,retrans=10,intr  
nfsserver.cp.br:/extra/home/lu

3- /etc/ldap.conf

host    127.0.0.1 
base    dc=cp,dc=br


4-

tembiru:/home # service autofs status

Checking for service autofs:                                         unused

Configured Mount Points:

------------------------

/usr/sbin/automount  /home ldap: 
"server-ldap.cp.br:ou=auto.home,ou=automount,dc=cp,dc=br"

Active Mount Points:

 

5- su - lu
 warning: cannot change directory to /home/lu: No such file or directory




-- 
========================================================
Luciana F.Romeiro Rodrigues
Analista de Suporte
Fone: 3186-8513 - 

Novo Email: luciana.romeiro@cptec.inpe.br
========================================================


--------------040007070606080505020903
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi!<br>
<pre class="moz-signature" cols="72">I run SLES 10.0 with <span
 style="font-size: 12pt; font-family: &quot;Times New Roman&quot;;" lang="EN-US">openldap-stable-20071118.

Could anyone offer me some advice, or point me in the right direction?

</span>Thanks,

Luciana



</pre>
<div id="result_box" dir="ltr">Follows the settings:</div>
<br>
<span style="font-size: 12pt; font-family: &quot;Times New Roman&quot;;"
 lang="EN-US"><br>
1- /etc/nsswitch.conf:<br>
automount: ldap<br>
<br>
2- ldif:<br>
<br>
dn: ou=automount,dc=cp,dc=br<br>
ou: automount<br>
objectClass: top<br>
objectClass: organizationalUnit<br>
<br>
dn: ou=auto.master,ou=automount,dc=cp,dc=br<br>
ou: auto.master<br>
objectClass: top<br>
objectClass: automountMap<br>
<br>
dn: cn=/home, ou=auto.master,ou=automount,dc=cp,dc=br<br>
objectClass: top<br>
objectClass: automount<br>
automountInformation: ldap:
server-ldap.cp.br:ou=auto.home,ou=automount,dc=<br>
cp,dc=br<br>
cn: /home<br>
<br>
dn: ou=auto.home, ou=automount,dc=cp,dc=br<br>
ou: auto.home<br>
objectClass: top<br>
objectClass: automountMap<br>
<br>
<br>
Users:<br>
<br>
dn: uid=lu,ou=auto.home,ou=automount,dc=cp,dc=br<br>
uid: lu<br>
cn: teste<br>
objectClass: automount<br>
automountInformation: -rw,soft,retrans=10,intr&nbsp;
nfsserver.cp.br:/extra/home/lu<br>
<br>
3- /etc/ldap.conf<br>
<br>
host&nbsp;&nbsp;&nbsp; 127.0.0.1&nbsp;<br>
base&nbsp;&nbsp;&nbsp; dc=cp,dc=br<br>
<br>
<br>
4-<br>
</span>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US">tembiru:/home
#
service autofs status</span><span style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US">Checking
for
service autofs:<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>unused</span><span
 style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US">Configured
Mount
Points:</span><span style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US">------------------------</span><span
 style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US">/usr/sbin/automount<span
 style="">&nbsp; </span>/home ldap:
"server-ldap.cp.br:ou=auto.home,ou=automount,dc=cp,dc=br"</span><span
 style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US">Active
Mount
Points:</span><span style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size: 12pt;" lang="EN-US"><span
 style="">&nbsp;</span></span><span style="font-size: 12pt;" lang="EN-US"><o:p></o:p></span></p>
5- su - lu<br>
&nbsp;warning: cannot change directory to /home/lu: No such file or directory<br>
<br>
<br>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
========================================================
Luciana F.Romeiro Rodrigues
Analista de Suporte
Fone: 3186-8513 - 

Novo Email: <a class="moz-txt-link-abbreviated" href="mailto:luciana.romeiro@cptec.inpe.br">luciana.romeiro@cptec.inpe.br</a>
========================================================
</pre>
</body>
</html>

--------------040007070606080505020903--


--===============2981094570694235248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2981094570694235248==--

