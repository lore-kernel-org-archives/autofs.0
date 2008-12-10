From: "Scott Belnap" <sbelnap@gmail.com>
Subject: unable to automount windows C$
Date: Wed, 10 Dec 2008 12:49:02 -0700
Message-ID: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2182816452235018358=="
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

--===============2182816452235018358==
Content-Type: multipart/alternative; 
	boundary="----=_Part_53572_8363429.1228938542143"

------=_Part_53572_8363429.1228938542143
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm trying to automount a windows machine.  I am able to automount any
directory that doesn't have a $ in the mount name.  Looks like the
parse_mount method is stripping out the $ from the mount name.  Any ideas on
how to fix this?

Dec  9 23:49:03 dc2 automount[19084]: handle_packet_missing_direct: token
122, name /cifs/laptop/C$, request pid 17857
Dec  9 23:49:03 dc2 automount[19084]: attempting to mount entry
/cifs/laptop/C$
Dec  9 23:49:03 dc2 automount[19084]: lookup_mount: lookup(program):
/cifs/laptop/C$ ->
-fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
://laptop/C$
Dec  9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): expanded
entry:
-fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
://laptop/C
Dec  9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): gathered
options:
fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
Dec  9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): core of
entry:
options=fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop,
loc=://laptop/C
Dec  9 23:49:03 dc2 automount[19084]: sun_mount: parse(sun): mounting root
/cifs, mountpoint /cifs/laptop/C$, what //laptop/C, fstype cifs, options
file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
Dec  9 23:49:03 dc2 automount[19084]: do_mount: //laptop/C
/cifs//cifs/laptop/C$ type cifs options
file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop using module
generic
Dec  9 23:49:03 dc2 automount[19084]: mount_mount: mount(generic): calling
mkdir_path /cifs/laptop/C$
Dec  9 23:49:03 dc2 automount[19084]: mount_mount: mount(generic): calling
mount -t cifs -s -o
file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop //laptop/C
/cifs/laptop/C$
Dec  9 23:49:03 dc2 kernel:  CIFS VFS: cifs_mount failed w/return code = -6
Dec  9 23:49:03 dc2 automount[19084]: >> retrying with upper case share name
Dec  9 23:49:03 dc2 kernel:  CIFS VFS: cifs_mount failed w/return code = -6
Dec  9 23:49:03 dc2 automount[19084]: >> mount error 6 = No such device or
address
Dec  9 23:49:03 dc2 automount[19084]: >> Refer to the mount.cifs(8) manual
page (e.g.man mount.cifs)
Dec  9 23:49:03 dc2 automount[19084]: spawn_mount: mount failed with error
code 16, retrying with the -f option
Dec  9 23:49:06 dc2 automount[19084]: >> unknown mount option f
Dec  9 23:49:06 dc2 automount[19084]: >> Usage:  /sbin/mount.cifs
<remotetarget> <dir> -o <options>
Dec  9 23:49:06 dc2 automount[19084]: >> Mount the remote target, specified
as a UNC name, to a local directory.
Dec  9 23:49:06 dc2 automount[19084]: >> Options:
Dec  9 23:49:06 dc2 automount[19084]: >> #011user=<arg>
Dec  9 23:49:06 dc2 automount[19084]: >> #011pass=<arg>
Dec  9 23:49:06 dc2 automount[19084]: >> #011dom=<arg>
Dec  9 23:49:06 dc2 automount[19084]: >> Less commonly used options:
Dec  9 23:49:06 dc2 automount[19084]: >>
#011credentials=<filename>,guest,perm,noperm,setuids,nosetuids,rw,ro,
Dec  9 23:49:06 dc2 automount[19084]: >>
#011sep=<char>,iocharset=<codepage>,suid,nosuid,exec,noexec,serverino,
Dec  9 23:49:06 dc2 automount[19084]: >>
#011directio,mapchars,nomapchars,nolock,servernetbiosname=<SRV_RFC1001NAME>
Dec  9 23:49:06 dc2 automount[19084]: >> Options not needed for servers
supporting CIFS Unix extensions
Dec  9 23:49:06 dc2 automount[19084]: >> #011(e.g. unneeded for mounts to
most Samba versions):
Dec  9 23:49:06 dc2 automount[19084]: >>
#011uid=<uid>,gid=<gid>,dir_mode=<mode>,file_mode=<mode>,sfu
Dec  9 23:49:06 dc2 automount[19084]: >> Rarely used options:
Dec  9 23:49:06 dc2 automount[19084]: >>
#011port=<tcpport>,rsize=<size>,wsize=<size>,unc=<unc_name>,ip=<ip_address>,
Dec  9 23:49:06 dc2 automount[19084]: >>
#011dev,nodev,nouser_xattr,netbiosname=<OUR_RFC1001NAME>,hard,soft,intr,
Dec  9 23:49:06 dc2 automount[19084]: >>
#011nointr,ignorecase,noposixpaths,noacl
Dec  9 23:49:06 dc2 automount[19084]: >> Options are described in more
detail in the manual page
Dec  9 23:49:06 dc2 automount[19084]: >> #011man 8 mount.cifs
Dec  9 23:49:06 dc2 automount[19084]: >> To display the version number of
the mount helper:
Dec  9 23:49:06 dc2 automount[19084]: >> #011/sbin/mount.cifs -V
Dec  9 23:49:06 dc2 automount[19084]: mount(generic): failed to mount
//laptop/C (type cifs) on /cifs/laptop/C$
Dec  9 23:49:06 dc2 automount[19084]: send_fail: token = 122
Dec  9 23:49:06 dc2 automount[19084]: handle_packet: type = 5
Dec  9 23:49:06 dc2 automount[19084]: handle_packet_missing_direct: token
123, name /cifs/laptop/C$, request pid 17857
Dec  9 23:49:06 dc2 automount[19084]: attempting to mount entry
/cifs/laptop/C$
Dec  9 23:49:06 dc2 automount[19084]: failed to mount /cifs/laptop/C$
Dec  9 23:49:06 dc2 automount[19084]: send_fail: token = 123
Dec  9 23:49:06 dc2 automount[19084]: failed to mount /cifs/laptop/C$

------=_Part_53572_8363429.1228938542143
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m trying to automount a windows machine.&nbsp; I am able to automount any directory that doesn&#39;t have a $ in the mount name.&nbsp; Looks like the parse_mount method is stripping out the $ from the mount name.&nbsp; Any ideas on how to fix this?<br>
<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: handle_packet_missing_direct: token 122, name /cifs/laptop/C$, request pid 17857<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: attempting to mount entry /cifs/laptop/C$<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: lookup_mount: lookup(program): /cifs/laptop/C$ -&gt; -fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop ://laptop/C$<br>
Dec&nbsp; 9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): expanded entry: -fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop ://laptop/C<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): gathered options: fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop<br>
Dec&nbsp; 9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): core of entry: options=fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop, loc=://laptop/C<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: sun_mount: parse(sun): mounting root /cifs, mountpoint /cifs/laptop/C$, what //laptop/C, fstype cifs, options file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop<br>
Dec&nbsp; 9 23:49:03 dc2 automount[19084]: do_mount: //laptop/C /cifs//cifs/laptop/C$ type cifs options file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop using module generic<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: mount_mount: mount(generic): calling mkdir_path /cifs/laptop/C$<br>
Dec&nbsp; 9 23:49:03 dc2 automount[19084]: mount_mount: mount(generic): calling mount -t cifs -s -o file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop //laptop/C /cifs/laptop/C$<br>Dec&nbsp; 9 23:49:03 dc2 kernel:&nbsp; CIFS VFS: cifs_mount failed w/return code = -6<br>
Dec&nbsp; 9 23:49:03 dc2 automount[19084]: &gt;&gt; retrying with upper case share name<br>Dec&nbsp; 9 23:49:03 dc2 kernel:&nbsp; CIFS VFS: cifs_mount failed w/return code = -6<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: &gt;&gt; mount error 6 = No such device or address<br>
Dec&nbsp; 9 23:49:03 dc2 automount[19084]: &gt;&gt; Refer to the mount.cifs(8) manual page (e.g.man mount.cifs)<br>Dec&nbsp; 9 23:49:03 dc2 automount[19084]: spawn_mount: mount failed with error code 16, retrying with the -f option<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; unknown mount option f<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Usage:&nbsp; /sbin/mount.cifs &lt;remotetarget&gt; &lt;dir&gt; -o &lt;options&gt;<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Mount the remote target, specified as a UNC name, to a local directory.<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Options:<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011user=&lt;arg&gt;<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011pass=&lt;arg&gt;<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011dom=&lt;arg&gt;<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Less commonly used options:<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011credentials=&lt;filename&gt;,guest,perm,noperm,setuids,nosetuids,rw,ro,<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011sep=&lt;char&gt;,iocharset=&lt;codepage&gt;,suid,nosuid,exec,noexec,serverino,<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011directio,mapchars,nomapchars,nolock,servernetbiosname=&lt;SRV_RFC1001NAME&gt;<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Options not needed for servers supporting CIFS Unix extensions<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011(e.g. unneeded for mounts to most Samba versions):<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011uid=&lt;uid&gt;,gid=&lt;gid&gt;,dir_mode=&lt;mode&gt;,file_mode=&lt;mode&gt;,sfu<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Rarely used options:<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011port=&lt;tcpport&gt;,rsize=&lt;size&gt;,wsize=&lt;size&gt;,unc=&lt;unc_name&gt;,ip=&lt;ip_address&gt;,<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011dev,nodev,nouser_xattr,netbiosname=&lt;OUR_RFC1001NAME&gt;,hard,soft,intr,<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011nointr,ignorecase,noposixpaths,noacl<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; Options are described in more detail in the manual page<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011man 8 mount.cifs<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; To display the version number of the mount helper:<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: &gt;&gt; #011/sbin/mount.cifs -V<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: mount(generic): failed to mount //laptop/C (type cifs) on /cifs/laptop/C$<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: send_fail: token = 122<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: handle_packet: type = 5<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: handle_packet_missing_direct: token 123, name /cifs/laptop/C$, request pid 17857<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: attempting to mount entry /cifs/laptop/C$<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: failed to mount /cifs/laptop/C$<br>
Dec&nbsp; 9 23:49:06 dc2 automount[19084]: send_fail: token = 123<br>Dec&nbsp; 9 23:49:06 dc2 automount[19084]: failed to mount /cifs/laptop/C$<br><br>

------=_Part_53572_8363429.1228938542143--


--===============2182816452235018358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2182816452235018358==--

