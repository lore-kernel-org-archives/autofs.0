From: Krishna <krischa2000@yahoo.com>
Subject: unable to mount /net to RHEL4 from sunos5.8
Date: Thu, 13 Oct 2005 02:42:15 -0700 (PDT)
Message-ID: <20051013094215.25099.qmail@web52204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-749466982-1129196535=:23473"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

--0-749466982-1129196535=:23473
Content-Type: multipart/alternative; boundary="0-1879032673-1129196535=:23473"

--0-1879032673-1129196535=:23473
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id j9FAY4qS004267

Hi all ,
=20
Could you please address my issue. i am facing problems in mounting /net.=
 The server is sunos5.8 and my client is RHEL4.
=20
I have attached the /var/log/debug file for your reference.
=20
I am facing some issues in mounting the /net directory from the Solaris s=
erver (SunOS 5.8) to my RHEL4. I am trying to automount the /net director=
y to download VOB files to my local RHEL4 client. The Autofs version i ha=
ve in my RHEL4 client is autofs-4.1.3-67.I am not sure if i have to apply=
 a patch to the existing autofs version, since you have discussed extensi=
vely about apply patches for autofs4, i am raising this query.=20
=20
Do you have any whitepaper that gives me in detail to steps for mount the=
 /net non sharable filesystem? I was told that /net cannot be shared to h=
ard mount.=20
=20
will there be any configuration on the sunos server to add my client name=
 for mounting /net ??
=20
Could you please give me a solution to this problem. i have been trying t=
o fix this issue for quite sometime!
\r\n=A0
\r\ni am copying my auto.master and auto.net file here...\r\n
\r\n=A0
\r\nmy auto.master file says following
\r\n=A0
\r\n#
# $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
\r\n# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/misc=A0 /etc/auto.misc --timeout=3D60
#/misc=A0 /etc/auto.misc
/net=A0=A0=A0 /etc/auto.net

\r\nmy auto.net file says
\r\n=A0
\r\n\r\n
#!/bin/sh
\r\n
# $Id: auto.net,v 1.5 2003/09/29 08:22:35 raven Exp $
\r\n
# Look at what a host is exporting to determine what we can mount.
# This is very simple, but it appears to work surprisingly well
\r\n
key=3D"$1"
\r\n
# add "nosymlink" here if you want to suppress symlinking local filesyste=
ms
# add "nonstrict" to make it OK for some filesystems to not mount
opts=3D"-fstype=3Dnfs,hard,intr,nodev,nosuid" \r\n
\r\n
# Showmount comes in a number of names and varieties.=A0 "showmount" is",=
1]);//-->=20
=20
i am copying my auto.master and auto.net file here...=20
=20
my auto.master file says following
=20
#
# $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/misc  /etc/auto.misc --timeout=3D60
#/misc  /etc/auto.misc
/net    /etc/auto.net

my auto.net file says
=20

#!/bin/sh

# $Id: auto.net,v 1.5 2003/09/29 08:22:35 raven Exp $

# Look at what a host is exporting to determine what we can mount.
# This is very simple, but it appears to work surprisingly well

key=3D"$1"

# add "nosymlink" here if you want to suppress symlinking local filesyste=
ms
# add "nonstrict" to make it OK for some filesystems to not mount
opts=3D"-fstype=3Dnfs,hard,intr,nodev,nosuid"=20

# Showmount comes in a number of names and varieties.  "showmount" is# ty=
pically an older version which accepts the \'--no-headers\' flag
# but ignores it.=A0 "kshowmount" is the newer version installed with knf=
sd, \r\n
# which both accepts and acts on the \'--no-headers\' flag.
#SHOWMOUNT=3D"kshowmount --no-headers -e $key"
#SHOWMOUNT=3D"showmount -e $key | tail +2"
\r\n
# Newer distributions get this right
SHOWMOUNT=3D"/usr/sbin/showmount --no-headers -e $key"
\r\n
$SHOWMOUNT | sort +0 | \\
=A0=A0=A0=A0=A0=A0=A0 awk -v key=3D"$key" -v opts=3D"$opts" -- \'
=A0=A0=A0=A0=A0=A0=A0 BEGIN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { ORS=3D""; fir=
st=3D1 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { i=
f (first) { print opts; first=3D0 }; print " \r\n\\\\\\n\\t" $1, key ":" =
$1 }
=A0=A0=A0=A0=A0=A0=A0 END=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { if (!firs=
t) print "\\n"; else exit 1 }
=A0=A0=A0=A0=A0=A0=A0 \'


\r\n=A0
\r\nand nsswitch.conf for automount is configured for files.
\r\n=A0
\r\n
--=20
Kind regards
Krishna.

",1]);//-->=20
# typically an older version which accepts the '--no-headers' flag
# but ignores it.  "kshowmount" is the newer version installed with knfsd=
,=20
# which both accepts and acts on the '--no-headers' flag.
#SHOWMOUNT=3D"kshowmount --no-headers -e $key"
#SHOWMOUNT=3D"showmount -e $key | tail +2"

# Newer distributions get this right
SHOWMOUNT=3D"/usr/sbin/showmount --no-headers -e $key"

$SHOWMOUNT | sort +0 | \
        awk -v key=3D"$key" -v opts=3D"$opts" -- '
        BEGIN           { ORS=3D""; first=3D1 }
                        { if (first) { print opts; first=3D0 }; print " \=
\\n\t" $1, key ":" $1 }
        END             { if (!first) print "\n"; else exit 1 }
        '


=20
and nsswitch.conf for automount is configured for files.
=20

--=20
Kind regards
Krishna.



--=20
Kind regards
Krishna.

Krishna Prasadh Venkataraman
krishnap.venkataraman@gmail.com
\r\n\r\n",0]);D(["ma","debug
148K View Download "]);D(["ce"]);D(["ms","7a0"]);//-->


	=09
---------------------------------
 Yahoo! Music Unlimited - Access over 1 million songs. Try it free.
--0-1879032673-1129196535=:23473
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id j9FAY4qS004267

<DIV>
<DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"trebuchet ms">Hi&nbsp;al=
l ,</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">Could you =
please address my issue. i am facing problems in mounting /net. The serve=
r is sunos5.8 and my client is RHEL4.</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">I have att=
ached the /var/log/debug file for your reference.</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"trebuchet ms">I am facin=
g some issues in mounting the /net directory from the Solaris server (Sun=
OS 5.8) to my RHEL4. I am trying to automount the /net directory to downl=
oad VOB files to my local RHEL4 client. The Autofs version i have in my R=
HEL4 client is autofs-4.1.3-67.</FONT></SPAN><SPAN title=3D"Jeffrey Moyer=
"><FONT face=3D"Trebuchet MS">I&nbsp;am not sure&nbsp;if i have to apply =
a patch to the existing autofs version, since you have discussed extensiv=
ely about apply patches for autofs4, i am raising this query. </FONT></SP=
AN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">Do you hav=
e any whitepaper that gives me in detail to steps for mount the /net non =
sharable filesystem? I was told that /net cannot be shared to hard mount.=
</FONT> </SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">will there=
 be any configuration on the sunos server to add my client name for mount=
ing /net ??</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">Could you =
please give me a solution to this problem. i have been trying to fix this=
 issue for quite sometime!
<SCRIPT><!--
D(["mb","</font></span></div>\r\n<div><span title=3D\"Jeffrey Moyer\"><fo=
nt face=3D\"Trebuchet MS\"></font></span>=A0</div>\r\n<div><span title=3D=
\"Jeffrey Moyer\"><font face=3D\"Trebuchet MS\">i am copying my auto.mast=
er and <a href=3D\"http://auto.net/\" target=3D\"_blank\" onclick=3D\"ret=
urn top.js.OpenExtLink(window,event,this)\">auto.net</a> file here...</fo=
nt>\r\n</span></div>\r\n<div><span title=3D\"Jeffrey Moyer\"><font face=3D=
\"Trebuchet MS\"></font></span>=A0</div>\r\n<div><span title=3D\"Jeffrey =
Moyer\"><font face=3D\"Trebuchet MS\">my auto.master file says following<=
/font></span></div>\r\n<div><span title=3D\"Jeffrey Moyer\"><font face=3D=
\"Trebuchet MS\"></font></span>=A0</div>\r\n<div><span title=3D\"Jeffrey =
Moyer\"><font face=3D\"trebuchet ms\">#<br># $Id: auto.master,v 1.3 2003/=
09/29 08:22:35 raven Exp $<br>#<br># Sample auto.master file<br># This is=
 an automounter map and it has the following format<br>\r\n# key [ -mount=
-options-separated-by<WBR>-comma ] location<br># For details of the forma=
t look at
 autofs(5).<br>#/misc=A0 /etc/auto.misc --timeout=3D60<br>#/misc=A0 /etc/=
auto.misc<br>/net=A0=A0=A0 /etc/auto.net<br></font></span></div>\r\n<div>=
<span title=3D\"Jeffrey Moyer\"><font face=3D\"trebuchet ms\">my <a href=3D=
\"http://auto.net/\" target=3D\"_blank\" onclick=3D\"return top.js.OpenEx=
tLink(window,event,this)\">auto.net</a> file says</font></span></div>\r\n=
<div><span title=3D\"Jeffrey Moyer\"><font face=3D\"trebuchet ms\"></font=
></span>=A0</div>\r\n<div><span title=3D\"Jeffrey Moyer\"><font face=3D\"=
trebuchet ms\">\r\n<p>#!/bin/sh</p>\r\n<p># $Id: <a href=3D\"http://auto.=
net/\" target=3D\"_blank\" onclick=3D\"return top.js.OpenExtLink(window,e=
vent,this)\">auto.net</a>,v 1.5 2003/09/29 08:22:35 raven Exp $</p>\r\n<p=
># Look at what a host is exporting to determine what we can mount.<br># =
This is very simple, but it appears to work surprisingly well</p>\r\n<p>k=
ey=3D&quot;$1&quot;</p>\r\n<p># add &quot;nosymlink&quot; here if you wan=
t to suppress symlinking local filesystems<br># add &quot;nonstrict&quot;=
 to make it OK
 for some filesystems to not mount<br>opts=3D&quot;-fstype=3Dnfs,hard,int=
r<WBR>,nodev,nosuid&quot; \r\n</p>\r\n<p># Showmount comes in a number of=
 names and varieties.=A0 &quot;showmount&quot; is",1]
);

//--></SCRIPT>
 </FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">i am copyi=
ng my auto.master and <A onclick=3D"return top.js.OpenExtLink(window,even=
t,this)" href=3D"http://auto.net/" target=3D_blank>auto.net</A> file here=
...</FONT> </SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">my auto.ma=
ster file says following</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"trebuchet ms">#<BR># $Id=
: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $<BR>#<BR># Sample auto=
.master file<BR># This is an automounter map and it has the following for=
mat<BR># key [ -mount-options-separated-by<WBR>-comma ] location<BR># For=
 details of the format look at autofs(5).<BR>#/misc&nbsp; /etc/auto.misc =
--timeout=3D60<BR>#/misc&nbsp; /etc/auto.misc<BR>/net&nbsp;&nbsp;&nbsp; /=
etc/auto.net<BR></FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"trebuchet ms">my <A oncl=
ick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://auto.=
net/" target=3D_blank>auto.net</A> file says</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"trebuchet ms"></FONT></S=
PAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"trebuchet ms">
<P>#!/bin/sh</P>
<P># $Id: <A onclick=3D"return top.js.OpenExtLink(window,event,this)" hre=
f=3D"http://auto.net/" target=3D_blank>auto.net</A>,v 1.5 2003/09/29 08:2=
2:35 raven Exp $</P>
<P># Look at what a host is exporting to determine what we can mount.<BR>=
# This is very simple, but it appears to work surprisingly well</P>
<P>key=3D"$1"</P>
<P># add "nosymlink" here if you want to suppress symlinking local filesy=
stems<BR># add "nonstrict" to make it OK for some filesystems to not moun=
t<BR>opts=3D"-fstype=3Dnfs,hard,intr<WBR>,nodev,nosuid" </P>
<P># Showmount comes in a number of names and varieties.&nbsp; "showmount=
" is
<SCRIPT><!--
D(["mb","<br># typically an older version which accepts the \'--no-header=
s\' flag<br># but ignores it.=A0 &quot;kshowmount&quot; is the newer vers=
ion installed with knfsd, \r\n<br># which both accepts and acts on the \'=
--no-headers\' flag.<br>#SHOWMOUNT=3D&quot;kshowmount --no-headers -e $ke=
y&quot;<br>#SHOWMOUNT=3D&quot;showmount -e $key | tail +2&quot;</p>\r\n<p=
># Newer distributions get this right<br>SHOWMOUNT=3D&quot;/usr/sbin/show=
mount --no-headers -e $key&quot;</p>\r\n<p>$SHOWMOUNT | sort +0 | \\<br>=A0=
=A0=A0=A0=A0=A0=A0 awk -v key=3D&quot;$key&quot; -v opts=3D&quot;$opts&qu=
ot; -- \'<br>=A0=A0=A0=A0=A0=A0=A0 BEGIN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { =
ORS=3D&quot;&quot;; first=3D1 }<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { if (first) { print opts; first=3D0 }; pr=
int &quot; \r\n<a>\\\\\\n\\t</a>&quot; $1, key &quot;:&quot; $1 }<br>=A0=A0=
=A0=A0=A0=A0=A0 END=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { if (!first) pri=
nt &quot;\\n&quot;; else exit 1 }<br>=A0=A0=A0=A0=A0=A0=A0 \'<br></p></fo=
nt></span></div>\r\n<div><span title=3D\"Jeffrey Moyer\">=A0</span></div>=
\r\n<div><span title=3D\"Jeffrey Moyer\"><font face=3D\"Trebuchet
 MS\">and nsswitch.conf for automount is configured for files.</font></sp=
an></div>\r\n<div><span title=3D\"Jeffrey Moyer\"><font face=3D\"Trebuche=
t MS\"></font></span>=A0</div>\r\n<p>-- <br>Kind regards<br>Krishna.<br><=
/p>",1]
);

//--></SCRIPT>
 <BR># typically an older version which accepts the '--no-headers' flag<B=
R># but ignores it.&nbsp; "kshowmount" is the newer version installed wit=
h knfsd, <BR># which both accepts and acts on the '--no-headers' flag.<BR=
>#SHOWMOUNT=3D"kshowmount --no-headers -e $key"<BR>#SHOWMOUNT=3D"showmoun=
t -e $key | tail +2"</P>
<P># Newer distributions get this right<BR>SHOWMOUNT=3D"/usr/sbin/showmou=
nt --no-headers -e $key"</P>
<P>$SHOWMOUNT | sort +0 | \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 awk -v key=3D"$key" -v opts=3D"$opts" -- '<BR>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; BEGIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; { ORS=3D""; first=3D1 }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { if (first) { print opts; first=3D0 }; pri=
nt " <A>\\\n\t</A>" $1, key ":" $1 }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { if (!first) print "\n"; else exit 1 }<BR>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; '<BR></P></FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"></SPAN>&nbsp;</DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS">and nsswit=
ch.conf for automount is configured for files.</FONT></SPAN></DIV>
<DIV><SPAN title=3D"Jeffrey Moyer"><FONT face=3D"Trebuchet MS"></FONT></S=
PAN>&nbsp;</DIV>
<P>-- <BR>Kind regards<BR>Krishna.<BR></P>
<SCRIPT><!--
D(["mb","<span class=3Dsg><br clear=3D\"all\"><br>-- <br>Kind regards<br>=
Krishna.<br><br>Krishna Prasadh Venkataraman<br><a href=3D\"mailto:krishn=
ap.venkataraman@gmail.com\" target=3D\"_blank\" onclick=3D\"return top.js=
.OpenExtLink(window,event,this)\">krishnap.venkataraman@gmail.com</a><br>=
\r\n\r\n</span>",0]
);
D(["ma","<table class=3Datt cellspacing=3D0 cellpadding=3D5 border=3D0><t=
r><td colspan=3D2><table cellspacing=3D0 cellpadding=3D0><tr><td width=3D=
22><img width=3D16 height=3D16 src=3D\"/mail/images/txt.gif\"><td><b>debu=
g</b><br>148K <a target=3D_blank href=3D\"/mail/?view=3Datt&disp=3Dinline=
&attid=3D0.1&th=3D106e9591778f5ed7\">View</a> <a target=3D_blank href=3D\=
"/mail/?view=3Datt&disp=3Dattd&attid=3D0.1&th=3D106e9591778f5ed7\">Downlo=
ad</a> </tr></table></table>"]
);
D(["ce"]);
D(["ms","7a0"]
);

//--></SCRIPT>
</DIV></DIV><p>
		<hr size=3D1> <a href=3D"http://pa.yahoo.com/*http://us.rd.yahoo.com/ev=
t=3D36035/*http://music.yahoo.com/unlimited/">Yahoo! Music Unlimited - Ac=
cess over 1 million songs. Try it free.</a>
--0-1879032673-1129196535=:23473--

--0-749466982-1129196535=:23473
Content-Type: text/plain; name=debug
Content-Description: 115805988-debug
Content-Disposition: inline; filename=debug

Oct 11 17:08:27 Inblr-bislinux1 syslogd 1.4.1: restart.
Oct 11 17:08:27 Inblr-bislinux1 syslog: syslogd startup succeeded
Oct 11 17:08:27 Inblr-bislinux1 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 11 17:08:27 Inblr-bislinux1 syslog: klogd startup succeeded
Oct 11 17:08:27 Inblr-bislinux1 syslog: syslogd shutdown succeeded 
Oct 11 17:09:33 Inblr-bislinux1 automount[12507]: handle_packet: type = 0 
Oct 11 17:09:33 Inblr-bislinux1 automount[12507]: handle_packet_missing: token 113, name idps3 
Oct 11 17:09:33 Inblr-bislinux1 automount[12507]: attempting to mount entry /net/idps3
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: lookup(file): idps3 -> -fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6	idps3:/net/idps3
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: parse(sun): expanded entry: -fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6	idps3:/net/idps3
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: parse(sun): dequote("fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6") -> fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: parse(sun): gathered options: fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: parse(sun): dequote("idps3:/net/idps3") -> idps3:/net/idps3
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: parse(sun): core of entry: options=fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6, loc=idps3:/net/idps3
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: parse(sun): mounting root /net, mountpoint idps3, what idps3:/net/idps3, fstype nfs, options rsize=8192,wsize=8192,timeo=5,retrans=6 
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: mount(nfs):  root=/net name=idps3 what=idps3:/net/idps3, fstype=nfs, options=rsize=8192,wsize=8192,timeo=5,retrans=6
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: mount(nfs): nfs options="rsize=8192,wsize=8192,timeo=5,retrans=6", nosymlink=0
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: mount(nfs): winner = (null) local = 0
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: mount(nfs): no host elected
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: failed to mount /net/idps3
Oct 11 17:09:33 Inblr-bislinux1 automount[12614]: umount_multi: path=/net/idps3 incl=1 
Oct 11 17:09:33 Inblr-bislinux1 automount[12507]: handle_child: got pid 12614, sig 0 (0), stat 1 
Oct 11 17:09:33 Inblr-bislinux1 automount[12507]: sig_child: found pending iop pid 12614: signalled 0 (sig 0), exit status 1
Oct 11 17:09:33 Inblr-bislinux1 automount[12507]: send_fail: token=113 
Oct 11 17:13:36 Inblr-bislinux1 automount[12507]: handle_packet: type = 0 
Oct 11 17:13:36 Inblr-bislinux1 automount[12507]: handle_packet_missing: token 114, name idps3 
Oct 11 17:13:36 Inblr-bislinux1 automount[12507]: attempting to mount entry /net/idps3
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: lookup(file): idps3 -> -fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6	idps3:/net/idps3
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: parse(sun): expanded entry: -fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6	idps3:/net/idps3
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: parse(sun): dequote("fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6") -> fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: parse(sun): gathered options: fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: parse(sun): dequote("idps3:/net/idps3") -> idps3:/net/idps3
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: parse(sun): core of entry: options=fstype=nfs,rsize=8192,wsize=8192,timeo=5,retrans=6, loc=idps3:/net/idps3
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: parse(sun): mounting root /net, mountpoint idps3, what idps3:/net/idps3, fstype nfs, options rsize=8192,wsize=8192,timeo=5,retrans=6 
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: mount(nfs):  root=/net name=idps3 what=idps3:/net/idps3, fstype=nfs, options=rsize=8192,wsize=8192,timeo=5,retrans=6
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: mount(nfs): nfs options="rsize=8192,wsize=8192,timeo=5,retrans=6", nosymlink=0
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: mount(nfs): winner = (null) local = 0
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: mount(nfs): no host elected
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: failed to mount /net/idps3
Oct 11 17:13:36 Inblr-bislinux1 automount[12618]: umount_multi: path=/net/idps3 incl=1 
Oct 11 17:13:36 Inblr-bislinux1 automount[12507]: handle_child: got pid 12618, sig 0 (0), stat 1 
Oct 11 17:13:36 Inblr-bislinux1 automount[12507]: sig_child: found pending iop pid 12618: signalled 0 (sig 0), exit status 1
Oct 11 17:13:36 Inblr-bislinux1 automount[12507]: send_fail: token=114 
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12622
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12622, sig 0 (0), stat 0 
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12622 finished, switching from 2 to 1
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 17:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12623
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12623, sig 0 (0), stat 0 
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12623 finished, switching from 2 to 1
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 17:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 18:01:01 Inblr-bislinux1 crond(pam_unix)[12624]: session opened for user root by (uid=0)
Oct 11 18:01:01 Inblr-bislinux1 crond[12625]: (root) CMD (run-parts /etc/cron.hourly)
Oct 11 18:01:01 Inblr-bislinux1 crond(pam_unix)[12624]: session closed for user root
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12634
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12634, sig 0 (0), stat 0 
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12634 finished, switching from 2 to 1
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 18:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12635
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12635, sig 0 (0), stat 0 
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12635 finished, switching from 2 to 1
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 18:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12638
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12638, sig 0 (0), stat 0 
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12638 finished, switching from 2 to 1
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 18:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12639
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12639, sig 0 (0), stat 0 
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12639 finished, switching from 2 to 1
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 18:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 19:01:01 Inblr-bislinux1 crond(pam_unix)[12640]: session opened for user root by (uid=0)
Oct 11 19:01:01 Inblr-bislinux1 crond[12641]: (root) CMD (run-parts /etc/cron.hourly)
Oct 11 19:01:01 Inblr-bislinux1 crond(pam_unix)[12640]: session closed for user root
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12650
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12650, sig 0 (0), stat 0 
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12650 finished, switching from 2 to 1
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 19:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12651
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12651, sig 0 (0), stat 0 
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12651 finished, switching from 2 to 1
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 19:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12654
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12654, sig 0 (0), stat 0 
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12654 finished, switching from 2 to 1
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 19:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12655
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12655, sig 0 (0), stat 0 
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12655 finished, switching from 2 to 1
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 19:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 20:01:01 Inblr-bislinux1 crond(pam_unix)[12656]: session opened for user root by (uid=0)
Oct 11 20:01:01 Inblr-bislinux1 crond[12657]: (root) CMD (run-parts /etc/cron.hourly)
Oct 11 20:01:01 Inblr-bislinux1 crond(pam_unix)[12656]: session closed for user root
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12666
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12666, sig 0 (0), stat 0 
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12666 finished, switching from 2 to 1
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 20:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12667
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12667, sig 0 (0), stat 0 
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12667 finished, switching from 2 to 1
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 20:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12670
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12670, sig 0 (0), stat 0 
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12670 finished, switching from 2 to 1
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 20:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12671
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12671, sig 0 (0), stat 0 
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12671 finished, switching from 2 to 1
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 20:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 21:01:01 Inblr-bislinux1 crond(pam_unix)[12672]: session opened for user root by (uid=0)
Oct 11 21:01:01 Inblr-bislinux1 crond[12673]: (root) CMD (run-parts /etc/cron.hourly)
Oct 11 21:01:01 Inblr-bislinux1 crond(pam_unix)[12672]: session closed for user root
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12682
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12682, sig 0 (0), stat 0 
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12682 finished, switching from 2 to 1
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 21:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12683
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12683, sig 0 (0), stat 0 
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12683 finished, switching from 2 to 1
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 21:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12686
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12686, sig 0 (0), stat 0 
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12686 finished, switching from 2 to 1
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 21:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12687
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12687, sig 0 (0), stat 0 
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12687 finished, switching from 2 to 1
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 21:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 22:01:01 Inblr-bislinux1 crond(pam_unix)[12688]: session opened for user root by (uid=0)
Oct 11 22:01:01 Inblr-bislinux1 crond[12689]: (root) CMD (run-parts /etc/cron.hourly)
Oct 11 22:01:01 Inblr-bislinux1 crond(pam_unix)[12688]: session closed for user root
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12698
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12698, sig 0 (0), stat 0 
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12698 finished, switching from 2 to 1
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 22:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12699
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12699, sig 0 (0), stat 0 
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12699 finished, switching from 2 to 1
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 22:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12702
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12702, sig 0 (0), stat 0 
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12702 finished, switching from 2 to 1
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 22:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12703
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12703, sig 0 (0), stat 0 
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12703 finished, switching from 2 to 1
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 22:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 23:01:01 Inblr-bislinux1 crond(pam_unix)[12704]: session opened for user root by (uid=0)
Oct 11 23:01:01 Inblr-bislinux1 crond[12705]: (root) CMD (run-parts /etc/cron.hourly)
Oct 11 23:01:01 Inblr-bislinux1 crond(pam_unix)[12704]: session closed for user root
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12714
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12714, sig 0 (0), stat 0 
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12714 finished, switching from 2 to 1
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 23:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12715
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12715, sig 0 (0), stat 0 
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12715 finished, switching from 2 to 1
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 23:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12718
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12718, sig 0 (0), stat 0 
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12718 finished, switching from 2 to 1
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 23:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12719
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12719, sig 0 (0), stat 0 
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12719 finished, switching from 2 to 1
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 11 23:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 00:01:01 Inblr-bislinux1 crond(pam_unix)[12720]: session opened for user root by (uid=0)
Oct 12 00:01:01 Inblr-bislinux1 crond[12721]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 00:01:01 Inblr-bislinux1 crond(pam_unix)[12720]: session closed for user root
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12730
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12730, sig 0 (0), stat 0 
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12730 finished, switching from 2 to 1
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 00:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12731
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12731, sig 0 (0), stat 0 
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12731 finished, switching from 2 to 1
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 00:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12734
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12734, sig 0 (0), stat 0 
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12734 finished, switching from 2 to 1
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 00:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12735
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12735, sig 0 (0), stat 0 
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12735 finished, switching from 2 to 1
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 00:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 01:01:01 Inblr-bislinux1 crond(pam_unix)[12736]: session opened for user root by (uid=0)
Oct 12 01:01:01 Inblr-bislinux1 crond[12737]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 01:01:01 Inblr-bislinux1 crond(pam_unix)[12736]: session closed for user root
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12746
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12746, sig 0 (0), stat 0 
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12746 finished, switching from 2 to 1
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 01:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12747
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12747, sig 0 (0), stat 0 
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12747 finished, switching from 2 to 1
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 01:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12750
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12750, sig 0 (0), stat 0 
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12750 finished, switching from 2 to 1
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 01:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12751
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12751, sig 0 (0), stat 0 
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12751 finished, switching from 2 to 1
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 01:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 02:01:01 Inblr-bislinux1 crond(pam_unix)[12752]: session opened for user root by (uid=0)
Oct 12 02:01:01 Inblr-bislinux1 crond[12753]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 02:01:01 Inblr-bislinux1 crond(pam_unix)[12752]: session closed for user root
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12762
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12762, sig 0 (0), stat 0 
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12762 finished, switching from 2 to 1
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 02:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12763
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12763, sig 0 (0), stat 0 
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12763 finished, switching from 2 to 1
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 02:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12766
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12766, sig 0 (0), stat 0 
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12766 finished, switching from 2 to 1
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 02:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12767
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12767, sig 0 (0), stat 0 
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12767 finished, switching from 2 to 1
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 02:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 03:01:01 Inblr-bislinux1 crond(pam_unix)[12768]: session opened for user root by (uid=0)
Oct 12 03:01:01 Inblr-bislinux1 crond[12769]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 03:01:01 Inblr-bislinux1 crond(pam_unix)[12768]: session closed for user root
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12778
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12778, sig 0 (0), stat 0 
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12778 finished, switching from 2 to 1
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 03:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12779
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12779, sig 0 (0), stat 0 
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12779 finished, switching from 2 to 1
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 03:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12782
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12782, sig 0 (0), stat 0 
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12782 finished, switching from 2 to 1
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 03:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=12783
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 12783, sig 0 (0), stat 0 
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 12783 finished, switching from 2 to 1
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 03:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 04:01:01 Inblr-bislinux1 crond(pam_unix)[12784]: session opened for user root by (uid=0)
Oct 12 04:01:01 Inblr-bislinux1 crond[12785]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 04:01:01 Inblr-bislinux1 crond(pam_unix)[12784]: session closed for user root
Oct 12 04:02:01 Inblr-bislinux1 crond(pam_unix)[12794]: session opened for user root by (uid=0)
Oct 12 04:02:01 Inblr-bislinux1 crond[12795]: (root) CMD (run-parts /etc/cron.daily)
Oct 12 04:02:16 Inblr-bislinux1 sendmail[13126]: j9BN2Gtv013126: from=root, size=2543, class=0, nrcpts=1, msgid=<200510112302.j9BN2Gtv013126@localhost.localdomain>, relay=root@localhost
Oct 12 04:02:16 Inblr-bislinux1 sendmail[13128]: warning: /etc/hosts.allow, line 7: missing ":" separator
Oct 12 04:02:16 Inblr-bislinux1 sendmail[13128]: j9BN2G2e013128: from=<root@localhost.localdomain>, size=2849, class=0, nrcpts=1, msgid=<200510112302.j9BN2Gtv013126@localhost.localdomain>, proto=ESMTP, daemon=MTA, relay=localhost.localdomain [127.0.0.1]
Oct 12 04:02:16 Inblr-bislinux1 sendmail[13126]: j9BN2Gtv013126: to=root, ctladdr=root (0/0), delay=00:00:00, xdelay=00:00:00, mailer=relay, pri=32543, relay=[127.0.0.1] [127.0.0.1], dsn=2.0.0, stat=Sent (j9BN2G2e013128 Message accepted for delivery)
Oct 12 04:02:16 Inblr-bislinux1 sendmail[13129]: j9BN2G2e013128: to=<root@localhost.localdomain>, ctladdr=<root@localhost.localdomain> (0/0), delay=00:00:00, xdelay=00:00:00, mailer=local, pri=33086, dsn=2.0.0, stat=Sent
Oct 12 04:02:17 Inblr-bislinux1 anacron[13217]: Updated timestamp for job `cron.daily' to 2005-10-12
Oct 12 04:02:22 Inblr-bislinux1 crond(pam_unix)[12794]: session closed for user root
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13276
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13276, sig 0 (0), stat 0 
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13276 finished, switching from 2 to 1
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 04:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13277
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13277, sig 0 (0), stat 0 
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13277 finished, switching from 2 to 1
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 04:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 04:32:28 Inblr-bislinux1 automount[12507]: handle_packet: type = 0 
Oct 12 04:32:28 Inblr-bislinux1 automount[12507]: handle_packet_missing: token 115, name Inblr-bislinux1.eu.uis.unisys.com 
Oct 12 04:32:28 Inblr-bislinux1 automount[12507]: attempting to mount entry /net/Inblr-bislinux1.eu.uis.unisys.com
Oct 12 04:32:28 Inblr-bislinux1 automount[13302]: failed to mount /net/Inblr-bislinux1.eu.uis.unisys.com
Oct 12 04:32:28 Inblr-bislinux1 automount[13302]: umount_multi: path=/net/Inblr-bislinux1.eu.uis.unisys.com incl=1 
Oct 12 04:32:28 Inblr-bislinux1 automount[12507]: handle_child: got pid 13302, sig 0 (0), stat 1 
Oct 12 04:32:28 Inblr-bislinux1 automount[12507]: sig_child: found pending iop pid 13302: signalled 0 (sig 0), exit status 1
Oct 12 04:32:28 Inblr-bislinux1 automount[12507]: send_fail: token=115 
Oct 12 04:32:28 Inblr-bislinux1 sendmail[13307]: j9BNWSrc013307: from=root, size=581, class=0, nrcpts=1, msgid=<200510112332.j9BNWSrc013307@localhost.localdomain>, relay=root@localhost
Oct 12 04:32:28 Inblr-bislinux1 sendmail[13308]: warning: /etc/hosts.allow, line 7: missing ":" separator
Oct 12 04:32:28 Inblr-bislinux1 sendmail[13308]: j9BNWSBN013308: from=<root@localhost.localdomain>, size=887, class=0, nrcpts=1, msgid=<200510112332.j9BNWSrc013307@localhost.localdomain>, proto=ESMTP, daemon=MTA, relay=localhost.localdomain [127.0.0.1]
Oct 12 04:32:28 Inblr-bislinux1 sendmail[13307]: j9BNWSrc013307: to=root, ctladdr=root (0/0), delay=00:00:00, xdelay=00:00:00, mailer=relay, pri=30581, relay=[127.0.0.1] [127.0.0.1], dsn=2.0.0, stat=Sent (j9BNWSBN013308 Message accepted for delivery)
Oct 12 04:32:28 Inblr-bislinux1 sendmail[13309]: j9BNWSBN013308: to=<root@localhost.localdomain>, ctladdr=<root@localhost.localdomain> (0/0), delay=00:00:00, xdelay=00:00:00, mailer=local, pri=31125, dsn=2.0.0, stat=Sent
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13311
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13311, sig 0 (0), stat 0 
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13311 finished, switching from 2 to 1
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 04:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13312
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13312, sig 0 (0), stat 0 
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13312 finished, switching from 2 to 1
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 04:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 05:01:01 Inblr-bislinux1 crond(pam_unix)[13313]: session opened for user root by (uid=0)
Oct 12 05:01:01 Inblr-bislinux1 crond[13314]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 05:01:01 Inblr-bislinux1 crond(pam_unix)[13313]: session closed for user root
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13323
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13323, sig 0 (0), stat 0 
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13323 finished, switching from 2 to 1
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 05:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13324
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13324, sig 0 (0), stat 0 
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13324 finished, switching from 2 to 1
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 05:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13327
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13327, sig 0 (0), stat 0 
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13327 finished, switching from 2 to 1
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 05:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13328
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13328, sig 0 (0), stat 0 
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13328 finished, switching from 2 to 1
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 05:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 06:01:01 Inblr-bislinux1 crond(pam_unix)[13329]: session opened for user root by (uid=0)
Oct 12 06:01:01 Inblr-bislinux1 crond[13330]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 06:01:01 Inblr-bislinux1 crond(pam_unix)[13329]: session closed for user root
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13339
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13339, sig 0 (0), stat 0 
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13339 finished, switching from 2 to 1
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 06:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13340
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13340, sig 0 (0), stat 0 
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13340 finished, switching from 2 to 1
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 06:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13343
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13343, sig 0 (0), stat 0 
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13343 finished, switching from 2 to 1
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 06:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13344
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13344, sig 0 (0), stat 0 
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13344 finished, switching from 2 to 1
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 06:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 07:01:01 Inblr-bislinux1 crond(pam_unix)[13345]: session opened for user root by (uid=0)
Oct 12 07:01:01 Inblr-bislinux1 crond[13346]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 07:01:01 Inblr-bislinux1 crond(pam_unix)[13345]: session closed for user root
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13355
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13355, sig 0 (0), stat 0 
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13355 finished, switching from 2 to 1
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 07:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13356
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13356, sig 0 (0), stat 0 
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13356 finished, switching from 2 to 1
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 07:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13359
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13359, sig 0 (0), stat 0 
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13359 finished, switching from 2 to 1
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 07:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13360
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13360, sig 0 (0), stat 0 
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13360 finished, switching from 2 to 1
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 07:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 08:01:01 Inblr-bislinux1 crond(pam_unix)[13361]: session opened for user root by (uid=0)
Oct 12 08:01:01 Inblr-bislinux1 crond[13362]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 08:01:01 Inblr-bislinux1 crond(pam_unix)[13361]: session closed for user root
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13371
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13371, sig 0 (0), stat 0 
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13371 finished, switching from 2 to 1
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 08:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13372
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13372, sig 0 (0), stat 0 
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13372 finished, switching from 2 to 1
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 08:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13375
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13375, sig 0 (0), stat 0 
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13375 finished, switching from 2 to 1
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 08:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13376
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13376, sig 0 (0), stat 0 
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13376 finished, switching from 2 to 1
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 08:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 09:01:01 Inblr-bislinux1 crond(pam_unix)[13377]: session opened for user root by (uid=0)
Oct 12 09:01:01 Inblr-bislinux1 crond[13378]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 09:01:01 Inblr-bislinux1 crond(pam_unix)[13377]: session closed for user root
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13387
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13387, sig 0 (0), stat 0 
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13387 finished, switching from 2 to 1
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 09:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13388
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13388, sig 0 (0), stat 0 
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13388 finished, switching from 2 to 1
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 09:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13391
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13391, sig 0 (0), stat 0 
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13391 finished, switching from 2 to 1
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 09:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13392
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13392, sig 0 (0), stat 0 
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13392 finished, switching from 2 to 1
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 09:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 10:01:01 Inblr-bislinux1 crond(pam_unix)[13393]: session opened for user root by (uid=0)
Oct 12 10:01:01 Inblr-bislinux1 crond[13394]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 10:01:01 Inblr-bislinux1 crond(pam_unix)[13393]: session closed for user root
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13403
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13403, sig 0 (0), stat 0 
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13403 finished, switching from 2 to 1
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 10:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13404
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13404, sig 0 (0), stat 0 
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13404 finished, switching from 2 to 1
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 10:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13407
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13407, sig 0 (0), stat 0 
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13407 finished, switching from 2 to 1
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 10:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13408
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13408, sig 0 (0), stat 0 
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13408 finished, switching from 2 to 1
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 10:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 11:01:01 Inblr-bislinux1 crond(pam_unix)[13409]: session opened for user root by (uid=0)
Oct 12 11:01:01 Inblr-bislinux1 crond[13410]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 11:01:01 Inblr-bislinux1 crond(pam_unix)[13409]: session closed for user root
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13419
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13419, sig 0 (0), stat 0 
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13419 finished, switching from 2 to 1
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 11:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13420
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13420, sig 0 (0), stat 0 
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13420 finished, switching from 2 to 1
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 11:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13423
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13423, sig 0 (0), stat 0 
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13423 finished, switching from 2 to 1
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 11:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13424
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13424, sig 0 (0), stat 0 
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13424 finished, switching from 2 to 1
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 11:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 12:01:01 Inblr-bislinux1 crond(pam_unix)[13425]: session opened for user root by (uid=0)
Oct 12 12:01:01 Inblr-bislinux1 crond[13426]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 12:01:01 Inblr-bislinux1 crond(pam_unix)[13425]: session closed for user root
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13435
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13435, sig 0 (0), stat 0 
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13435 finished, switching from 2 to 1
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 12:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13436
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13436, sig 0 (0), stat 0 
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13436 finished, switching from 2 to 1
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 12:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13439
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13439, sig 0 (0), stat 0 
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13439 finished, switching from 2 to 1
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 12:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13440
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13440, sig 0 (0), stat 0 
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13440 finished, switching from 2 to 1
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 12:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 13:01:01 Inblr-bislinux1 crond(pam_unix)[13441]: session opened for user root by (uid=0)
Oct 12 13:01:01 Inblr-bislinux1 crond[13442]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 13:01:01 Inblr-bislinux1 crond(pam_unix)[13441]: session closed for user root
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13451
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13451, sig 0 (0), stat 0 
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13451 finished, switching from 2 to 1
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 13:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13452
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13452, sig 0 (0), stat 0 
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13452 finished, switching from 2 to 1
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 13:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13455
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13455, sig 0 (0), stat 0 
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13455 finished, switching from 2 to 1
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 13:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13456
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13456, sig 0 (0), stat 0 
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13456 finished, switching from 2 to 1
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 13:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 14:01:01 Inblr-bislinux1 crond(pam_unix)[13457]: session opened for user root by (uid=0)
Oct 12 14:01:01 Inblr-bislinux1 crond[13458]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 14:01:01 Inblr-bislinux1 crond(pam_unix)[13457]: session closed for user root
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13467
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13467, sig 0 (0), stat 0 
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13467 finished, switching from 2 to 1
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 14:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13468
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13468, sig 0 (0), stat 0 
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13468 finished, switching from 2 to 1
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 14:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13471
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13471, sig 0 (0), stat 0 
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13471 finished, switching from 2 to 1
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 14:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13472
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13472, sig 0 (0), stat 0 
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13472 finished, switching from 2 to 1
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 14:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 15:01:01 Inblr-bislinux1 crond(pam_unix)[13473]: session opened for user root by (uid=0)
Oct 12 15:01:01 Inblr-bislinux1 crond[13474]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 15:01:01 Inblr-bislinux1 crond(pam_unix)[13473]: session closed for user root
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13483
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13483, sig 0 (0), stat 0 
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13483 finished, switching from 2 to 1
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 15:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13484
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13484, sig 0 (0), stat 0 
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13484 finished, switching from 2 to 1
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 15:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13487
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13487, sig 0 (0), stat 0 
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13487 finished, switching from 2 to 1
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 15:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13488
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13488, sig 0 (0), stat 0 
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13488 finished, switching from 2 to 1
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 15:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 16:01:01 Inblr-bislinux1 crond(pam_unix)[13489]: session opened for user root by (uid=0)
Oct 12 16:01:01 Inblr-bislinux1 crond[13490]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 16:01:01 Inblr-bislinux1 crond(pam_unix)[13489]: session closed for user root
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13499
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13499, sig 0 (0), stat 0 
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13499 finished, switching from 2 to 1
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 16:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13500
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13500, sig 0 (0), stat 0 
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13500 finished, switching from 2 to 1
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 16:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13503
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13503, sig 0 (0), stat 0 
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13503 finished, switching from 2 to 1
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 16:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13504
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13504, sig 0 (0), stat 0 
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13504 finished, switching from 2 to 1
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 16:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 17:01:01 Inblr-bislinux1 crond(pam_unix)[13505]: session opened for user root by (uid=0)
Oct 12 17:01:01 Inblr-bislinux1 crond[13506]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 17:01:01 Inblr-bislinux1 crond(pam_unix)[13505]: session closed for user root
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13515
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13515, sig 0 (0), stat 0 
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13515 finished, switching from 2 to 1
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 17:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13516
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13516, sig 0 (0), stat 0 
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13516 finished, switching from 2 to 1
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 17:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13519
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13519, sig 0 (0), stat 0 
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13519 finished, switching from 2 to 1
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 17:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13520
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13520, sig 0 (0), stat 0 
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13520 finished, switching from 2 to 1
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 17:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 18:01:01 Inblr-bislinux1 crond(pam_unix)[13521]: session opened for user root by (uid=0)
Oct 12 18:01:01 Inblr-bislinux1 crond[13522]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 18:01:01 Inblr-bislinux1 crond(pam_unix)[13521]: session closed for user root
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13531
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13531, sig 0 (0), stat 0 
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13531 finished, switching from 2 to 1
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 18:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13532
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13532, sig 0 (0), stat 0 
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13532 finished, switching from 2 to 1
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 18:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13535
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13535, sig 0 (0), stat 0 
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13535 finished, switching from 2 to 1
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 18:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13536
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13536, sig 0 (0), stat 0 
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13536 finished, switching from 2 to 1
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 18:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 19:01:01 Inblr-bislinux1 crond(pam_unix)[13537]: session opened for user root by (uid=0)
Oct 12 19:01:01 Inblr-bislinux1 crond[13538]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 19:01:01 Inblr-bislinux1 crond(pam_unix)[13537]: session closed for user root
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13547
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13547, sig 0 (0), stat 0 
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13547 finished, switching from 2 to 1
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 19:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13548
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13548, sig 0 (0), stat 0 
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13548 finished, switching from 2 to 1
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 19:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13551
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13551, sig 0 (0), stat 0 
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13551 finished, switching from 2 to 1
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 19:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13552
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13552, sig 0 (0), stat 0 
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13552 finished, switching from 2 to 1
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 19:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 20:01:01 Inblr-bislinux1 crond(pam_unix)[13553]: session opened for user root by (uid=0)
Oct 12 20:01:01 Inblr-bislinux1 crond[13554]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 20:01:01 Inblr-bislinux1 crond(pam_unix)[13553]: session closed for user root
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13563
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13563, sig 0 (0), stat 0 
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13563 finished, switching from 2 to 1
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 20:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13564
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13564, sig 0 (0), stat 0 
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13564 finished, switching from 2 to 1
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 20:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13567
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13567, sig 0 (0), stat 0 
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13567 finished, switching from 2 to 1
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 20:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13568
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13568, sig 0 (0), stat 0 
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13568 finished, switching from 2 to 1
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 20:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 21:01:01 Inblr-bislinux1 crond(pam_unix)[13569]: session opened for user root by (uid=0)
Oct 12 21:01:01 Inblr-bislinux1 crond[13570]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 21:01:01 Inblr-bislinux1 crond(pam_unix)[13569]: session closed for user root
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13579
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13579, sig 0 (0), stat 0 
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13579 finished, switching from 2 to 1
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 21:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13580
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13580, sig 0 (0), stat 0 
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13580 finished, switching from 2 to 1
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 21:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13583
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13583, sig 0 (0), stat 0 
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13583 finished, switching from 2 to 1
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 21:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13584
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13584, sig 0 (0), stat 0 
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13584 finished, switching from 2 to 1
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 21:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 22:01:01 Inblr-bislinux1 crond(pam_unix)[13585]: session opened for user root by (uid=0)
Oct 12 22:01:01 Inblr-bislinux1 crond[13586]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 22:01:01 Inblr-bislinux1 crond(pam_unix)[13585]: session closed for user root
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13595
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13595, sig 0 (0), stat 0 
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13595 finished, switching from 2 to 1
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 22:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13596
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13596, sig 0 (0), stat 0 
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13596 finished, switching from 2 to 1
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 22:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13599
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13599, sig 0 (0), stat 0 
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13599 finished, switching from 2 to 1
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 22:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13600
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13600, sig 0 (0), stat 0 
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13600 finished, switching from 2 to 1
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 22:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 23:01:01 Inblr-bislinux1 crond(pam_unix)[13601]: session opened for user root by (uid=0)
Oct 12 23:01:01 Inblr-bislinux1 crond[13602]: (root) CMD (run-parts /etc/cron.hourly)
Oct 12 23:01:01 Inblr-bislinux1 crond(pam_unix)[13601]: session closed for user root
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13611
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13611, sig 0 (0), stat 0 
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13611 finished, switching from 2 to 1
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 23:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13612
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13612, sig 0 (0), stat 0 
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13612 finished, switching from 2 to 1
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 23:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13615
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13615, sig 0 (0), stat 0 
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13615 finished, switching from 2 to 1
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 23:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13616
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13616, sig 0 (0), stat 0 
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13616 finished, switching from 2 to 1
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 12 23:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 00:01:01 Inblr-bislinux1 crond(pam_unix)[13617]: session opened for user root by (uid=0)
Oct 13 00:01:01 Inblr-bislinux1 crond[13618]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 00:01:01 Inblr-bislinux1 crond(pam_unix)[13617]: session closed for user root
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13627
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13627, sig 0 (0), stat 0 
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13627 finished, switching from 2 to 1
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 00:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13628
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13628, sig 0 (0), stat 0 
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13628 finished, switching from 2 to 1
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 00:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13631
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13631, sig 0 (0), stat 0 
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13631 finished, switching from 2 to 1
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 00:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13632
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13632, sig 0 (0), stat 0 
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13632 finished, switching from 2 to 1
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 00:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 01:01:01 Inblr-bislinux1 crond(pam_unix)[13633]: session opened for user root by (uid=0)
Oct 13 01:01:01 Inblr-bislinux1 crond[13634]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 01:01:01 Inblr-bislinux1 crond(pam_unix)[13633]: session closed for user root
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13643
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13643, sig 0 (0), stat 0 
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13643 finished, switching from 2 to 1
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 01:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13644
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13644, sig 0 (0), stat 0 
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13644 finished, switching from 2 to 1
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 01:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13647
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13647, sig 0 (0), stat 0 
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13647 finished, switching from 2 to 1
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 01:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13648
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13648, sig 0 (0), stat 0 
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13648 finished, switching from 2 to 1
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 01:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 02:01:01 Inblr-bislinux1 crond(pam_unix)[13649]: session opened for user root by (uid=0)
Oct 13 02:01:01 Inblr-bislinux1 crond[13650]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 02:01:01 Inblr-bislinux1 crond(pam_unix)[13649]: session closed for user root
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13659
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13659, sig 0 (0), stat 0 
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13659 finished, switching from 2 to 1
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 02:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13660
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13660, sig 0 (0), stat 0 
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13660 finished, switching from 2 to 1
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 02:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13663
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13663, sig 0 (0), stat 0 
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13663 finished, switching from 2 to 1
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 02:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13664
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13664, sig 0 (0), stat 0 
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13664 finished, switching from 2 to 1
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 02:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 03:01:01 Inblr-bislinux1 crond(pam_unix)[13665]: session opened for user root by (uid=0)
Oct 13 03:01:01 Inblr-bislinux1 crond[13666]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 03:01:01 Inblr-bislinux1 crond(pam_unix)[13665]: session closed for user root
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13675
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13675, sig 0 (0), stat 0 
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13675 finished, switching from 2 to 1
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 03:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13676
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13676, sig 0 (0), stat 0 
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13676 finished, switching from 2 to 1
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 03:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13679
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13679, sig 0 (0), stat 0 
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13679 finished, switching from 2 to 1
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 03:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=13680
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 13680, sig 0 (0), stat 0 
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 13680 finished, switching from 2 to 1
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 03:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 04:01:01 Inblr-bislinux1 crond(pam_unix)[13681]: session opened for user root by (uid=0)
Oct 13 04:01:01 Inblr-bislinux1 crond[13682]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 04:01:01 Inblr-bislinux1 crond(pam_unix)[13681]: session closed for user root
Oct 13 04:02:01 Inblr-bislinux1 crond(pam_unix)[13691]: session opened for user root by (uid=0)
Oct 13 04:02:01 Inblr-bislinux1 crond[13692]: (root) CMD (run-parts /etc/cron.daily)
Oct 13 04:02:16 Inblr-bislinux1 sendmail[14003]: j9CN2GaN014003: from=root, size=1414, class=0, nrcpts=1, msgid=<200510122302.j9CN2GaN014003@localhost.localdomain>, relay=root@localhost
Oct 13 04:02:16 Inblr-bislinux1 sendmail[14005]: warning: /etc/hosts.allow, line 7: missing ":" separator
Oct 13 04:02:16 Inblr-bislinux1 sendmail[14005]: j9CN2G04014005: from=<root@localhost.localdomain>, size=1720, class=0, nrcpts=1, msgid=<200510122302.j9CN2GaN014003@localhost.localdomain>, proto=ESMTP, daemon=MTA, relay=localhost.localdomain [127.0.0.1]
Oct 13 04:02:16 Inblr-bislinux1 sendmail[14003]: j9CN2GaN014003: to=root, ctladdr=root (0/0), delay=00:00:00, xdelay=00:00:00, mailer=relay, pri=31414, relay=[127.0.0.1] [127.0.0.1], dsn=2.0.0, stat=Sent (j9CN2G04014005 Message accepted for delivery)
Oct 13 04:02:16 Inblr-bislinux1 sendmail[14006]: j9CN2G04014005: to=<root@localhost.localdomain>, ctladdr=<root@localhost.localdomain> (0/0), delay=00:00:00, xdelay=00:00:00, mailer=local, pri=31957, dsn=2.0.0, stat=Sent
Oct 13 04:02:17 Inblr-bislinux1 anacron[14094]: Updated timestamp for job `cron.daily' to 2005-10-13
Oct 13 04:02:21 Inblr-bislinux1 crond(pam_unix)[13691]: session closed for user root
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14153
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14153, sig 0 (0), stat 0 
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14153 finished, switching from 2 to 1
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 04:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14154
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14154, sig 0 (0), stat 0 
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14154 finished, switching from 2 to 1
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 04:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 04:32:16 Inblr-bislinux1 automount[12507]: handle_packet: type = 0 
Oct 13 04:32:16 Inblr-bislinux1 automount[12507]: handle_packet_missing: token 116, name Inblr-bislinux1.eu.uis.unisys.com 
Oct 13 04:32:16 Inblr-bislinux1 automount[12507]: attempting to mount entry /net/Inblr-bislinux1.eu.uis.unisys.com
Oct 13 04:32:16 Inblr-bislinux1 automount[14179]: failed to mount /net/Inblr-bislinux1.eu.uis.unisys.com
Oct 13 04:32:16 Inblr-bislinux1 automount[14179]: umount_multi: path=/net/Inblr-bislinux1.eu.uis.unisys.com incl=1 
Oct 13 04:32:16 Inblr-bislinux1 automount[12507]: handle_child: got pid 14179, sig 0 (0), stat 1 
Oct 13 04:32:16 Inblr-bislinux1 automount[12507]: sig_child: found pending iop pid 14179: signalled 0 (sig 0), exit status 1
Oct 13 04:32:16 Inblr-bislinux1 automount[12507]: send_fail: token=116 
Oct 13 04:32:17 Inblr-bislinux1 sendmail[14184]: j9CNWGh8014184: from=root, size=581, class=0, nrcpts=1, msgid=<200510122332.j9CNWGh8014184@localhost.localdomain>, relay=root@localhost
Oct 13 04:32:17 Inblr-bislinux1 sendmail[14185]: warning: /etc/hosts.allow, line 7: missing ":" separator
Oct 13 04:32:17 Inblr-bislinux1 sendmail[14185]: j9CNWHvD014185: from=<root@localhost.localdomain>, size=887, class=0, nrcpts=1, msgid=<200510122332.j9CNWGh8014184@localhost.localdomain>, proto=ESMTP, daemon=MTA, relay=localhost.localdomain [127.0.0.1]
Oct 13 04:32:17 Inblr-bislinux1 sendmail[14184]: j9CNWGh8014184: to=root, ctladdr=root (0/0), delay=00:00:01, xdelay=00:00:00, mailer=relay, pri=30581, relay=[127.0.0.1] [127.0.0.1], dsn=2.0.0, stat=Sent (j9CNWHvD014185 Message accepted for delivery)
Oct 13 04:32:17 Inblr-bislinux1 sendmail[14186]: j9CNWHvD014185: to=<root@localhost.localdomain>, ctladdr=<root@localhost.localdomain> (0/0), delay=00:00:00, xdelay=00:00:00, mailer=local, pri=31125, dsn=2.0.0, stat=Sent
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14188
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14188, sig 0 (0), stat 0 
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14188 finished, switching from 2 to 1
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 04:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14189
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14189, sig 0 (0), stat 0 
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14189 finished, switching from 2 to 1
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 04:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 05:01:01 Inblr-bislinux1 crond(pam_unix)[14190]: session opened for user root by (uid=0)
Oct 13 05:01:01 Inblr-bislinux1 crond[14191]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 05:01:01 Inblr-bislinux1 crond(pam_unix)[14190]: session closed for user root
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14200
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14200, sig 0 (0), stat 0 
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14200 finished, switching from 2 to 1
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 05:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14201
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14201, sig 0 (0), stat 0 
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14201 finished, switching from 2 to 1
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 05:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14204
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14204, sig 0 (0), stat 0 
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14204 finished, switching from 2 to 1
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 05:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14205
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14205, sig 0 (0), stat 0 
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14205 finished, switching from 2 to 1
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 05:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 06:01:01 Inblr-bislinux1 crond(pam_unix)[14206]: session opened for user root by (uid=0)
Oct 13 06:01:01 Inblr-bislinux1 crond[14207]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 06:01:01 Inblr-bislinux1 crond(pam_unix)[14206]: session closed for user root
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14216
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14216, sig 0 (0), stat 0 
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14216 finished, switching from 2 to 1
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 06:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14217
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14217, sig 0 (0), stat 0 
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14217 finished, switching from 2 to 1
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 06:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14220
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14220, sig 0 (0), stat 0 
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14220 finished, switching from 2 to 1
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 06:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14221
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14221, sig 0 (0), stat 0 
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14221 finished, switching from 2 to 1
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 06:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 07:01:01 Inblr-bislinux1 crond(pam_unix)[14222]: session opened for user root by (uid=0)
Oct 13 07:01:01 Inblr-bislinux1 crond[14223]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 07:01:01 Inblr-bislinux1 crond(pam_unix)[14222]: session closed for user root
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14232
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14232, sig 0 (0), stat 0 
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14232 finished, switching from 2 to 1
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 07:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14233
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14233, sig 0 (0), stat 0 
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14233 finished, switching from 2 to 1
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 07:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14236
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14236, sig 0 (0), stat 0 
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14236 finished, switching from 2 to 1
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 07:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14237
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14237, sig 0 (0), stat 0 
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14237 finished, switching from 2 to 1
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 07:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 08:01:01 Inblr-bislinux1 crond(pam_unix)[14238]: session opened for user root by (uid=0)
Oct 13 08:01:01 Inblr-bislinux1 crond[14239]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 08:01:01 Inblr-bislinux1 crond(pam_unix)[14238]: session closed for user root
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14248
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14248, sig 0 (0), stat 0 
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14248 finished, switching from 2 to 1
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 08:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14249
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14249, sig 0 (0), stat 0 
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14249 finished, switching from 2 to 1
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 08:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14252
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14252, sig 0 (0), stat 0 
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14252 finished, switching from 2 to 1
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 08:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14253
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14253, sig 0 (0), stat 0 
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14253 finished, switching from 2 to 1
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 08:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 09:01:01 Inblr-bislinux1 crond(pam_unix)[14254]: session opened for user root by (uid=0)
Oct 13 09:01:01 Inblr-bislinux1 crond[14255]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 09:01:01 Inblr-bislinux1 crond(pam_unix)[14254]: session closed for user root
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14264
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14264, sig 0 (0), stat 0 
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14264 finished, switching from 2 to 1
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 09:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14265
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14265, sig 0 (0), stat 0 
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14265 finished, switching from 2 to 1
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 09:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14268
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14268, sig 0 (0), stat 0 
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14268 finished, switching from 2 to 1
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 09:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14269
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14269, sig 0 (0), stat 0 
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14269 finished, switching from 2 to 1
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 09:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 10:01:01 Inblr-bislinux1 crond(pam_unix)[14270]: session opened for user root by (uid=0)
Oct 13 10:01:01 Inblr-bislinux1 crond[14271]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 10:01:01 Inblr-bislinux1 crond(pam_unix)[14270]: session closed for user root
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14280
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14280, sig 0 (0), stat 0 
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14280 finished, switching from 2 to 1
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 10:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14281
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14281, sig 0 (0), stat 0 
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14281 finished, switching from 2 to 1
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 10:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14284
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14284, sig 0 (0), stat 0 
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14284 finished, switching from 2 to 1
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 10:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14285
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14285, sig 0 (0), stat 0 
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14285 finished, switching from 2 to 1
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 10:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 11:01:01 Inblr-bislinux1 crond(pam_unix)[14286]: session opened for user root by (uid=0)
Oct 13 11:01:01 Inblr-bislinux1 crond[14287]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 11:01:01 Inblr-bislinux1 crond(pam_unix)[14286]: session closed for user root
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14296
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14296, sig 0 (0), stat 0 
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14296 finished, switching from 2 to 1
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 11:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14297
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14297, sig 0 (0), stat 0 
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14297 finished, switching from 2 to 1
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 11:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14300
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14300, sig 0 (0), stat 0 
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14300 finished, switching from 2 to 1
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 11:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14301
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14301, sig 0 (0), stat 0 
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14301 finished, switching from 2 to 1
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 11:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 12:01:01 Inblr-bislinux1 crond(pam_unix)[14302]: session opened for user root by (uid=0)
Oct 13 12:01:01 Inblr-bislinux1 crond[14303]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 12:01:01 Inblr-bislinux1 crond(pam_unix)[14302]: session closed for user root
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14312
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14312, sig 0 (0), stat 0 
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14312 finished, switching from 2 to 1
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 12:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14313
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14313, sig 0 (0), stat 0 
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14313 finished, switching from 2 to 1
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 12:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14316
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14316, sig 0 (0), stat 0 
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14316 finished, switching from 2 to 1
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 12:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14317
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14317, sig 0 (0), stat 0 
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14317 finished, switching from 2 to 1
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 12:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 13:01:01 Inblr-bislinux1 crond(pam_unix)[14318]: session opened for user root by (uid=0)
Oct 13 13:01:01 Inblr-bislinux1 crond[14319]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 13:01:01 Inblr-bislinux1 crond(pam_unix)[14318]: session closed for user root
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14328
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14328, sig 0 (0), stat 0 
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14328 finished, switching from 2 to 1
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 13:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14329
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14329, sig 0 (0), stat 0 
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14329 finished, switching from 2 to 1
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 13:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14332
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14332, sig 0 (0), stat 0 
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14332 finished, switching from 2 to 1
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 13:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14333
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14333, sig 0 (0), stat 0 
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14333 finished, switching from 2 to 1
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 13:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 14:01:01 Inblr-bislinux1 crond(pam_unix)[14334]: session opened for user root by (uid=0)
Oct 13 14:01:01 Inblr-bislinux1 crond[14335]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 14:01:01 Inblr-bislinux1 crond(pam_unix)[14334]: session closed for user root
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14344
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14344, sig 0 (0), stat 0 
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14344 finished, switching from 2 to 1
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 14:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14345
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14345, sig 0 (0), stat 0 
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14345 finished, switching from 2 to 1
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 14:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14348
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14348, sig 0 (0), stat 0 
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14348 finished, switching from 2 to 1
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 14:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14349
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14349, sig 0 (0), stat 0 
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14349 finished, switching from 2 to 1
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 14:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 15:01:01 Inblr-bislinux1 crond(pam_unix)[14350]: session opened for user root by (uid=0)
Oct 13 15:01:01 Inblr-bislinux1 crond[14351]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 15:01:01 Inblr-bislinux1 crond(pam_unix)[14350]: session closed for user root
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14360
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14360, sig 0 (0), stat 0 
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14360 finished, switching from 2 to 1
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 15:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14361
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14361, sig 0 (0), stat 0 
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14361 finished, switching from 2 to 1
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 15:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14364
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14364, sig 0 (0), stat 0 
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14364 finished, switching from 2 to 1
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 15:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14365
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14365, sig 0 (0), stat 0 
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14365 finished, switching from 2 to 1
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 15:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 16:01:01 Inblr-bislinux1 crond(pam_unix)[14366]: session opened for user root by (uid=0)
Oct 13 16:01:01 Inblr-bislinux1 crond[14367]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 16:01:01 Inblr-bislinux1 crond(pam_unix)[14366]: session closed for user root
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14376
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14376, sig 0 (0), stat 0 
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14376 finished, switching from 2 to 1
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 16:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14377
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14377, sig 0 (0), stat 0 
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14377 finished, switching from 2 to 1
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 16:20:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14380
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14380, sig 0 (0), stat 0 
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14380 finished, switching from 2 to 1
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 16:35:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14381
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14381, sig 0 (0), stat 0 
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14381 finished, switching from 2 to 1
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 16:50:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 
Oct 13 17:01:01 Inblr-bislinux1 crond(pam_unix)[14382]: session opened for user root by (uid=0)
Oct 13 17:01:01 Inblr-bislinux1 crond[14383]: (root) CMD (run-parts /etc/cron.hourly)
Oct 13 17:01:01 Inblr-bislinux1 crond(pam_unix)[14382]: session closed for user root
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: sig 14 switching from 1 to 2
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 1, next 2
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: st_expire(): state = 1 
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: expire_proc: exp_proc=14392
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: handle_child: got pid 14392, sig 0 (0), stat 0 
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: sigchld: exp 14392 finished, switching from 2 to 1
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: get_pkt: state 2, next 1
Oct 13 17:05:44 Inblr-bislinux1 automount[12507]: st_ready(): state = 2 

--0-749466982-1129196535=:23473
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--0-749466982-1129196535=:23473--

