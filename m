From: "Syed Khader" <syedk@google.com>
Subject: autofs to load MAP from LDAP
Date: Thu, 9 Nov 2006 10:49:44 +0530
Message-ID: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3002372717927422802=="
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

--===============3002372717927422802==
Content-Type: multipart/alternative; 
	boundary="----=_Part_28892_28606044.1163049584328"

------=_Part_28892_28606044.1163049584328
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everybody,

How to make autofs read map from ldap rather than files.

I have changed the entries in nsswitch.conf file as LDAP.

Gone through OPENLDAP FAQ for fixing the init scripts but nothing works.

My ldap entries are as follows
The ldif for master is like this.

dn: ou=auto.master,dc=testlab,dc=com
objectClass:top
objectClass:automountMap
ou:auto.master

dn: cn=/home,ou=auto.master,dc=testlab,dc=com
objectClass:automount
cn:/home
automountInformation: ldap server.testlab.com:ou=auto.home,dc=testlab,dc=com
--timeout 60


Auto.Home

 dn: ou=auto.home,dc=testlab,dc=com
objectClass:top
objectClass:automountMap
ou:auto.home

dn: cn=user1,ou=auto.home,dc=testlab,dc=com
objectClass: automount
cn:user1
automountInformation: -fstype=nfs,hard,intr server.testlab.com:/home/user1

I'm using 4.1.3-155 version of autofs and Rhel4

when i say service autofs restart it says

no mount points defined but [OK]

when i see STATUS it says
no configured Mount points

/usr/lib/autofs/autofs-ldap-auto-master DOESn't give any ouput

Here's the ouput of sh -x \etc\init.d\autofs start

+ FLAGS='defaults 21'
+ DAEMON=/usr/sbin/automount
++ basename /usr/sbin/automount
+ prog=automount
+ initdir=/etc/rc.d/init.d
+ system=redhat
+ '[' redhat = redhat ']'
+ . /etc/rc.d/init.d/functions
++ TEXTDOMAIN=initscripts
++ umask 022
++ PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin
++ export PATH
++ '[' -z '' ']'
++ COLUMNS=80
++ '[' -z '' ']'
+++ /sbin/consoletype
++ CONSOLETYPE=pty
++ '[' -f /etc/sysconfig/i18n -a -z '' ']'
++ . /etc/sysconfig/i18n
+++ LANG=en_US.UTF-8
+++ SUPPORTED=en_US.UTF-8:en_US:en
+++ SYSFONT=latarcyrheb-sun16
++ '[' pty '!=' pty ']'
++ '[' -n '' ']'
++ export LANG
++ '[' -z '' ']'
++ '[' -f /etc/sysconfig/init ']'
++ . /etc/sysconfig/init
+++ BOOTUP=color
+++ GRAPHICAL=yes
+++ RES_COL=60
+++ MOVE_TO_COL='echo -en \033[60G'
+++ SETCOLOR_SUCCESS='echo -en \033[0;32m'
+++ SETCOLOR_FAILURE='echo -en \033[0;31m'
+++ SETCOLOR_WARNING='echo -en \033[0;33m'
+++ SETCOLOR_NORMAL='echo -en \033[0;39m'
+++ LOGLEVEL=3
+++ PROMPT=yes
++ '[' pty = serial ']'
++ '[' color '!=' verbose ']'
++ INITLOG_ARGS=-q
+ test -e /usr/sbin/automount
+ '[' redhat = debian ']'
+ PATH=/sbin:/usr/sbin:/bin:/usr/bin
+ export PATH
+ LOCALOPTIONS=
+ DAEMONOPTIONS=
+ UNDERSCORETODOT=1
+ DISABLE_DIRECT=1
+ ONE_AUTO_MASTER=0
+ DAEMON_EXIT_WAIT=34
+ GHOSTDIRS=
+ . /etc/sysconfig/autofs
++ LOCALOPTIONS=
++ DAEMONOPTIONS=--timeout=60
++ UNDERSCORETODOT=1
++ DISABLE_DIRECT=1
++ ONE_AUTO_MASTER=0
++ GHOSTDIRS=
+ RETVAL=0
+ '[' redhat = debian ']'
+ '[' redhat = redhat ']'
+ redhat start
+ case "$1" in
+ echo -n 'Starting automount: '
++ mktemp /tmp/autofs.XXXXXX
+ TMP=/tmp/autofs.TGH486
+ getmounts
+ local LC_ALL=C
+ export LC_ALL
+ knownmaps=' '
++ echo ''
++ sed 's/ /\|/g'
+ ghostdirs=
+ getrawmounts
++ getschemes
++ grep '^automount:' /etc/nsswitch.conf
+ read dir map options
+ tee /tmp/autofs.TGH486
+ WARN=0
+ SUCCESS=0
+ read cmd rest
++ sed -e 's/^.*://' -e 's/\[.*\]/ /g'
+ for scheme in '`getschemes`'
+ case "$scheme" in
+ '[' -z '' ']'
++ getldapmounts
++ '[' -x /usr/lib/autofs/autofs-ldap-auto-master ']'
++ /usr/lib/autofs/autofs-ldap-auto-master
+ LDAPMOUNTS=
+ '[' -n '' ']'
+ getldapmounts
+ '[' -x /usr/lib/autofs/autofs-ldap-auto-master ']'
+ /usr/lib/autofs/autofs-ldap-auto-master
+ ldapscheme=1
+ export ldapscheme
+ '[' 0 = 0 ']'
+ exit 2
+ RETVAL=2
+ '[' -s /tmp/autofs.TGH486 ']'
+ echo -n 'No Mountpoints Defined'
+ success 'automount startup'
+ '[' -z '' ']'
+ initlog -q -n /etc/init.d/autofs -s 'automount startup' -e 1
+ '[' color '!=' verbose -a -z '' ']'
+ echo_success
+ '[' color = color ']'
+ echo -en '\033[60G'
+ echo -n '[  '
+ '[' color = color ']'
+ echo -en '\033[0;32m'
+ echo -n OK
+ '[' color = color ']'
+ echo -en '\033[0;39m'
+ echo -n '  ]'
+ echo -ne '\r'
+ return 0
+ return 0
+ rm -f /tmp/autofs.TGH486
+ echo
+ exit 2

PLEASE HELP.

Thanks,
ABDUL.

------=_Part_28892_28606044.1163049584328
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everybody,<br><br>How to make autofs read map from ldap rather than files.<br><br>I have changed the entries in nsswitch.conf file as LDAP.<br><br>Gone through OPENLDAP FAQ for fixing the init scripts but nothing works.
<br><br>My ldap entries are as follows<br><div>The ldif for master is like this.</div>
<div>&nbsp;</div>
<div>dn: ou=auto.master,dc=testlab,dc=com</div>
<div>objectClass:top</div>
<div>objectClass:automountMap</div>
<div>ou:auto.master</div>
<div>&nbsp;</div>
<div>dn: cn=/home,ou=auto.master,dc=testlab,dc=com</div>
<div>objectClass:automount</div>
<div>cn:/home</div>
<div>automountInformation: ldap server.testlab.com:ou=auto.home,dc=testlab,dc=com --timeout 60</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Auto.Home</div>
<div>&nbsp;</div>
<div>
<div>dn: ou=auto.home,dc=testlab,dc=com</div>
<div>objectClass:top</div>
<div>objectClass:automountMap</div>
<div>ou:auto.home</div>
<div>&nbsp;</div>
<div>dn: cn=user1,ou=auto.home,dc=testlab,dc=com</div>
<div>objectClass: automount</div>
<div>cn:user1</div>
<div>automountInformation: -fstype=nfs,hard,intr server.testlab.com:/home/user1</div></div>
<div>&nbsp;</div>
<div>I'm using 4.1.3-155 version of autofs and Rhel4<br><br>when i say service autofs restart it says<br><br>no mount points defined but [OK]<br><br>when i see STATUS it says<br>no configured Mount points<br><br>/usr/lib/autofs/autofs-ldap-auto-master DOESn't give any ouput
<br><br><div>Here's the ouput of sh -x \etc\init.d\autofs start</div>
<div>&nbsp;</div>
<div>+ FLAGS='defaults 21'<br>+ DAEMON=/usr/sbin/automount<br>++ basename /usr/sbin/automount<br>+ prog=automount<br>+ initdir=/etc/rc.d/init.d<br>+ system=redhat<br>+ '[' redhat = redhat ']'<br>+ . /etc/rc.d/init.d/functions
<br>++ TEXTDOMAIN=initscripts<br>++ umask 022<br>++ PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin<br>++ export PATH<br>++ '[' -z '' ']'<br>++ COLUMNS=80<br>++ '[' -z '' ']'<br>+++ /sbin/consoletype<br>++ CONSOLETYPE=pty
<br>++ '[' -f /etc/sysconfig/i18n -a -z '' ']'<br>++ . /etc/sysconfig/i18n<br>+++ LANG=en_US.UTF-8<br>+++ SUPPORTED=en_US.UTF-8:en_US:en<br>+++ SYSFONT=latarcyrheb-sun16<br>++ '[' pty '!=' pty ']'<br>++ '[' -n '' ']'<br>
++ export LANG
<br>++ '[' -z '' ']'<br>++ '[' -f /etc/sysconfig/init ']'<br>++ . /etc/sysconfig/init<br>+++ BOOTUP=color<br>+++ GRAPHICAL=yes<br>+++ RES_COL=60<br>+++ MOVE_TO_COL='echo -en \033[60G'<br>+++ SETCOLOR_SUCCESS='echo -en \033[0;32m'
<br>+++ SETCOLOR_FAILURE='echo -en \033[0;31m'<br>+++ SETCOLOR_WARNING='echo -en \033[0;33m'<br>+++ SETCOLOR_NORMAL='echo -en \033[0;39m'<br>+++ LOGLEVEL=3<br>+++ PROMPT=yes<br>++ '[' pty = serial ']'<br>++ '[' color '!=' verbose ']'
<br>++ INITLOG_ARGS=-q<br>+ test -e /usr/sbin/automount<br>+ '[' redhat = debian ']'<br>+ PATH=/sbin:/usr/sbin:/bin:/usr/bin<br>+ export PATH<br>+ LOCALOPTIONS=<br>+ DAEMONOPTIONS=<br>+ UNDERSCORETODOT=1<br>+ DISABLE_DIRECT=1
<br>+ ONE_AUTO_MASTER=0<br>+ DAEMON_EXIT_WAIT=34<br>+ GHOSTDIRS=<br>+ . /etc/sysconfig/autofs<br>++ LOCALOPTIONS=<br>++ DAEMONOPTIONS=--timeout=60<br>++ UNDERSCORETODOT=1<br>++ DISABLE_DIRECT=1<br>++ ONE_AUTO_MASTER=0<br>

++ GHOSTDIRS=<br>+ RETVAL=0<br>+ '[' redhat = debian ']'<br>+ '[' redhat = redhat ']'<br>+ redhat start<br>+ case &quot;$1&quot; in<br>+ echo -n 'Starting automount: '<br>++ mktemp /tmp/autofs.XXXXXX<br>+ TMP=/tmp/autofs.TGH486
<br>+ getmounts<br>+ local LC_ALL=C<br>+ export LC_ALL<br>+ knownmaps=' '<br>++ echo ''<br>++ sed 's/ /\|/g'<br>+ ghostdirs=<br>+ getrawmounts<br>++ getschemes<br>++ grep '^automount:' /etc/nsswitch.conf<br>+ read dir map options
<br>+ tee /tmp/autofs.TGH486<br>+ WARN=0<br>+ SUCCESS=0<br>+ read cmd rest<br>++ sed -e 's/^.*://' -e 's/\[.*\]/ /g'<br>+ for scheme in '`getschemes`'<br>+ case &quot;$scheme&quot; in<br>+ '[' -z '' ']'<br>++ getldapmounts
<br>++ '[' -x /usr/lib/autofs/autofs-ldap-auto-master ']'<br>++ /usr/lib/autofs/autofs-ldap-auto-master<br>+ LDAPMOUNTS=<br>+ '[' -n '' ']'<br>+ getldapmounts<br>+ '[' -x /usr/lib/autofs/autofs-ldap-auto-master ']'<br>+ /usr/lib/autofs/autofs-ldap-auto-master
<br>+ ldapscheme=1<br>+ export ldapscheme<br>+ '[' 0 = 0 ']'<br>+ exit 2<br>+ RETVAL=2<br>+ '[' -s /tmp/autofs.TGH486 ']'<br>+ echo -n 'No Mountpoints Defined'<br>+ success 'automount startup'<br>+ '[' -z '' ']'<br>+ initlog -q -n /etc/init.d/autofs -s 'automount startup' -e 1
<br>+ '[' color '!=' verbose -a -z '' ']'<br>+ echo_success<br>+ '[' color = color ']'<br>+ echo -en '\033[60G'<br>+ echo -n '[&nbsp; '<br>+ '[' color = color ']'<br>+ echo -en '\033[0;32m'<br>+ echo -n OK<br>+ '[' color = color ']'
<br>+ echo -en '\033[0;39m'<br>+ echo -n '&nbsp; ]'<br>+ echo -ne '\r'<br>+ return 0<br>+ return 0<br>+ rm -f /tmp/autofs.TGH486<br>+ echo<br>+ exit 2<br><br>PLEASE HELP.<br><br>Thanks,<br>ABDUL.<br></div><br><br><br></div><br>

<br><br>




------=_Part_28892_28606044.1163049584328--


--===============3002372717927422802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3002372717927422802==--

