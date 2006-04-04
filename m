From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Multimount problem
Date: Tue, 04 Apr 2006 17:27:17 -0400
Message-ID: <x49u099jakq.fsf@segfault.boston.redhat.com>
References: <OFB37AEEAA.12E9D7AF-ONC125713F.00321520-C125713F.0034ACB5@idestyle-tech.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OFB37AEEAA.12E9D7AF-ONC125713F.00321520-C125713F.0034ACB5@idestyle-tech.com>
	(david laroche's message of "Tue, 28 Mar 2006 11:35:06 +0200")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.laroche@idestyle-tech.com
Cc: autofs@linux.kernel.org

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
david> works correctly (ex : mount caosrv02:/caosrv02/users/toto /r is OK )

OK, so you can mount the file system by hand.

david> but when I want to use autofs ( ex :  cd /users/toto ) I have an error
david> if toto is on caosrv02 or caosrv03

david> Mar 28 10:16:25 nim_client automount[18049]: >> mount: 
david> caosrv01:/caosrv01/users/toto failed, reason given by server: Permission
david> denied

You said you get a failure if autofs selects caosrv02 or caosrv03, yet you
show caosrv01 failing.  Can you mount from caosrv01 manually?

david> Mar 28 10:16:25 nim_client automount[18049]: mount(nfs): nfs: mount 
david> failure caosrv01:/caosrv01/users/toto on /users/toto
david> Mar 28 10:16:25 nim_client automount[18049]: failed to mount /users/toto
david> Mar 28 10:16:25 nim_client automount[18049]: umount_multi: no mounts found 
david> under /users/toto
david> Mar 28 10:16:25 nim_client automount[18036]: attempting to mount entry 
david> /users/toto
david> Mar 28 10:16:25 nim_client automount[18051]: >> mount: 
david> caosrv01:/caosrv01/users/toto failed, reason given by server: Permissiondavid> denied
david> Mar 28 10:16:25 nim_client automount[18051]: mount(nfs): nfs: mount 
david> failure caosrv01:/caosrv01/users/toto on /users/toto
david> Mar 28 10:16:25 nim_client automount[18051]: failed to mount /users/toto
david> Mar 28 10:16:25 nim_client automount[18051]: umount_multi: no mounts found 
david> under /users/toto
david> Mar 28 10:16:58 nim_client automount[18036]: attempting to mount entry 
david> /users/toto

david> If I try this many times (5, 10, 20 tries ), the filesystem comes up.

david> I'm using FC4 with autofs 4.1.4.5. 
david> I tried on several linux and autofs versions and I always had the same 
david> thing.

david> I try to change my auto.users map syntax like this
david> auto.users
david> *       -rw,intr,hard   \
david>         caosrv01:/caosrv01/users/&      \
david>         caosrv02:/caosrv02/users/&      \
david>         caosrv03:/caosrv03/users/&

david> OR 
david> *       -rw,intr,hard   caosrv01,caosrv02,caosrv03:/server/users/&

david> (on each server, /server is a link with /caosrv0X , the /etc/exports is 
david> updated and mount is OK on the station. )

I'm having difficulties following your problem report, but I suspect that
you are running into a limitation of the code.

autofs version 4.1.4 does not handle replicated server entries very
gracefully.  One of the limitations is that if the first server chosen from
the list of replicated servers fails to mount, then autofs will not
continue on and try the next server.

There have been several discussions on this mailing list dealing with the
replicated server code.  Jeff Layton provided a patch which overhauled that
subsystem;  you may want to dig up his patch and see if it works for you.

The RHEL variants of autofs have a patch to do the automatic retrying
described above.  However, that patch was written in a way that would be
least invasive to the code.  I wouldn't suggest that the patch gets
accepted verbatim into the upstream tree.  Rather, we should take another
look at Jeff L's patches.


If you believe that your problem is different from the one I've described,
then please visit: http://people.redhat.com/jmoyer.  Take a look at the
section entitled "Filing bug reports," and write back to this list when you
have collected all of the relevant information (you have most of it,
already).

I hope this was helpful.

Thanks,

Jeff
