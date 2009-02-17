From: Ian Kent <raven@themaw.net>
Subject: Re: different behavior in static/executable autofs map
Date: Tue, 17 Feb 2009 12:29:57 +0900
Message-ID: <1234841397.3141.3.camel@zeus.themaw.net>
References: <EB31672367A401439CD5A4A10889D57B01297357@exchange.dtnet.de>
	<1234747958.2928.1.camel@zeus.themaw.net>
	<EB31672367A401439CD5A4A10889D57B01297392@exchange.dtnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <EB31672367A401439CD5A4A10889D57B01297392@exchange.dtnet.de>
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
To: Daniel Schwager <Daniel.Schwager@dtnet.de>
Cc: autofs@linux.kernel.org

On Mon, 2009-02-16 at 20:41 +0100, Daniel Schwager wrote:
> Hi Ian,
> 
> thx for clarify. I tried now about 2 days to convert
> the following file-map to a program-map - but I failed.
> 
> Could you give me a hint ?
> 
> *** /etc/auto.master
> /home/f         /etc/auto.test1
> 
> *** /etc/auto.test1
> test1   -rw     / :/tmp  \
>                 /test :/var
> 
> This works like a Charme
>   [root@fs1 /home]$ /etc/init.d/autofs  restart
>   Stopping automounter: done.
>   Starting automounter: done.
>   [root@fs1 /home]$ ls /home/f/test1
>   DataDir_-usr-local-staf-data-STAF.tmp  STAF.tmp  STAFIPC_STAF
> STAFIPC_STAFJSTAF_STAFJVM1  autofs-dynamic.local  autofs-dynamic.remote
> hsperfdata_root  test     
>   [root@fs1 /home]$ ls /home/f/test1/test
>   autofs  backups  cache  lib  local  lock  log  mail  opt  run  spool
> tmp  www
> 
> 
> I tried a lot of variants with a program map - but I did't get
> managed to mount a root (like "test1   -rw     / :/tmp") via
> program-map.
> Mounting ONLY a subdir (like "test1   -rw     /xx :/tmp") works fine.
> 
> Could you please give me a sample converting the file-map sample above
> (auto.test1)
> to a program-map ?

Do what I said in my previous post.
Return the location without the key.

So you would do something like:

If "key matches passed in key (in $1)"; then
	echo "-rw / :/tmp /other :/other"
fi

Should do what you want.

Ian
