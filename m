From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 08 Jan 2004 13:01:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3FFDC51B.8070108@zytor.com>
References: <3FFB12AD.6010000@sun.com>	<Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>	<3FFC8E5B.40203@sun.com> <Pine.LNX.4.53.0401080911390.27090@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401080911390.27090@simba.math.ucla.edu>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jim Carter <jimc@math.ucla.edu>
Cc: Mike Waychison <Michael.Waychison@sun.com>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Jim Carter wrote:
> 
>>For justification to it's worth, some institutions have file servers
>>that export hundreds or even thousands of shares over NFS.   As /net is
>>really just a kind of executable indirect map that returns multimounts
>>for each hostname used as a key,  just doing 'cd /net/hostname' may
>>potentially mount hundreds of filesystems.  This is not cool!
> 
> Definitely not cool.  But some users (yours truly among them) do "alias ls
> 'ls -F'", which requires "ls" to stat (and thus mount) every exported
> filesystem.  More uncool, and I don't see any non-disgusting way around it.
> 

No, it doesn't... this has been covered several times already.  It
requires ls to *lstat* the point; it only does a stat() if the resulting
entry is S_IFLNK.  The same is true for GUI tools.  There is a fairly
easy way to distinguish lstat() from virtually all other filesystem
calls -- it doesn't invoke follow_link.  So the answer is simply to
create an inode which is S_IFDIR but has a follow_link method.  The
follow_link method triggers a mount.  This is called a "pseudo-symlink
directory" or sometimes "ghost directory".

	-hpa
