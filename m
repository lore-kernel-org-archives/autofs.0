From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Subject: autofs reload
Date: Fri, 26 Mar 2004 18:41:00 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B6tS8-0009vh-00.ia6432-inbox-ru@f10.mail.ru>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

how to do correct autofs map reload?
with older (3.9.99-4.0.0pre10) autofs updating nis maps works ok.
for example changing in auto.home:
host1:/export/home/user
to
host2:/export/home/user
and doing ls /home/user leads to mounting new users home.

in autofs 4.1.0 (autofs4-20031201 in kernel) it tries to mount host1
even after 5 hours wait and nscd/nis restart.

if i do /etc/init.d/autofs reload it rereads nis maps but starts _new_
automount processes for all maps i.e. i get 2 automount for each map.
after another reload i get 3 etc. and if i understand it correctly they
all try to manage mount points...

if i do /etc/init.d/autofs restart (or stop/start) i get all directories
that were mounted prior to restart empty. all of them are mounted but
ls gives empty directory.

so how to do correct autofs map reload?
