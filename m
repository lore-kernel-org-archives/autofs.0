From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs-4.1.1 patch] free of ap.path happens too early
 in cleanup
Date: Wed, 17 Mar 2004 22:19:45 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403172217060.18212@raven.themaw.net>
References: <16471.29962.851785.48804@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16471.29962.851785.48804@segfault.boston.redhat.com>
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

On Tue, 16 Mar 2004, Jeff Moyer wrote:

> Hello,
> 
> ap.path gets free-d before we are done with it.  Specifically, callers of
> umount_autofs often-times reference ap.path when next calling
> cleanup_exit.  This patch moves the free-ing of ap.path to cleanup_exit.
> Comments welcome.
> 

Hi Jeff,

I don't mind moving the free as you recommend (it looks OK) but, after a 
quick look, I can't see where ap.path is referred to out of context?

Ian
