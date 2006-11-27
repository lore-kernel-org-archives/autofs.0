From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: excluding some pattern to prevent useless mount request
Date: Mon, 27 Nov 2006 17:40:54 +0100
Message-ID: <456B1516.1030108@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

While looking in server's log, I found many such mount requests:
Nov 26 04:23:19 yquem rpc.mountd: refused mount request from
chouchen.inria.fr for /home/yquem/.hidden (/): no export entry
...
Nov 26 04:22:33 yquem rpc.mountd: refused mount request from
medoc.inria.fr for /home/yquem/.directory (/): no export entry

I guess they are caused by graphical file manager trying to find
metadata directories when displaying mount points. Is there a way to
prevent them ?

My current map content is:
# /, auto.home.yquem, autofs, village.inria.fr
dn: cn=/,ou=auto.home.yquem,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automount
cn: /
automountInformation: -fstype=nfs,hard,intr,nosuid,nfsvers=3
graves:/home/yquem/&
