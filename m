From: Ian Kent <raven@themaw.net>
Subject: Re: simple automount question
Date: Wed, 05 Mar 2008 12:01:03 +0900
Message-ID: <1204686063.3081.21.camel@raven.themaw.net>
References: <1204517826.5312.62.camel@localhost>
	<1204543130.29431.8.camel@raven.themaw.net>
	<1204556356.5312.97.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204556356.5312.97.camel@localhost>
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
To: chris barry <Christopher.Barry@qlogic.com>
Cc: autofs mailing list <autofs@linux.kernel.org>


On Mon, 2008-03-03 at 09:59 -0500, chris barry wrote:
> On Mon, 2008-03-03 at 20:18 +0900, Ian Kent wrote:
> > On Sun, 2008-03-02 at 23:17 -0500, chris barry wrote:
> > > I've googled, but have not found an answer to this seemingly simple
> > > question.
> > > 
> > > I'm automounting /foo from box1 on box2. /foo has no files, just other
> > > directories, one of which is bar.
> > 
> > No you're not.
> > 
> > You're mounting individual directories from box2.
> > Things like, /foo/bar, /foo/baz, etc, are mounted individually, as
> > requests to access them come in.
> > 
> > > 
> > > box2 $ cd /foo
> > > box2 $ ls
> > > box2 $ (nothing shows up)
> > > box2 $ cd bar
> > > box2 $ cd ..
> > > box2 $ ls
> > > bar
> > > box2 $
> > > 
> > > 
> > > Q: how do I get all of the directories under /foo to show up after it's
> > > automounted?
> > > 
> > > /etc/auto.master
> > > /foo	/etc/auto.foo --timeout=60
> > > 
> > > /etc/auto.foo
> > > (all on one line)
> > > *              /
> > > -fstype=nfs,rsize=32768,wsize=32768,tcp,rw,bg,hard,intr,noacl,nocto,async   10.20.30.40:/foo/&
> > 
> > How would autofs know what these directories are, to create them, from
> > that map, * doesn't really say much and, even though this map has an ip
> > address in the location others may not?
> 
> I though '*' said everything ;)

Read what I said again and ask yourself this question (again).
How does autofs know what these directories are, since it can only rely
on the map, not what may be inferred from the mount location (it could
include macros that aren't known till mount time!

> 
> > 
> > Ian
> > 
> 
> So, the problem is auto.foo. I don't want it to make individual mounts
> to every dir in /foo, I just want it to mount /foo when someone
> accesses /foo/whatever. I'm assuming it should look like:
> 
> (all on one line)
> /foo              /
> -fstype=nfs,rsize=32768,wsize=32768,tcp,rw,bg,hard,intr,noacl,nocto,async   10.20.30.40:/foo/

What are you trying to say?
Describe what you are asking and include the version of autofs.

If you are saying that 10.20.30.40:/foo is an export that you want to
mount on a single level directory path, /foo in this case, then you will
need to use a direct mount and version 5 of autofs. This won't work in
version 4 and never will.

For example, in the master map
/-	/etc/auto.direct

and in auto.direct
/foo	10.20.30.40:/foo

will do this.

Ian
