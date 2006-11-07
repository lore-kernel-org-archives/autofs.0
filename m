From: "Syed Khader" <syedk@google.com>
Subject: Re: problem with autofs
Date: Tue, 7 Nov 2006 21:02:19 +0530
Message-ID: <29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5057446984984637154=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162912613.18975.59.camel@localhost>
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

--===============5057446984984637154==
Content-Type: multipart/alternative; 
	boundary="----=_Part_5275_25713365.1162913539935"

------=_Part_5275_25713365.1162913539935
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,

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

AND  /usr/lib[64]/autofs/autofs-ldap-auto-master DOESn't give any ouput

Thanks,
Abdul


On 11/7/06, Ian Kent <raven@themaw.net> wrote:
>
> On Tue, 2006-11-07 at 09:47 -0500, Jeff Moyer wrote:
> > syedk> /home ldap:server.testlab.com:ou=auto.home,dc=testlab,dc=com
> >
> > syedk> in the /etc/auto.master file and say Service autofs status
> >
> > syedk> Then i see the mount point as the above.But when i try to login
> on the
> > syedk> client side.Still it doesn't mount the user's home directory.
>
> You refer to "the client side", you do mean the client that is running
> autofs with the configuration you describe above, don't you?
>
> Ian
>
>
>

------=_Part_5275_25713365.1162913539935
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Jeff,</div>
<div>&nbsp;</div>
<div>Here's the ouput of sh -x \etc\init.d\autofs start</div>
<div>&nbsp;</div>
<div>+ FLAGS='defaults 21'<br>+ DAEMON=/usr/sbin/automount<br>++ basename /usr/sbin/automount<br>+ prog=automount<br>+ initdir=/etc/rc.d/init.d<br>+ system=redhat<br>+ '[' redhat = redhat ']'<br>+ . /etc/rc.d/init.d/functions
<br>++ TEXTDOMAIN=initscripts<br>++ umask 022<br>++ PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin<br>++ export PATH<br>++ '[' -z '' ']'<br>++ COLUMNS=80<br>++ '[' -z '' ']'<br>+++ /sbin/consoletype<br>++ CONSOLETYPE=pty
<br>++ '[' -f /etc/sysconfig/i18n -a -z '' ']'<br>++ . /etc/sysconfig/i18n<br>+++ LANG=en_US.UTF-8<br>+++ SUPPORTED=en_US.UTF-8:en_US:en<br>+++ SYSFONT=latarcyrheb-sun16<br>++ '[' pty '!=' pty ']'<br>++ '[' -n '' ']'<br>++ export LANG
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
<br>+ echo -en '\033[0;39m'<br>+ echo -n '&nbsp; ]'<br>+ echo -ne '\r'<br>+ return 0<br>+ return 0<br>+ rm -f /tmp/autofs.TGH486<br>+ echo<br>+ exit 2</div>
<div>&nbsp;</div>
<div>AND&nbsp;&nbsp;/usr/lib[64]/autofs/autofs-ldap-auto-master DOESn't give any ouput</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Abdul<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Ian Kent</b> &lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Tue, 2006-11-07 at 09:47 -0500, Jeff Moyer wrote:<br>&gt; syedk&gt; /home ldap:server.testlab.com:ou=auto.home
,dc=testlab,dc=com<br>&gt;<br>&gt; syedk&gt; in the /etc/auto.master file and say Service autofs status<br>&gt;<br>&gt; syedk&gt; Then i see the mount point as the above.But when i try to login on the<br>&gt; syedk&gt; client 
side.Still it doesn't mount the user's home directory.<br><br>You refer to &quot;the client side&quot;, you do mean the client that is running<br>autofs with the configuration you describe above, don't you?<br><br>Ian<br>
<br><br></blockquote></div><br>

------=_Part_5275_25713365.1162913539935--


--===============5057446984984637154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5057446984984637154==--

