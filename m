From: raven@themaw.net
Subject: Re: [patch] mount_ext2 forgets MOUNTED_LOCK in spawnl
Date: Tue, 20 Apr 2004 23:48:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404202347430.24740@donald.themaw.net>
References: <16517.14269.189595.323548@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16517.14269.189595.323548@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 20 Apr 2004, Jeff Moyer wrote:

> Hi Ian,
> 
> Seems you missed an option to spawnl for the ext2 fsck call.  Nils Philipp
> found (and fixed) this bug while trying to automount filesystems on loop
> devices.
> 

Oops, that's kind of broken.

Ian
