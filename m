From: "Eric B." <ebenze@hotmail.com>
Subject: How to make Autofs check if ldap server is back online
Date: Fri, 27 Nov 2009 14:04:02 -0500
Message-ID: <BLU122-W39FFDD18BD2645CE96B6ADC9A0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3472417997489214511=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============3472417997489214511==
Content-Type: multipart/alternative;
	boundary="_d49b3604-b3fd-4c1c-98c6-4e38aa905577_"

--_d49b3604-b3fd-4c1c-98c6-4e38aa905577_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C

I'm using Autofs and LDAP for mounting my home directories via nfs. =20
In
general=2C everything seems to work fine.  However=2C I have one small=20
problem.
If I reboot my server using autofs while my LDAP server is down=2C I=20
get the
following error message in my logs:

 automount[3358]:=20
bind_ldap_anonymous: lookup(ldap): Unable to bind to the
LDAP server:=20
(default)=2C error Can't contact LDAP server

which is understandable=2C since=20
my ldap server is temporarily down.

My problem=2C however=2C is that once my=20
ldap server is back up=2C autofs never
seems to retry to connect to it=2C so all=20
my /home mounts fail.  Basically=2C it
means I have to make sure that my LDAP=20
server is never down while another
server is rebooting.

I figure there=20
must be something in the configuration file that would allow
me to tweak this=20
to indicate to autofs to recheck the ldap server
periodically to see if it=20
has come back up=2C but can't seem to find anything.

My=20
/etc/sysconfic/autofs file is pretty plain:
# TIMEOUT - set the default mount=20
timeout (default 600).
#
TIMEOUT=3D300

# LOGGING - set default log=20
level "none"=2C "verbose" or "debug"
#
LOGGING=3D"verbose"

# Other=20
common LDAP=20
nameing
#
MAP_OBJECT_CLASS=3D"automountMap"
ENTRY_OBJECT_CLASS=3D"automount"
MAP_ATTRIBUTE=3D"ou"
ENTRY_ATTRIBUTE=3D"cn"
VALUE_ATTRIBUTE=3D"automountInformation"


Is=20
there anything I can do to force autofs to check to see if my LDAP server
is=20
back online?

Thanks=2C

Eric



 		 	   		 =20
_________________________________________________________________
Windows Live: Friends get your Flickr=2C Yelp=2C and Digg updates when they=
 e-mail you.
http://go.microsoft.com/?linkid=3D9691817=

--_d49b3604-b3fd-4c1c-98c6-4e38aa905577_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi=2C<br><br>I'm using Autofs and LDAP for mounting my home directories via=
 nfs.&nbsp=3B=20
In<br>general=2C everything seems to work fine.&nbsp=3B However=2C I have o=
ne small=20
problem.<br>If I reboot my server using autofs while my LDAP server is down=
=2C I=20
get the<br>following error message in my logs:<br><br>&nbsp=3Bautomount[335=
8]:=20
bind_ldap_anonymous: lookup(ldap): Unable to bind to the<br>LDAP server:=20
(default)=2C error Can't contact LDAP server<br><br>which is understandable=
=2C since=20
my ldap server is temporarily down.<br><br>My problem=2C however=2C is that=
 once my=20
ldap server is back up=2C autofs never<br>seems to retry to connect to it=
=2C so all=20
my /home mounts fail.&nbsp=3B Basically=2C it<br>means I have to make sure =
that my LDAP=20
server is never down while another<br>server is rebooting.<br><br>I figure =
there=20
must be something in the configuration file that would allow<br>me to tweak=
 this=20
to indicate to autofs to recheck the ldap server<br>periodically to see if =
it=20
has come back up=2C but can't seem to find anything.<br><br>My=20
/etc/sysconfic/autofs file is pretty plain:<br># TIMEOUT - set the default =
mount=20
timeout (default 600).<br>#<br>TIMEOUT=3D300<br><br># LOGGING - set default=
 log=20
level "none"=2C "verbose" or "debug"<br>#<br>LOGGING=3D"verbose"<br><br># O=
ther=20
common LDAP=20
nameing<br>#<br>MAP_OBJECT_CLASS=3D"automountMap"<br>ENTRY_OBJECT_CLASS=3D"=
automount"<br>MAP_ATTRIBUTE=3D"ou"<br>ENTRY_ATTRIBUTE=3D"cn"<br>VALUE_ATTRI=
BUTE=3D"automountInformation"<br><br><br>Is=20
there anything I can do to force autofs to check to see if my LDAP server<b=
r>is=20
back online?<br><br>Thanks=2C<br><br>Eric<br><br><br><br> 		 	   		  <br />=
<hr />Get a great deal on Windows 7 and see how it works the way you want. =
<a href=3D'http://go.microsoft.com/?linkid=3D9691812' target=3D'_new'>Check=
 out the offers on Windows 7now.</a></body>
</html>=

--_d49b3604-b3fd-4c1c-98c6-4e38aa905577_--


--===============3472417997489214511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3472417997489214511==--

