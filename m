From: Chris Walker <cwalker@pixar.com>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Wed, 7 Apr 2004 22:51:11 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040408055111.GA19457@pixar.com>
References: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

We have this problem as well. The problem occurs during unmount, so we
reduced the number of unmounts by adding a high --timeout (86400) to
automount. This worked in our case because we have a (relatively) small
number of filesystems that are accessed frequently.

This may not be an option in your case as you are accessing many
filesystems.

From rprach:
> Dear Folks,
> 
> I am administrating a set of Linux servers that use automount and amd in 
> order to access a variety of NFS volumes. The servers are, for the most 
> part, running kernel 2.4.25 (but see below). We are using the kernel 
> automounter version 3 and the userspace automount binary v3.1.7. 
> 
> We have a script that accesses resources all over the network. To this 
> end, it mounts, via autofs, a large number of remote filesystems. Whenever 
> this script is run, the following alarming message appears in the system 
> log:
> 
> kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have 
> a nice day...
> 
> I searched the mailing list of this archive and found some threads from 
> September of last year which seem to detail the same problem, however, no 
> solution or workaround was proposed at that time.
> 
> Looking at kernel.org, I see that kernel 2.4.26-pre3 contains a patch that 
> is supposed to help fix this problem. This patch was duly applied, but the 
> message persists. 
> 
> Questions: What is causing this message? Is there anything I can do about 
> it? Is there anything I should be doing about it, or is it an alarming yet 
> irrelevant message? 
> 
> Any insight you could shed would be greatly appreciated.
> 
> Yours Truly,
> 
> Raymond Prach
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


-- 
Chris Walker
Render Pipeline Group
Pixar Animation Studios
510/752.3736
cwalker@pixar.com
