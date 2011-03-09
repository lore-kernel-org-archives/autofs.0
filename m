From: Jaskaran Singh <jsingh@winlab.rutgers.edu>
Subject: autofs hangs
Date: Wed, 09 Mar 2011 14:11:18 -0500
Message-ID: <4D77D0D6.1050508@winlab.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1328729352291714981=="
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

This is a multi-part message in MIME format.
--===============1328729352291714981==
Content-Type: multipart/alternative;
 boundary="------------020301080204020306060407"

This is a multi-part message in MIME format.
--------------020301080204020306060407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am running into an issue here, I using autofs with ldap to mount /home 
directories. This is my os version Description: Ubuntu 10.10 Release: 10.10
my /etc/auto.master is commented out.
in /etc/nsswitch.conf last line is
automount: ldap
I can automount my home directory from the NFS server using LDAP with 
out an issue. But after a few minutes of inactivity, when i  try to 
login to the machine and run my application it hangs. My application 
tries to read /etc/config.txt but rather than reading /etc/config.txt it 
tries to mount /home/etc/config.txt , i can see that in the syslog which 
is attached below.
If i were to login and move to another location besides /home/*, the 
command will run fine for example if I cd from/home to any other part of 
the file system like /tmp or /var/log.

Mar  9 14:02:02 console automount[23227]: do_bind: lookup(ldap): ldap 
simple bind returned 0
Mar  9 14:02:02 console automount[23227]: lookup_one: lookup(ldap): 
searching for 
"(&(objectclass=automount)(|(cn=repository)(cn=/)(cn=\2A)))" under 
"ou=auto.home,dc=domain,dc=org"
Mar  9 14:02:02 console automount[23227]: lookup_one: lookup(ldap): 
getting first entry for cn="repository"
Mar  9 14:02:02 console automount[23227]: lookup_one: lookup(ldap): got 
answer, but no entry for 
(&(objectclass=automount)(|(cn=repository)(cn=/)(cn=\2A)))
Mar  9 14:02:02 console automount[23227]: key "repository" not found in 
map source(s).
Mar  9 14:02:02 console automount[23227]: ioctl_send_fail: token = 548
Mar  9 14:02:02 console automount[23227]: failed to mount /home/repository
Mar  9 14:02:02 console automount[23227]: handle_packet: type = 3
Mar  9 14:02:02 console automount[23227]: 
handle_packet_missing_indirect: token 549, name repository, request pid 
23381
Mar  9 14:02:02 console automount[23227]: attempting to mount entry 
/home/repository
Mar  9 14:02:02 console automount[23227]: lookup_mount: lookup(ldap): 
looking up repository
Mar  9 14:02:02 console automount[23227]: ioctl_send_fail: token = 549
Mar  9 14:02:02 console automount[23227]: failed to mount /home/repository
Mar  9 14:02:19 console automount[23227]: st_expire: state 1 path /home
Mar  9 14:02:19 console automount[23227]: expire_proc: exp_proc = 
3057638256 path /home
Mar  9 14:02:19 console automount[23227]: expire_proc_indirect: expire 
/home/jsingh
Mar  9 14:02:19 console automount[23227]: 1 remaining in /home
Mar  9 14:02:19 console automount[23227]: expire_cleanup: got thid 
3057638256 path /home stat 3
Mar  9 14:02:19 console automount[23227]: expire_cleanup: sigchld: exp 
3057638256 finished, switching from 2 to 1
Mar  9 14:02:19 console automount[23227]: st_ready: st_ready(): state = 
2 path /home
Mar  9 14:03:34 console automount[23227]: st_expire: state 1 path /home
Mar  9 14:03:34 console automount[23227]: expire_proc: exp_proc = 
3057638256 path /home
Mar  9 14:03:34 console automount[23227]: expire_proc_indirect: expire 
/home/jsingh
Mar  9 14:03:34 console automount[23227]: 1 remaining in /home

Mar 7 17:04:39 console automount[1105]: lookup_one: lookup(ldap): got 
answer, but no entry for (&(objectclass=automount)(|(cn=etc)(cn=/)(cn=\2A)))
Mar 7 17:04:39 console automount[1105]: key "etc" not found in map 
source(s).
Mar 7 17:04:39 console automount[1105]: ioctl_send_fail: token = 2
Mar 7 17:04:39 console automount[1105]: failed to mount /home/etc
Mar 7 17:04:39 console automount[1105]: handle_packet: type = 3
Mar 7 17:04:39 console automount[1105]: handle_packet_missing_indirect: 
token 3, name repository, request pid 2011

Mar 7 17:04:39 console automount[1105]: ioctl_send_fail: token = 3
Mar 7 17:04:39 console automount[1105]: failed to mount /home/repository
Mar 7 17:04:39 console automount[1105]: handle_packet: type = 3
Mar 7 17:04:39 console automount[1105]: handle_packet_missing_indirect: 
token 4, name repository, request pid 2011
Mar 7 17:04:39 console automount[1105]: attempting to mount entry 
/home/repository
Mar 7 17:04:39 console automount[1105]: lookup_mount: lookup(ldap): 
looking up repository
Mar 7 17:04:39 console automount[1105]: ioctl_send_fail: token = 4
Mar 7 17:04:39 console automount[1105]: failed to mount /home/repository

Mar 7 17:05:34 console automount[1105]: handle_packet: type = 3
Mar 7 17:05:34 console automount[1105]: handle_packet_missing_indirect: 
token 5, name etc, request pid 2126
Mar 7 17:05:34 console automount[1105]: attempting to mount entry /home/etc
Mar 7 17:05:34 console automount[1105]: lookup_mount: lookup(ldap): 
looking up etc
Mar 7 17:05:34 console automount[1105]: ioctl_send_fail: token = 5
Mar 7 17:05:34 console automount[1105]: failed to mount /home/etc

autofs:
   Installed: 5.0.5-0ubuntu2
   Candidate: 5.0.5-0ubuntu2
   Version table:
  *** 5.0.5-0ubuntu2 0
         500 http://us.archive.ubuntu.com/ubuntu/ 
<http://us.archive.ubuntu.com/ubuntu/> maverick/main i386 Packages
         100 /var/lib/dpkg/status

The defaut autofs contains the
TIMEOUT=3000
LOGGING="debug"
MOUNT_NFS_DEFAULT_PROTOCOL=4
LDAP_URI="ldap://ldapserver.domain.org/"
SEARCH_BASE="ou=auto.master,dc=domain,dc=org"

-- 
Jaskaran Singh
Systems Administrator
Winlab, Rutgers University
Technology Centre of NJ
671 Route 1 South
North Brunswick, NJ 08902-3390

Desk: 732-932-6857 x 654
Fax: 732-932-6882


--------------020301080204020306060407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <div id="yui_3_3_0_1_1299697477043192"
      class="yui3-editable_text-text">
      <p>I am running into an issue here, I using autofs with ldap to
        mount /home directories. This is my os version Description:
        Ubuntu 10.10 Release: 10.10<br>
        my /etc/auto.master is commented out.<br>
        in /etc/nsswitch.conf last line is <br>
        automount: ldap<br>
        I can automount my home directory from the NFS server using LDAP
        with out an issue. But after a few minutes of inactivity, when
        i&nbsp; try to login to the machine and run my application it hangs.
        My application tries to read /etc/config.txt but rather than
        reading /etc/config.txt it tries to mount /home/etc/config.txt ,
        i can see that in the syslog which is attached below.<br>
        If i were to login and move to another location besides /home/*,
        the command will run fine for example if I cd from/home to any
        other part of the file system like /tmp or /var/log.</p>
      <p>Mar&nbsp; 9 14:02:02 console automount[23227]: do_bind:
        lookup(ldap): ldap simple bind returned 0<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: lookup_one:
        lookup(ldap): searching for
        "(&amp;(objectclass=automount)(|(cn=repository)(cn=/)(cn=\2A)))"
        under "ou=auto.home,dc=domain,dc=org"<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: lookup_one:
        lookup(ldap): getting first entry for cn="repository"<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: lookup_one:
        lookup(ldap): got answer, but no entry for
        (&amp;(objectclass=automount)(|(cn=repository)(cn=/)(cn=\2A)))<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: key "repository" not
        found in map source(s).<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: ioctl_send_fail: token
        = 548<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: failed to mount
        /home/repository<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: handle_packet: type =
        3<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]:
        handle_packet_missing_indirect: token 549, name repository,
        request pid 23381<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: attempting to mount
        entry /home/repository<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: lookup_mount:
        lookup(ldap): looking up repository<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: ioctl_send_fail: token
        = 549<br>
        Mar&nbsp; 9 14:02:02 console automount[23227]: failed to mount
        /home/repository<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: st_expire: state 1
        path /home<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: expire_proc: exp_proc
        = 3057638256 path /home<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: expire_proc_indirect:
        expire /home/jsingh<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: 1 remaining in /home<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: expire_cleanup: got
        thid 3057638256 path /home stat 3<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: expire_cleanup:
        sigchld: exp 3057638256 finished, switching from 2 to 1<br>
        Mar&nbsp; 9 14:02:19 console automount[23227]: st_ready: st_ready():
        state = 2 path /home<br>
        Mar&nbsp; 9 14:03:34 console automount[23227]: st_expire: state 1
        path /home<br>
        Mar&nbsp; 9 14:03:34 console automount[23227]: expire_proc: exp_proc
        = 3057638256 path /home<br>
        Mar&nbsp; 9 14:03:34 console automount[23227]: expire_proc_indirect:
        expire /home/jsingh<br>
        Mar&nbsp; 9 14:03:34 console automount[23227]: 1 remaining in /home<br>
        <br>
      </p>
      <p>Mar 7 17:04:39 console automount[1105]: lookup_one:
        lookup(ldap): got answer, but no entry for (&amp;(objectclass=<wbr>automount)<wbr>(|(cn=etc)<wbr>(cn=/)(<wbr>cn=\2A)<wbr>))<br>
        Mar 7 17:04:39 console automount[1105]: key "etc" not found in
        map source(s).<br>
        Mar 7 17:04:39 console automount[1105]: ioctl_send_fail: token =
        2<br>
        Mar 7 17:04:39 console automount[1105]: failed to mount
        /home/etc<br>
        Mar 7 17:04:39 console automount[1105]: handle_packet: type = 3<br>
        Mar 7 17:04:39 console automount[1105]: handle_<wbr>packet_<wbr>missing_<wbr>indirect:

        token 3, name repository, request pid 2011</p>
      <p>Mar 7 17:04:39 console automount[1105]: ioctl_send_fail: token
        = 3<br>
        Mar 7 17:04:39 console automount[1105]: failed to mount
        /home/repository<br>
        Mar 7 17:04:39 console automount[1105]: handle_packet: type = 3<br>
        Mar 7 17:04:39 console automount[1105]: handle_<wbr>packet_<wbr>missing_<wbr>indirect:

        token 4, name repository, request pid 2011<br>
        Mar 7 17:04:39 console automount[1105]: attempting to mount
        entry /home/repository<br>
        Mar 7 17:04:39 console automount[1105]: lookup_mount:
        lookup(ldap): looking up repository<br>
        Mar 7 17:04:39 console automount[1105]: ioctl_send_fail: token =
        4<br>
        Mar 7 17:04:39 console automount[1105]: failed to mount
        /home/repository</p>
      <p>Mar 7 17:05:34 console automount[1105]: handle_packet: type = 3<br>
        Mar 7 17:05:34 console automount[1105]: handle_<wbr>packet_<wbr>missing_<wbr>indirect:

        token 5, name etc, request pid 2126<br>
        Mar 7 17:05:34 console automount[1105]: attempting to mount
        entry /home/etc<br>
        Mar 7 17:05:34 console automount[1105]: lookup_mount:
        lookup(ldap): looking up etc<br>
        Mar 7 17:05:34 console automount[1105]: ioctl_send_fail: token =
        5<br>
        Mar 7 17:05:34 console automount[1105]: failed to mount
        /home/etc</p>
      <p>autofs:<br>
        &nbsp;&nbsp;Installed: 5.0.5-0ubuntu2<br>
        &nbsp;&nbsp;Candidate: 5.0.5-0ubuntu2<br>
        &nbsp;&nbsp;Version table:<br>
        &nbsp;*** 5.0.5-0ubuntu2 0<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;500 <a rel="nofollow"
          href="http://us.archive.ubuntu.com/ubuntu/">http://<wbr>us.archive.<wbr>ubuntu.<wbr>com/ubuntu/</a>
        maverick/main i386 Packages<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100 /var/lib/<wbr>dpkg/status</p>
      <p>The defaut autofs contains the<br>
        TIMEOUT=3000<br>
        LOGGING="debug"<br>
        MOUNT_NFS_DEFAULT_PROTOCOL=4<br>
        LDAP_URI=<wbr>"<a class="moz-txt-link-freetext" href="ldap:/">ldap:/</a><wbr>/ldapserver.<wbr>domain.<wbr>org/"<br>
        SEARCH_<wbr>BASE="ou=<wbr>auto.master,<wbr>dc=domain,<wbr>dc=org"</p>
    </div>
    <pre class="moz-signature" cols="72">-- 
Jaskaran Singh
Systems Administrator
Winlab, Rutgers University
Technology Centre of NJ
671 Route 1 South
North Brunswick, NJ 08902-3390

Desk: 732-932-6857 x 654
Fax: 732-932-6882 
</pre>
  </body>
</html>

--------------020301080204020306060407--


--===============1328729352291714981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1328729352291714981==--

