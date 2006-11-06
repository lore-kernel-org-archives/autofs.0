From: "Syed Khader" <syedk@google.com>
Subject: problem with autofs
Date: Mon, 6 Nov 2006 22:20:20 +0530
Message-ID: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6209535246741090868=="
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

--===============6209535246741090868==
Content-Type: multipart/alternative; 
	boundary="----=_Part_35760_27501084.1162831820857"

------=_Part_35760_27501084.1162831820857
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Evrybuddy,

I had configured Openldap and succesfully configured for authentication of
users.I'm facing problem with autofs.

I'm using Rhel4.When i say service autofs start it says

No mount points defined.

I have written the correct entries in /etc/exports file.

I have sucessfully mounted directories using /etc/auto.master and indirect
maps on the client side
But when i'm using the ldap maps it's giving me problems
How can i make my autofs service to read the auto.master from LDAP Ou=
auto.master.

I have changed in the /etc/nsswitch.conf file to Automount: ldap but no use

when i use service autofs start it says "No mountpoints defined".

Are they any bugs with RHEL4?
Or am i going wrong somewhere?

Thanks in advance
Abdul.

------=_Part_35760_27501084.1162831820857
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello Evrybuddy,</div>
<div>&nbsp;</div>
<div>I had configured Openldap and succesfully configured for authentication of users.I'm facing problem with autofs.</div>
<div>&nbsp;</div>
<div>I'm using Rhel4.When i say service autofs start it says</div>
<div>&nbsp;</div>
<div>No mount points defined.</div>
<div>&nbsp;</div>
<div>I have written the correct entries in /etc/exports file.</div>
<div>&nbsp;</div>
<div>I have sucessfully mounted directories using /etc/auto.master and indirect maps on the client side</div>
<div>But when i'm using the ldap maps it's giving me problems</div>
<div>How can i make my autofs service to read the auto.master from LDAP Ou=auto.master.</div>
<div>&nbsp;</div>
<div>I have changed in the /etc/nsswitch.conf file to Automount: ldap but no use</div>
<div>&nbsp;</div>
<div>when i use service autofs start it says &quot;No mountpoints defined&quot;.</div>
<div>&nbsp;</div>
<div>Are they any bugs with RHEL4?</div>
<div>Or am i going wrong somewhere?</div>
<div>&nbsp;</div>
<div>Thanks in advance</div>
<div>Abdul.</div>

------=_Part_35760_27501084.1162831820857--


--===============6209535246741090868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6209535246741090868==--

