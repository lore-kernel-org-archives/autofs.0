From: raven@themaw.net
Subject: Re: mount fails because entry in multi-mount doesn't work
Date: Thu, 13 May 2004 23:08:11 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405132305230.13693@donald.themaw.net>
References: <40A38585.4050103@freescale.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40A38585.4050103@freescale.com>
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
To: Tom Georgoulias <tom.georgoulias@freescale.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 13 May 2004, Tom Georgoulias wrote:

> Yesterday I ran into an issue where a mount point wasn't working and 
> tracked it down to one of the submounts.  From what I can tell, if one 
> of the submounts in a multi-mount doesn't work, the entire mount point 
> won't work.  If that is the case, can this behavior be changed?

Use the -nonstrict option on the autofs mount.

OK this has happened one to many times. I think I'm going to change this 
default.

What do people think about this idea?

Ian
