From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Sat, 10 Jan 2004 13:09:38 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401101307300.2403-100000@wombat.indigo.net.au>
References: <Pine.LNX.4.53.0401091302330.9335@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401091302330.9335@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, 9 Jan 2004, Jim Carter wrote:

>
> Just yesterday I had five Linux boxes hang while rebooting, while
> trying to shut down autofs4, because processes using the filesystems had
> been killed but wouldn't die.  This human said, I've already decided that
> these machines are idle, and so I just killed the shutdown script, rather
> than researching more drastic action to get rid of the processes, or to
> find out why they weren't exiting, or to do "umount -l", etc.

Please try 4.1 and the kernel module patch (you are using 2.4?). If it
doesn't improve your situation you are no worse of and I will get more
bug info. On the other hand ....
