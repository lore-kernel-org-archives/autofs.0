From: "Mike K" <mrkfact@gmail.com>
Subject: Caching negative lookups
Date: Mon, 3 Nov 2008 10:03:40 -0500
Message-ID: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0126697929758783964=="
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

--===============0126697929758783964==
Content-Type: multipart/alternative; 
	boundary="----=_Part_61628_27003553.1225724620442"

------=_Part_61628_27003553.1225724620442
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Based on what I have found, autofs5 supports caching negative lookups, but
it doesn't appear to be working for me.  Although my understanding of how it
is supposed to work is very limited, so I may just be mistaken.

My client system:  Red Hat 5.2, autofs-5.0.1-0.rc2.88.x86_64,
kernel-2.6.18-92.el5.x86_64, with automounter maps in a NIS+ server (client
in niscompat mode).
NFS Server: A popular NAS appliance

auto_master snippet:
/home/dev auto_dev

By default (and a recommended setting), the NAS appliance requires that all
mounts from uid 0 come from a reserved port (0-1024) on the client.  On our
client system, repeated yp lookups for entries which don't exist will
consume all ports in 0-1024, causing other legit mount attempts to fail
since they are denied by the NAS appliance.  This does not happen on Red Hat
4 or 3 systems.

Reproducer: 'while true; do cd /home/dev/example; done'.  "watch -n 1
'netstat -an | grep TIME_WAIT | wc -l'" will show the number of sockets in
TIME_WAIT increase rapidly.

In this case, each 'cd /home/dev/example' causes a yp lookup for a directory
that doesn't exist in the NIS table, consuming a socket and leaving it in
TIME_WAIT for 60 seconds.

Is this situation supposed to be prevented with caching negative lookups?

Thanks,
Mike

------=_Part_61628_27003553.1225724620442
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>Based on what I have found, autofs5 supports caching negative lookups, but it doesn&#39;t appear to be working for me.&nbsp; Although my understanding of how it is supposed to work is very limited, so I may just be mistaken.<br>
<br>My client system:&nbsp; Red Hat 5.2, autofs-5.0.1-0.rc2.88.x86_64, kernel-2.6.18-92.el5.x86_64, with automounter maps in a NIS+ server (client in niscompat mode).<br>NFS Server: A popular NAS appliance<br><br>auto_master snippet:<br>
/home/dev auto_dev<br><br>By default (and a recommended setting), the NAS appliance requires that all mounts from uid 0 come from a reserved port (0-1024) on the client.&nbsp; On our client system, repeated yp lookups for entries which don&#39;t exist will consume all ports in 0-1024, causing other legit mount attempts to fail since they are denied by the NAS appliance.&nbsp; This does not happen on Red Hat 4 or 3 systems.<br>
<br>Reproducer: &#39;while true; do cd /home/dev/example; done&#39;.&nbsp; &quot;watch -n 1 &#39;netstat -an | grep TIME_WAIT | wc -l&#39;&quot; will show the number of sockets in TIME_WAIT increase rapidly.<br><br>In this case, each &#39;cd /home/dev/example&#39; causes a yp lookup for a directory that doesn&#39;t exist in the NIS table, consuming a socket and leaving it in TIME_WAIT for 60 seconds.<br>
<br>Is this situation supposed to be prevented with caching negative lookups?<br><br>Thanks,<br>Mike<br>

------=_Part_61628_27003553.1225724620442--


--===============0126697929758783964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0126697929758783964==--

