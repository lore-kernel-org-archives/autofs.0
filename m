From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: fstab
Date: Tue, 5 May 2009 10:54:38 -0300
Message-ID: <c2d0b6ec0905050654h4749c2e2x99ca7e6cc0d776c3@mail.gmail.com>
References: <20090503181437.91f3a3c2.Sheldon@peters.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090503181437.91f3a3c2.Sheldon@peters.home>
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
To: Peter <Sheldon@hera.kernel.org>
Cc: autofs@linux.kernel.org

> I can't find any reference to a network share (nfs) can or can
>  not be present in fstab. My problem is SLOCATE doesn't
> like Autofs and ignores my nfs share when I run updatedb.

I found that when using AutoFS 5, setting DEFAULT_BROWSE_MODE
to "yes" (it's the default, but perhaps your distribution tweaks it by
default) in /etc/sysconfig/autofs can influence updatedb behavior.

Also, if you want updatedb to search down the AutoFS paths, make
sure it is configured to allow NFS, CIFS and whatever other file
systems you are mounting with AutoFS.

Regards,
Leonardo
