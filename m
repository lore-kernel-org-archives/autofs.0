From: Ian Kent <raven@themaw.net>
Subject: Re: another make issue
Date: Mon, 03 Nov 2008 11:50:57 +0900
Message-ID: <1225680657.2911.38.camel@zeus.themaw.net>
References: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
	<1225676646.2911.4.camel@zeus.themaw.net>
	<510ca9b40811021805o2eb86f11x3b0eff0f676a8e22@mail.gmail.com>
	<1225678804.2911.24.camel@zeus.themaw.net>
	<510ca9b40811021833n4295cbeai5775ca17c8146727@mail.gmail.com>
	<1225679911.2911.35.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1225679911.2911.35.camel@zeus.themaw.net>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-03 at 11:38 +0900, Ian Kent wrote:
> On Mon, 2008-11-03 at 13:33 +1100, Paul Wankadia wrote:
> > On Mon, Nov 3, 2008 at 1:20 PM, Ian Kent <raven@themaw.net> wrote:
> > 
> > >> FWIW, I'm using Ubuntu.
> > >
> > > And you don't have a directory /etc/conf.d, has that changed somehow,
> > > does it not exist at your build time?
> > 
> > No, /etc/default/ appears to be the directory that other packages are using.
> 
> Oh .. of course, Ubuntu is a Debian variant, sorry.
> 
> I think I've used /etc/defaults, thinking that was the Debian based
> location, but maybe there was another reason for that as well, I'll
> add /etc/default to the list.
> 

I've added this directory to the list and committed the change.
It may take a while to reach the public mirrors so this is the patch.

autofs-5.0.3 - add missing confdir location

From: Ian Kent <raven@themaw.net>

The list of possible directories which hold the autofs configuration
is missing /etc/default.
---

 aclocal.m4 |    2 +-
 configure  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/aclocal.m4 b/aclocal.m4
index 9ef4050..52a1e47 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -95,7 +95,7 @@ dnl Check the location of the configuration defaults directory
 dnl --------------------------------------------------------------------------
 AC_DEFUN(AF_CONF_D,
 [if test -z "$confdir"; then
-  for conf_d in /etc/sysconfig /etc/defaults /etc/conf.d; do
+  for conf_d in /etc/sysconfig /etc/defaults /etc/conf.d /etc/default; do
     if test -z "$confdir"; then
       if test -d "$conf_d"; then
 	confdir="$conf_d"
diff --git a/configure b/configure
index 9278196..10e44cb 100755
--- a/configure
+++ b/configure
@@ -1791,7 +1791,7 @@ fi
 # Location of system config script directory?
 #
 if test -z "$confdir"; then
-  for conf_d in /etc/sysconfig /etc/defaults /etc/conf.d; do
+  for conf_d in /etc/sysconfig /etc/defaults /etc/conf.d /etc/default; do
     if test -z "$confdir"; then
       if test -d "$conf_d"; then
 	confdir="$conf_d"
