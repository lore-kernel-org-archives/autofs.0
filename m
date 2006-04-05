From: david.laroche@idestyle-tech.com
Subject: Re: Multimount problem
Date: Wed, 5 Apr 2006 11:41:07 +0200
Message-ID: <OFAB693189.9B656702-ONC1257147.0034956E-C1257147.0034B590@idestyle-tech.com>
References: <x49u099jakq.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0146471497107467191=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49u099jakq.fsf@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Message en plusieurs parties au format MIME
--===============0146471497107467191==
Content-Type: multipart/alternative;
	boundary="=_alternative 0034B585C1257147_="

Message en plusieurs parties au format MIME
--=_alternative 0034B585C1257147_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

My example seems not to be good .  this is not a replicated server entry 
because a user exists on only 1 server ( caosrv01 OR caosrv02 OR caosrv03 
)

In all case, I can mount filesystem by hand ( for all servers ).

Thanks 

David




Jeff Moyer <jmoyer@redhat.com> 
04/04/2006 23:27

A
david.laroche@idestyle-tech.com
cc
autofs@linux.kernel.org
Objet
Re: [autofs] Multimount problem






==> Regarding [autofs] Multimount problem; david.laroche@idestyle-tech.com
adds:

david> Hello,
david> I have a problem  with autofs multimount on Linux.
david> On our SGI,SUN,IBM these lines works.

david> auto.master
david> /users  /etc/auto.users

david> auto.users
david> *       -rw,intr,hard   caosrv01:/caosrv01/users/&
david> caosrv02:/caosrv02/users/&      caosrv03:/caosrv03/users/&

This is a replicated server entry not a multimount entry.

david> On linux, the log reports no errors when I run autofs and the mount
david> works correctly (ex : mount caosrv02:/caosrv02/users/toto /r is OK 
)

OK, so you can mount the file system by hand.

david> but when I want to use autofs ( ex :  cd /users/toto ) I have an 
error
david> if toto is on caosrv02 or caosrv03

david> Mar 28 10:16:25 nim_client automount[18049]: >> mount:
david> caosrv01:/caosrv01/users/toto failed, reason given by server: 
Permission
david> denied

You said you get a failure if autofs selects caosrv02 or caosrv03, yet you
show caosrv01 failing.  Can you mount from caosrv01 manually?

david> Mar 28 10:16:25 nim_client automount[18049]: mount(nfs): nfs: mount
david> failure caosrv01:/caosrv01/users/toto on /users/toto
david> Mar 28 10:16:25 nim_client automount[18049]: failed to mount 
/users/toto
david> Mar 28 10:16:25 nim_client automount[18049]: umount_multi: no 
mounts found
david> under /users/toto
david> Mar 28 10:16:25 nim_client automount[18036]: attempting to mount 
entry
david> /users/toto
david> Mar 28 10:16:25 nim_client automount[18051]: >> mount:
david> caosrv01:/caosrv01/users/toto failed, reason given by server: 
Permissiondavid> denied
david> Mar 28 10:16:25 nim_client automount[18051]: mount(nfs): nfs: mount
david> failure caosrv01:/caosrv01/users/toto on /users/toto
david> Mar 28 10:16:25 nim_client automount[18051]: failed to mount 
/users/toto
david> Mar 28 10:16:25 nim_client automount[18051]: umount_multi: no 
mounts found
david> under /users/toto
david> Mar 28 10:16:58 nim_client automount[18036]: attempting to mount 
entry
david> /users/toto

david> If I try this many times (5, 10, 20 tries ), the filesystem comes 
up.

david> I'm using FC4 with autofs 4.1.4.5.
david> I tried on several linux and autofs versions and I always had the 
same
david> thing.

david> I try to change my auto.users map syntax like this
david> auto.users
david> *       -rw,intr,hard   \
david>         caosrv01:/caosrv01/users/&      \
david>         caosrv02:/caosrv02/users/&      \
david>         caosrv03:/caosrv03/users/&

david> OR
david> *       -rw,intr,hard   caosrv01,caosrv02,caosrv03:/server/users/&

david> (on each server, /server is a link with /caosrv0X , the 
/etc/exports is
david> updated and mount is OK on the station. )

I'm having difficulties following your problem report, but I suspect that
you are running into a limitation of the code.

autofs version 4.1.4 does not handle replicated server entries very
gracefully.  One of the limitations is that if the first server chosen 
from
the list of replicated servers fails to mount, then autofs will not
continue on and try the next server.

There have been several discussions on this mailing list dealing with the
replicated server code.  Jeff Layton provided a patch which overhauled 
that
subsystem;  you may want to dig up his patch and see if it works for you.

The RHEL variants of autofs have a patch to do the automatic retrying
described above.  However, that patch was written in a way that would be
least invasive to the code.  I wouldn't suggest that the patch gets
accepted verbatim into the upstream tree.  Rather, we should take another
look at Jeff L's patches.


If you believe that your problem is different from the one I've described,
then please visit: http://people.redhat.com/jmoyer.  Take a look at the
section entitled "Filing bug reports," and write back to this list when 
you
have collected all of the relevant information (you have most of it,
already).

I hope this was helpful.

Thanks,

Jeff

--=_alternative 0034B585C1257147_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">My example seems not to be good . &nbsp;this
is not a replicated server entry because a user exists on only 1 server
( caosrv01 OR caosrv02 OR caosrv03 )</font>
<br>
<br><font size=2 face="sans-serif">In all case, I can mount filesystem
by hand ( for all servers ).</font>
<br>
<br><font size=2 face="sans-serif">Thanks </font>
<br>
<br><font size=2 face="sans-serif">David</font>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Jeff Moyer &lt;jmoyer@redhat.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">04/04/2006 23:27</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">A</font></div>
<td valign=top><font size=1 face="sans-serif">david.laroche@idestyle-tech.com</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td valign=top><font size=1 face="sans-serif">autofs@linux.kernel.org</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">Objet</font></div>
<td valign=top><font size=1 face="sans-serif">Re: [autofs] Multimount problem</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>==&gt; Regarding [autofs] Multimount problem; david.laroche@idestyle-tech.com<br>
adds:<br>
</tt></font>
<br><font size=2><tt>david&gt; Hello,<br>
david&gt; I have a problem &nbsp;with autofs multimount on Linux.<br>
david&gt; On our SGI,SUN,IBM these lines works.<br>
</tt></font>
<br><font size=2><tt>david&gt; auto.master<br>
david&gt; /users &nbsp;/etc/auto.users<br>
</tt></font>
<br><font size=2><tt>david&gt; auto.users<br>
david&gt; * &nbsp; &nbsp; &nbsp; -rw,intr,hard &nbsp; caosrv01:/caosrv01/users/&amp;<br>
david&gt; caosrv02:/caosrv02/users/&amp; &nbsp; &nbsp; &nbsp;caosrv03:/caosrv03/users/&amp;<br>
</tt></font>
<br><font size=2><tt>This is a replicated server entry not a multimount
entry.<br>
</tt></font>
<br><font size=2><tt>david&gt; On linux, the log reports no errors when
I run autofs and the mount<br>
david&gt; works correctly (ex : mount caosrv02:/caosrv02/users/toto /r
is OK )<br>
</tt></font>
<br><font size=2><tt>OK, so you can mount the file system by hand.<br>
</tt></font>
<br><font size=2><tt>david&gt; but when I want to use autofs ( ex : &nbsp;cd
/users/toto ) I have an error<br>
david&gt; if toto is on caosrv02 or caosrv03<br>
</tt></font>
<br><font size=2><tt>david&gt; Mar 28 10:16:25 nim_client automount[18049]:
&gt;&gt; mount:<br>
david&gt; caosrv01:/caosrv01/users/toto failed, reason given by server:
Permission<br>
david&gt; denied<br>
</tt></font>
<br><font size=2><tt>You said you get a failure if autofs selects caosrv02
or caosrv03, yet you<br>
show caosrv01 failing. &nbsp;Can you mount from caosrv01 manually?<br>
</tt></font>
<br><font size=2><tt>david&gt; Mar 28 10:16:25 nim_client automount[18049]:
mount(nfs): nfs: mount<br>
david&gt; failure caosrv01:/caosrv01/users/toto on /users/toto<br>
david&gt; Mar 28 10:16:25 nim_client automount[18049]: failed to mount
/users/toto<br>
david&gt; Mar 28 10:16:25 nim_client automount[18049]: umount_multi: no
mounts found<br>
david&gt; under /users/toto<br>
david&gt; Mar 28 10:16:25 nim_client automount[18036]: attempting to mount
entry<br>
david&gt; /users/toto<br>
david&gt; Mar 28 10:16:25 nim_client automount[18051]: &gt;&gt; mount:<br>
david&gt; caosrv01:/caosrv01/users/toto failed, reason given by server:
Permissiondavid&gt; denied<br>
david&gt; Mar 28 10:16:25 nim_client automount[18051]: mount(nfs): nfs:
mount<br>
david&gt; failure caosrv01:/caosrv01/users/toto on /users/toto<br>
david&gt; Mar 28 10:16:25 nim_client automount[18051]: failed to mount
/users/toto<br>
david&gt; Mar 28 10:16:25 nim_client automount[18051]: umount_multi: no
mounts found<br>
david&gt; under /users/toto<br>
david&gt; Mar 28 10:16:58 nim_client automount[18036]: attempting to mount
entry<br>
david&gt; /users/toto<br>
</tt></font>
<br><font size=2><tt>david&gt; If I try this many times (5, 10, 20 tries
), the filesystem comes up.<br>
</tt></font>
<br><font size=2><tt>david&gt; I'm using FC4 with autofs 4.1.4.5.<br>
david&gt; I tried on several linux and autofs versions and I always had
the same<br>
david&gt; thing.<br>
</tt></font>
<br><font size=2><tt>david&gt; I try to change my auto.users map syntax
like this<br>
david&gt; auto.users<br>
david&gt; * &nbsp; &nbsp; &nbsp; -rw,intr,hard &nbsp; \<br>
david&gt; &nbsp; &nbsp; &nbsp; &nbsp; caosrv01:/caosrv01/users/&amp; &nbsp;
&nbsp; &nbsp;\<br>
david&gt; &nbsp; &nbsp; &nbsp; &nbsp; caosrv02:/caosrv02/users/&amp; &nbsp;
&nbsp; &nbsp;\<br>
david&gt; &nbsp; &nbsp; &nbsp; &nbsp; caosrv03:/caosrv03/users/&amp;<br>
</tt></font>
<br><font size=2><tt>david&gt; OR<br>
david&gt; * &nbsp; &nbsp; &nbsp; -rw,intr,hard &nbsp; caosrv01,caosrv02,caosrv03:/server/users/&amp;<br>
</tt></font>
<br><font size=2><tt>david&gt; (on each server, /server is a link with
/caosrv0X , the /etc/exports is<br>
david&gt; updated and mount is OK on the station. )<br>
</tt></font>
<br><font size=2><tt>I'm having difficulties following your problem report,
but I suspect that<br>
you are running into a limitation of the code.<br>
</tt></font>
<br><font size=2><tt>autofs version 4.1.4 does not handle replicated server
entries very<br>
gracefully. &nbsp;One of the limitations is that if the first server chosen
from<br>
the list of replicated servers fails to mount, then autofs will not<br>
continue on and try the next server.<br>
</tt></font>
<br><font size=2><tt>There have been several discussions on this mailing
list dealing with the<br>
replicated server code. &nbsp;Jeff Layton provided a patch which overhauled
that<br>
subsystem; &nbsp;you may want to dig up his patch and see if it works for
you.<br>
</tt></font>
<br><font size=2><tt>The RHEL variants of autofs have a patch to do the
automatic retrying<br>
described above. &nbsp;However, that patch was written in a way that would
be<br>
least invasive to the code. &nbsp;I wouldn't suggest that the patch gets<br>
accepted verbatim into the upstream tree. &nbsp;Rather, we should take
another<br>
look at Jeff L's patches.<br>
</tt></font>
<br>
<br><font size=2><tt>If you believe that your problem is different from
the one I've described,<br>
then please visit: http://people.redhat.com/jmoyer. &nbsp;Take a look at
the<br>
section entitled &quot;Filing bug reports,&quot; and write back to this
list when you<br>
have collected all of the relevant information (you have most of it,<br>
already).<br>
</tt></font>
<br><font size=2><tt>I hope this was helpful.<br>
</tt></font>
<br><font size=2><tt>Thanks,<br>
</tt></font>
<br><font size=2><tt>Jeff</tt></font>
<br>
--=_alternative 0034B585C1257147_=--


--===============0146471497107467191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0146471497107467191==--

