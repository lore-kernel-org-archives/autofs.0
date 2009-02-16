From: "Daniel Schwager" <Daniel.Schwager@dtnet.de>
Subject: Re: different behavior in static/executable autofs map
Date: Mon, 16 Feb 2009 20:41:36 +0100
Message-ID: <EB31672367A401439CD5A4A10889D57B01297392@exchange.dtnet.de>
References: <EB31672367A401439CD5A4A10889D57B01297357@exchange.dtnet.de>
	<1234747958.2928.1.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

thx for clarify. I tried now about 2 days to convert
the following file-map to a program-map - but I failed.

Could you give me a hint ?

*** /etc/auto.master
/home/f         /etc/auto.test1

*** /etc/auto.test1
test1   -rw     / :/tmp  \
                /test :/var

This works like a Charme
  [root@fs1 /home]$ /etc/init.d/autofs  restart
  Stopping automounter: done.
  Starting automounter: done.
  [root@fs1 /home]$ ls /home/f/test1
  DataDir_-usr-local-staf-data-STAF.tmp  STAF.tmp  STAFIPC_STAF
STAFIPC_STAFJSTAF_STAFJVM1  autofs-dynamic.local  autofs-dynamic.remote
hsperfdata_root  test     
  [root@fs1 /home]$ ls /home/f/test1/test
  autofs  backups  cache  lib  local  lock  log  mail  opt  run  spool
tmp  www


I tried a lot of variants with a program map - but I did't get
managed to mount a root (like "test1   -rw     / :/tmp") via
program-map.
Mounting ONLY a subdir (like "test1   -rw     /xx :/tmp") works fine.

Could you please give me a sample converting the file-map sample above
(auto.test1)
to a program-map ?

Thx for helping in advance ..

regards
Danny

P.S.: Usecase - I want to include different bind-mounts to the users
home dynamically, so
I want to use autofs for "creating/bind-mounting" the users home on the
fly.
