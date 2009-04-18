From: Ian Kent <raven@themaw.net>
Subject: Re: Very strange autofs failure on 2.6.30-rc2
 with	autofs-5.0.3-41 (fc10)
Date: Sat, 18 Apr 2009 10:58:06 +0800
Message-ID: <49E941BE.3080706@themaw.net>
References: <49E90A39.3040102@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49E90A39.3040102@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

H. Peter Anvin wrote:
> I have been using for a very long time a setup where /home is an autofs 
> from a plain indirect NIS map, but my personal home directory 
> (/home/hpa) is simply a bind mount from /export/home/hpa.  A 
> straightforward use of autofs.
> 
> I just rebooted my system yesterday, however, and found that all the 
> directory entries in my home directory had gotten replaced with ghost 
> directories -- and even more confusingly, the date wasn't the current 
> date, but was back in 2008.
> 
> The ghost directories were "sterile" in the sense that entering them 
> wouldn't show the proper contents of those directories.  As a result, 
> massive failure.
> 
> After suspecting filesystem corruption, and this, that and the other 
> thing, I found that this was only when viewing though autofs 
> (/home/hpa), and that the real filesystem (/export/home/hpa) was fully 
> intact.  Somehow autofs had ended up ghosting pretty much my entire 
> directory, and doing so in some incorrect fashion.
> 
> Replacing /home with a plain bind mount (no autofs) to /export/home 
> resolved the issue.

This failure sounds rather more spectacular than should result from a
known problem we have with a recent init scripts change. I'll investigate.

Have a look at https://bugzilla.redhat.com/show_bug.cgi?id=475002.

Ian
