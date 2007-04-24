From: Michael <michael@kmaclub.com>
Subject: Re: Strange issue with autofs5/fc6
Date: Mon, 23 Apr 2007 20:21:33 -0700
Message-ID: <462D77BD.5020003@kmaclub.com>
References: <46264599.90105@kmaclub.com>	<x49zm4zni6f.fsf@segfault.boston.devel.redhat.com>	<462CEB64.2020103@kmaclub.com>
	<20070424000254.GA2501@sleipnir.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070424000254.GA2501@sleipnir.redhat.com>
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
To: autofs mailing list <autofs@linux.kernel.org>

Fabio Olive Leite wrote:
>   
>
> Is the same volume from the same server already mounted somewhere else
> in this box? If so, the kernel is sharing the superblock for these two
> mounts of the same volume, and both the mount flags and nfs parameters
> have been set by the first mount.
>
> For more information, check upstream commit
> 54ceac4515986030c2502960be620198dd8fe25b. 
>   

Yes, the volume is mounted multiple times on the machine.  However, they 
all report bogus values. 

How am I supposed to know what values are being used if I can't trust 
/proc/mounts for any mounts?

Michael
