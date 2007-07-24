From: Ian Kent <raven@themaw.net>
Subject: Re: trivial
Date: Tue, 24 Jul 2007 22:32:58 +0800
Message-ID: <1185287578.4055.26.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0707240838580.30949@rray.drdc.mstc.ms.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0707240838580.30949@rray.drdc.mstc.ms.gov>
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
To: Richard Ray <rray@mstc.state.ms.us>
Cc: autofs@linux.kernel.org

On Tue, 2007-07-24 at 08:59 -0500, Richard Ray wrote:
> Since upgrading from Fedora Core 5 to Fedora Core 6 any time I access a 
> ncp filesystem I get these messages in /var/log/messages
> 
> Jul 24 08:38:18 drdc-apps1 automount[2054]: open_mount: (mount):cannot 
> open mount module ncp (/usr/lib/autofs/mount_ncp.so: cannot open shared object 
> file: No such file or directory)
> 
> The mount succeeds and I have no problem accessing the filesystem
> Using package autofs-5.0.1-0.rc3.32 and ncpfs-2.2.6-5
> I searched the web for mount_ncp.so and got
> "Your search - mount_ncp.so - did not match any documents."
> I think that's the first time Google was left speechless

Yes, I need to decide what to do about that.

The message is harmless, it's just saying it couldn't find a custom
mount module and then attempts to use the generic mount module, which,
as you say work OK.

Perhaps I will just make it a debug status message.

Ian
