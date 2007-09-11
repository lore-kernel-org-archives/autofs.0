From: Shane <squindler@gmail.com>
Subject: top level mount point
Date: Tue, 11 Sep 2007 16:46:40 +0930
Message-ID: <10badf220709110016w454badfdt31a82bf6142171cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hey All,

I'm trying to get a "top-level" automount to work.  eg

/home  -rw,vers=3,fstype=nfs,intr,hard,tcp,rsize=32768,wsize=32768
srv1:/export/home/

I've tried a few things so far - putting that exactly as is into
/etc/auto.master, created an auto.direct file and put /- auto.direct
into auto.master neither any joy - also tried /home  auto.home in
auto.master and above but with * or / as the key as contents of
auto.home none are working.

Firstly is this actually possible?  Though I have no idea how Apple
translate our maps into something automount uses they do get around
this but /home is a symlink to somewhere like
/private/var/automount/home. If its possible ...what have I missed to
get this working?

TIA,
Shane.
