From: "William Prochazka" <billprozac@gmail.com>
Subject: reload when using LDAP
Date: Mon, 16 Jul 2007 18:21:59 -0400
Message-ID: <812495870707161521g638be314ye81a8df6a9806582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3177072004060504607=="
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

--===============3177072004060504607==
Content-Type: multipart/alternative; 
	boundary="----=_Part_59543_30834428.1184624519987"

------=_Part_59543_30834428.1184624519987
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We use LDAP to store all of our map data which seems to be working very well
(all FC6 so autofs v5.0.1 RC3).  First off, we found out the hardway that
when autofs is restarted (like as part of a cron job) and a local autofs
filesystem is in use (direct map) ... kernel panic.  The restarting was
originally so we could push new maps and clients we get the maps nightly.
After the kernel panic fiasco, I nticed the reload option (should be much
safer since in our enviornment it would almost always only be adding new
maps).  Sounds good, but it does not work.  Reload fails as it cannot start
TLS, so it loads a null map and kills all unused daemons.  I have no idea
why it cannot start TLS since the service has no issues when starting and I
can see it querying ldap for the auto.master and the mount ou.  So this
leads to a few questions:

1. Does autofs only use the /etc/openldap/ldap.conf file, or does the reload
function use the /etc/ldap.conf file I think that is a hold over for legacy
applications)

2. Is there a good way to debug what exactly is failing with the reload? (I
have logging set to debug but that give little useful info.

3.  What is the best way to have clients poll for updates to the autofs
maps?

Thanks in advance.

------=_Part_59543_30834428.1184624519987
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We use LDAP to store all of our map data which seems to be working very well (all FC6 so autofs v5.0.1 RC3).&nbsp; First off, we found out the hardway that when autofs is restarted (like as part of a cron job) and a local autofs filesystem is in use (direct map) ... kernel panic.&nbsp; The restarting was originally so we could push new maps and clients we get the maps nightly.&nbsp; After the kernel panic fiasco, I nticed the reload option (should be much safer since in our enviornment it would almost always only be adding new maps).&nbsp; Sounds good, but it does not work.&nbsp; Reload fails as it cannot start TLS, so it loads a null map and kills all unused daemons.&nbsp; I have no idea why it cannot start TLS since the service has no issues when starting and I can see it querying ldap for the 
auto.master and the mount ou.&nbsp; So this leads to a few questions:<br><br>1. Does autofs only use the /etc/openldap/ldap.conf file, or does the reload function use the /etc/ldap.conf file I think that is a hold over for legacy applications)
<br><br>2. Is there a good way to debug what exactly is failing with the reload? (I have logging set to debug but that give little useful info.<br><br>3.&nbsp; What is the best way to have clients poll for updates to the autofs maps?
<br><br>Thanks in advance.<br>

------=_Part_59543_30834428.1184624519987--


--===============3177072004060504607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3177072004060504607==--

