From: Michael Coffman <michael.coffman@avagotech.com>
Subject: Question/request about host mapping
Date: Wed, 6 Apr 2011 12:52:39 -0600
Message-ID: <BANLkTimoD2yb7DBvNsrP014yxRaGywQVug@mail.gmail.com>
Reply-To: michael.coffman@avagotech.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6895111396715306087=="
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

--===============6895111396715306087==
Content-Type: multipart/alternative; boundary=0015174beb62401cb704a0447f98

--0015174beb62401cb704a0447f98
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am trying to use the -host map for global access to servers in my
environment.

I have noted on this list that after the first mount of a server via host
mapping, the server is never again probed for mount points.  This seems like
a major flaw in the host map functionality.   This is a problem when adding
new file systems to our NFS servers.   It means systems have to be
completely idled in order to get them to unmount and re-mount the servers to
see the new mount points (not possible very often in my environment).

Is the assumption that if you use host mapping, your server will either
never change, or you have the ability to 'reboot' your environment when a
new file system is added to a server?

Is there any way that functionality could be added that would allow for
sending a signal ( say USR2 ) that would cause the automounter to re-run
/etc/auto.net to re-query -host managed servers for new file systems?

I am running RHEL5u4 and using autofs-5.0.1-0.rc2.131.el5

Thanks for any help.
-- 
-MichaelC

--0015174beb62401cb704a0447f98
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I am trying to use the -host map for global access to servers=
 in my environment.=A0=A0 <br><br>I have noted on this list that after the =
first mount of a server via host mapping, the server is never again probed =
for mount points.=A0 This seems like a major flaw in the host map functiona=
lity.=A0=A0 This is a problem when adding new file systems to our NFS serve=
rs.=A0=A0 It means systems have to be completely idled in order to get them=
 to unmount and re-mount the servers to see the new mount points (not possi=
ble very often in my environment).=A0=A0=A0 <br>
<br>Is the assumption that if you use host mapping, your server will either=
 never change, or you have the ability to &#39;reboot&#39; your environment=
 when a new file system is added to a server?<br><br>Is there any way that =
functionality could be added that would allow for sending a signal ( say US=
R2 ) that would cause the automounter to re-run /etc/<a href=3D"http://auto=
.net">auto.net</a> to re-query -host managed servers for new file systems?<=
br>
<br>I am running RHEL5u4 and using autofs-5.0.1-0.rc2.131.el5<br clear=3D"a=
ll"><br>Thanks for any help.<br>-- <br>-MichaelC<br>

--0015174beb62401cb704a0447f98--


--===============6895111396715306087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6895111396715306087==--

