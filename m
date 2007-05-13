From: Phy Prabab <phyprabab@yahoo.com>
Subject: autofs5 + ldap
Date: Sat, 12 May 2007 22:35:54 -0700 (PDT)
Message-ID: <370788.91736.qm@web90501.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5301685806653618612=="
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

--===============5301685806653618612==
Content-Type: multipart/alternative; boundary="0-1642668879-1179034554=:91736"

--0-1642668879-1179034554=:91736
Content-Type: text/plain; charset=ascii

Hello!

I am having some issues with autofs5 + ldap configuration, I just can not seem to get autofs to read the auto_master map out of ldap.  I have tried unsuccessfully using the "samples" and my previous configuration (autofs414 which does work with ldap).  I tried to use the /etc/sysconfig/autofs config file paralleling the sample but using my ldap settings as well as using /etc/auto.master again using my ldap settings, both to no avail.  I know the ldap settings are correct, I can search the ldap server without any issues and I am using it to authenticate (i.e. passwords).

If anyone could lend me a suggestion, I would be most grateful.
TIA,
Phy


[root@b~]# cat /etc/auto.master
dn: automountMapName=auto_master,ou=automount,ou=defaults,ou=sanjose,ou=services,o=cadence.com
objectClass: top
objectClass: automountMap
automountMapName: auto_master
#+auto.master
[root@b ~]# 

[root@b ~]# /usr/sbin/automount --version

Linux automount version 5.0.1

Directories:
        config dir:     /etc/sysconfig
        maps dir:       /etc
        modules dir:    /usr/local/autofs501p1/lib/autofs

Compile options:
  ENABLE_IGNORE_BUSY_MOUNTS WITH_LDAP 

[root@b ~]# ldapsearch -x -b 'ou=default,ou=region,o=test.com' automountMapName=auto_master
version: 2

#
# filter: automountMapName=auto_master
# requesting: ALL
#

# auto_master, automount, Default, region, test.com
dn: automountMapName=auto_master,ou=automount,ou=Default,ou=region,ou=test.com
objectClass: top
objectClass: automountMap
objectClass: nisMap
automountMapName: auto_master
nisMapName: auto_master

# search result
search: 2
result: 0 Success

# numResponses: 2
# numEntries: 1
[root@b ~]# uname -a
Linux host1.test.com 2.6.21.1 #1 SMP Wed May 9 08:54:29 PDT 2007 i686 athlon i386 GNU/Linux
[root@b ~]#





       
____________________________________________________________________________________Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
--0-1642668879-1179034554=:91736
Content-Type: text/html; charset=ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hello!<br><br>I am having some issues with autofs5 + ldap configuration, I just can not seem to get autofs to read the auto_master map out of ldap.&nbsp; I have tried unsuccessfully using the "samples" and my previous configuration (autofs414 which does work with ldap).&nbsp; I tried to use the /etc/sysconfig/autofs config file paralleling the sample but using my ldap settings as well as using /etc/auto.master again using my ldap settings, both to no avail.&nbsp; I know the ldap settings are correct, I can search the ldap server without any issues and I am using it to authenticate (i.e. passwords).<br><br>If anyone could lend me a suggestion, I would be most grateful.<br>TIA,<br>Phy<br><br><br>[root@b~]# cat /etc/auto.maste
 r<br>dn:
 automountMapName=auto_master,ou=automount,ou=defaults,ou=sanjose,ou=services,o=cadence.com<br>objectClass: top<br>objectClass: automountMap<br>automountMapName: auto_master<br>#+auto.master<br>[root@b ~]# <br><br>[root@b ~]# /usr/sbin/automount --version<br><br>Linux automount version 5.0.1<br><br>Directories:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config dir:&nbsp;&nbsp;&nbsp;&nbsp; /etc/sysconfig<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maps dir:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /etc<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modules dir:&nbsp;&nbsp;&nbsp; /usr/local/autofs501p1/lib/autofs<br><br>Compile options:<br>&nbsp; ENABLE_IGNORE_BUSY_MOUNTS WITH_LDAP <br><br>[root@b ~]# ldapsearch -x -b 'ou=default,ou=region,o=test.com' automountMapName=auto_master<br>version: 2<br><br>#<br># filter: automountMapName=auto_master<br># requesting: ALL<br>#<br><br># auto_master,
  automount, Default, region, test.com<br>dn:
 automountMapName=auto_master,ou=automount,ou=Default,ou=region,ou=test.com<br>objectClass: top<br>objectClass: automountMap<br>objectClass: nisMap<br>automountMapName: auto_master<br>nisMapName: auto_master<br><br># search result<br>search: 2<br>result: 0 Success<br><br># numResponses: 2<br># numEntries: 1<br>[root@b ~]# uname -a<br>Linux host1.test.com 2.6.21.1 #1 SMP Wed May 9 08:54:29 PDT 2007 i686 athlon i386 GNU/Linux<br>[root@b ~]#<br><br></div></div><br>
      <hr size=1>Luggage? GPS? Comic books? <br>
Check out fitting <a href="http://us.rd.yahoo.com/evt=48249/*http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz"> gifts for grads</a> at Yahoo! Search.</body></html>
--0-1642668879-1179034554=:91736--


--===============5301685806653618612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5301685806653618612==--

