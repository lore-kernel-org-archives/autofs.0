From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mounts the servers but I cannot see them in
	my	machine
Date: Sat, 05 Jan 2008 22:09:08 +0900
Message-ID: <1199538548.4007.11.camel@raven.themaw.net>
References: <BAY137-F3257E1CF5E4EC1DD00C84ACD4D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAY137-F3257E1CF5E4EC1DD00C84ACD4D0@phx.gbl>
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
To: Ilyas Yildirim <ilyildirim@hotmail.com>
Cc: autofs@linux.kernel.org


On Sat, 2008-01-05 at 03:15 -0500, Ilyas Yildirim wrote:
> Dear autofs users,
> 
> I am having a very annoying problem with autofs. I am using RedHat 
> Enterprise W4 Linux. My machine is a Dell Precision 490n Intel xeon two 
> dual-core system.
> 
> The versions of autofs I am using are as follows (I have the same problem in 
> both versions)
> 
> [root@malatya01 init.d]# rpm -q autofs
> autofs-4.1.3-231

Yes, you're using this.

> [root@malatya01 init.d]# rpm -q autofs5
> autofs5-5.0.1-0.rc2.55.el4_6.2

Your not using this.

Don't use both of these, use one or the other.

> 
> The kernel I am using is
> 
> [root@malatya01 init.d]# uname -r
> 2.6.9-67.0.1.ELsmp
> 
> So, here is the problem: Here are what I have in auto.master and auto.misc 
> files:
> =============== auto.master ===========================
> #
> # $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
> #
> # Sample auto.master file
> # This is an automounter map and it has the following format
> # key [ -mount-options-separated-by-comma ] location
> # For details of the format look at autofs(5).
> #/misc  /etc/auto.misc --timeout=60
> /misc   /etc/auto.misc
> 
> =======================================================
> =============== auto.misc =======================
> *           -fstype=nfs,soft,intr           
> malatya02.chem.rochester.edu:/malatya02b
> ==============================================
> Restarting autofs with 'autofs restart' does not give any error message.
> 
> [root@malatya01 init.d]# autofs restart
> Stopping automount:                                        [  OK  ]
> Starting automount:                                        [  OK  ]
> 
> It looks like that autofs has mounted the nfs filesystem. When I do 'ls -l 
> /misc/linux' I dont see anything.

What do you mean "has mounted the nfs filesystem"?
Nothing except /misc, an autofs filesystem has been mounted at this
stage.

> 
> [root@malatya01 init.d]# ls -l /misc
> total 0

That's right, indirect autofs mounts aren't browseable by default.

> 
> But, when I enter something like 'ls -l /misc/deneme', I see the filesystems 
> in /misc/deneme. Do I make something wrong here? I want the data to be seen 
> in /misc and I cannot make it using autofs. Thanks a lot in advance.

No, nothing is wrong here.
To acheive what you want in version 4 you need change you're master map
entry to:
/misc   /etc/auto.misc --ghost

If you're using version 5 the syntax is the same as other Sun compatible
automounters:
/misc   /etc/auto.misc -browse
and
/misc   /etc/auto.misc browse
should also work.

The browse option may be made the default by changing
BROWSE_MODE="no"
to
BROWSE_MODE="yes"
or just commenting out this configuration entry, as it is the internal
default, disabled in the installed configuration for backward
compatibility with version 4, in /etc/sysconfig/autofs.

Ian
