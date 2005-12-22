From: Cedric BRINER <work@infomaniak.ch>
Subject: autofs mount remounted
Date: Thu, 22 Dec 2005 10:20:25 +0100
Message-ID: <20051222092025.GE20280@obs.unige.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
Content-disposition: inline
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
To: autofs@linux.kernel.org

hi,

I've the following situation where /home is managed by autofs and than I'd like to do a:
mount --bind /home /var/chroot/home

when I do a: ls /var/chroot/home my machine totaly hangs and have to shut down with the power button :(
Is there a solution to this or should I just have twice an automounter:
 - one which manage /home
 - other which mange /var/chroot/home.


I'm wanting to do this, because I try to follow <http://alioth.debian.org/docman/view.php/30192/21/debian-amd64-howto.html#id27>
when my /home is managed with automount.

any idea ?

Ced.

-- 

Cedric BRINER
Geneva - Switzerland
