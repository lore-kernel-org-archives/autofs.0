From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Thu, 8 Apr 2004 19:50:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404081922100.3363@raven.themaw.net>
References: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Wed, 7 Apr 2004, Raymond Prach wrote:

> Dear Folks,
> 
> I am administrating a set of Linux servers that use automount and amd in 
> order to access a variety of NFS volumes. The servers are, for the most 
> part, running kernel 2.4.25 (but see below). We are using the kernel 
> automounter version 3 and the userspace automount binary v3.1.7. 

My main interest is with version 4 and autofs4 but I believe the 
issues are the same. It comes up in both versions.

> 
> We have a script that accesses resources all over the network. To this 
> end, it mounts, via autofs, a large number of remote filesystems. Whenever 
> this script is run, the following alarming message appears in the system 
> log:
> 
> kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have 
> a nice day...

It would be good if I could duplicate this reliably. Perhaps then I could 
work out what is happening. Can you help with a description of the 
scenario or a simple script?

I can't really do much unless you are willing to duplicate this 
against, at least autofs-4.1.1 (4.1.2 is latest), together with the kernel 
patches for autofs4. I haven't tested 2.4.25 but the 2.4.22 patch applies 
OK against 2.4.24.

> 
> I searched the mailing list of this archive and found some threads from 
> September of last year which seem to detail the same problem, however, no 
> solution or workaround was proposed at that time.
> 
> Looking at kernel.org, I see that kernel 2.4.26-pre3 contains a patch that 
> is supposed to help fix this problem. This patch was duly applied, but the 
> message persists. 

What patch was this? I must have missed it.

> 
> Questions: What is causing this message? Is there anything I can do about 
> it? Is there anything I should be doing about it, or is it an alarming yet 
> irrelevant message? 

That's the big question.

There is more than one way in which it may be caused.

One common cause is automount exiting without cleaning up directories in 
the autofs filesystem.

Just this last day or so I have been thinking that another cause could be 
the communications file descriptor not being closed before exit.

It's possible that this could be a the result of a bug in another 
filesystem, such as NFS. I saw a thread on the NFS list that discussed 
this and there was a patch posted. I haven't as yet done any testing. 

One idea that I had was to add a umount_begin method to the autofs4 module 
so that I could try and cleanup any remaining references even if the 
daemon was already gone but unless I can reliably duplicate the problem 
it's academic.

Is the message bad?

Well I'm not sure. On the face of it no, but I find that if I am trying to 
fix something which results in messages of this type I get the impression 
that my system becomes less stable and ultimately I need to reboot. Of 
course it may not actually be the result of that message as I've usually 
got other more sinister things happening as well.

Finally, one of my production systems that has ghosting (browsable 
automount tree) turned of and I occassionally get them on that system and 
it seems to keep working OK for weeks. So I can't be sure on that either.

Not much help here aye! Sorry.

Ian
