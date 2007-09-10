From: Shane <squindler@gmail.com>
Subject: improving error reporting
Date: Mon, 10 Sep 2007 16:41:09 +0930
Message-ID: <10badf220709100011w4c43daf1ha48f1a38de6940d2@mail.gmail.com>
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

Does anyone know of a way I could get automount to help me report
which app has requested a bad / non-existant mount?

Eg current error of:
Sep 10 11:26:14 box automount[21101]: >> mount:
srv1:/export/home/.hidden failed, reason given by server: No such file
or directory
Sep 10 11:26:14 box automount[21101]: mount(nfs): nfs: mount failure
srv1:/export/home/.hidden on /home/.hidden
Sep 10 11:26:14 box automount[21101]: failed to mount /home/.hidden

this is kinda annoying to track back as either this error causes a
flood of requests to mount preventing other mounts so people reboot
workstations and we can't track the issue or the offending app gets
killed before we're on the scene too. ... I realise this isn't exactly
autofs's scope as the request comes not from the app directly, but
automount is the first point of failure so hopefully theres a way to
do this without causing too much overhead.

TIA
Shane.
