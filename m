From: david.laroche@idestyle-tech.com
Subject: Multimount problem
Date: Tue, 28 Mar 2006 11:35:06 +0200
Message-ID: <OFB37AEEAA.12E9D7AF-ONC125713F.00321520-C125713F.0034ACB5@idestyle-tech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6410744778835303914=="
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

Message en plusieurs parties au format MIME
--===============6410744778835303914==
Content-Type: multipart/alternative;
	boundary="=_alternative 0034ACAAC125713F_="

Message en plusieurs parties au format MIME
--=_alternative 0034ACAAC125713F_=
Content-Type: text/plain; charset="US-ASCII"

Hello,


I have a problem  with autofs multimount on Linux.
On our SGI,SUN,IBM these lines works.

auto.master
/users  /etc/auto.users

auto.users
*       -rw,intr,hard   caosrv01:/caosrv01/users/& 
caosrv02:/caosrv02/users/&      caosrv03:/caosrv03/users/&

On linux, the log reports no errors when I run autofs and the mount works 
correctly (ex : mount caosrv02:/caosrv02/users/toto /r is OK )
but when I want to use autofs ( ex :  cd /users/toto ) I have an error if 
toto is on caosrv02 or caosrv03

In /var/log/messages

Mar 28 10:16:25 nim_client automount[18049]: >> mount: 
caosrv01:/caosrv01/users/toto failed, reason given by server: Permission 
denied
Mar 28 10:16:25 nim_client automount[18049]: mount(nfs): nfs: mount 
failure caosrv01:/caosrv01/users/toto on /users/toto
Mar 28 10:16:25 nim_client automount[18049]: failed to mount /users/toto
Mar 28 10:16:25 nim_client automount[18049]: umount_multi: no mounts found 
under /users/toto
Mar 28 10:16:25 nim_client automount[18036]: attempting to mount entry 
/users/toto
Mar 28 10:16:25 nim_client automount[18051]: >> mount: 
caosrv01:/caosrv01/users/toto failed, reason given by server: Permission 
denied
Mar 28 10:16:25 nim_client automount[18051]: mount(nfs): nfs: mount 
failure caosrv01:/caosrv01/users/toto on /users/toto
Mar 28 10:16:25 nim_client automount[18051]: failed to mount /users/toto
Mar 28 10:16:25 nim_client automount[18051]: umount_multi: no mounts found 
under /users/toto
Mar 28 10:16:58 nim_client automount[18036]: attempting to mount entry 
/users/toto

If I try this many times (5, 10, 20 tries ), the filesystem comes up.

I'm using FC4 with autofs 4.1.4.5. 
I tried on several linux and autofs versions and I always had the same 
thing.

I try to change my auto.users map syntax like this
auto.users
*       -rw,intr,hard   \
        caosrv01:/caosrv01/users/&      \
        caosrv02:/caosrv02/users/&      \
        caosrv03:/caosrv03/users/&

OR 
*       -rw,intr,hard   caosrv01,caosrv02,caosrv03:/server/users/&    (on 
each server, /server is a link with /caosrv0X , the /etc/exports is 
updated and mount is OK on the station. )



Any idea ?

Thanks 

David.
--=_alternative 0034ACAAC125713F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello,</font>
<br>
<br>
<br><font size=2 face="sans-serif">I have a problem &nbsp;with autofs multimount
on Linux.</font>
<br><font size=2 face="sans-serif">On our SGI,SUN,IBM these lines works.</font>
<br>
<br><font size=2 face="sans-serif">auto.master</font>
<br><font size=2 face="sans-serif">/users &nbsp; &nbsp; &nbsp; &nbsp;/etc/auto.users</font>
<br>
<br><font size=2 face="sans-serif">auto.users</font>
<br><font size=2 face="sans-serif">* &nbsp; &nbsp; &nbsp; &nbsp;-rw,intr,hard
&nbsp; &nbsp; &nbsp; &nbsp;caosrv01:/caosrv01/users/&amp; &nbsp;
&nbsp; &nbsp; &nbsp; caosrv02:/caosrv02/users/&amp; &nbsp; &nbsp;
&nbsp; &nbsp; caosrv03:/caosrv03/users/&amp;</font>
<br>
<br><font size=2 face="sans-serif">On linux, the log reports no errors
when I run autofs and the mount works correctly (ex : mount caosrv02:/caosrv02/users/toto
/r is OK )</font>
<br><font size=2 face="sans-serif">but when I want to use autofs ( ex :
&nbsp;cd /users/toto ) I have an error if toto is on caosrv02 or caosrv03</font>
<br>
<br><font size=2 face="sans-serif">In /var/log/messages</font>
<br>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18049]:
&gt;&gt; mount: caosrv01:/caosrv01/users/toto failed, reason given by server:
Permission denied</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18049]:
mount(nfs): nfs: mount failure caosrv01:/caosrv01/users/toto on /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18049]:
failed to mount /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18049]:
umount_multi: no mounts found under /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18036]:
attempting to mount entry /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18051]:
&gt;&gt; mount: caosrv01:/caosrv01/users/toto failed, reason given by server:
Permission denied</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18051]:
mount(nfs): nfs: mount failure caosrv01:/caosrv01/users/toto on /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18051]:
failed to mount /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:25 nim_client automount[18051]:
umount_multi: no mounts found under /users/toto</font>
<br><font size=2 face="sans-serif">Mar 28 10:16:58 nim_client automount[18036]:
attempting to mount entry /users/toto</font>
<br>
<br><font size=2 face="sans-serif">If I try this many times (5, 10, 20
tries ), the filesystem comes up.</font>
<br>
<br><font size=2 face="sans-serif">I'm using FC4 with autofs 4.1.4.5. </font>
<br><font size=2 face="sans-serif">I tried on several linux and autofs
versions and I always had the same thing.</font>
<br>
<br><font size=2 face="sans-serif">I try to change my auto.users map syntax
like this</font>
<br><font size=2 face="sans-serif">auto.users</font>
<br><font size=2 face="sans-serif">* &nbsp; &nbsp; &nbsp; &nbsp;-rw,intr,hard
&nbsp; &nbsp; &nbsp; &nbsp;\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; caosrv01:/caosrv01/users/&amp;
&nbsp; &nbsp; &nbsp; &nbsp; \</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; caosrv02:/caosrv02/users/&amp;
&nbsp; &nbsp; &nbsp; &nbsp; \</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; caosrv03:/caosrv03/users/&amp;</font>
<br>
<br><font size=2 face="sans-serif">OR </font>
<br><font size=2 face="sans-serif">* &nbsp; &nbsp; &nbsp; &nbsp;-rw,intr,hard
&nbsp; &nbsp; &nbsp; &nbsp;caosrv01,caosrv02,caosrv03:/server/users/&amp;
&nbsp; &nbsp;(on each server, /server is a link with /caosrv0X , the /etc/exports
is updated and mount is OK on the station. )</font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Any idea ?</font>
<br>
<br><font size=2 face="sans-serif">Thanks </font>
<br>
<br><font size=2 face="sans-serif">David.</font>
--=_alternative 0034ACAAC125713F_=--


--===============6410744778835303914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6410744778835303914==--

