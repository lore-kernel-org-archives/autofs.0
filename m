From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 9 Jan 2004 13:11:21 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401091302330.9335@simba.math.ucla.edu>
References: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
	<3FFF0C48.6020908@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FFF0C48.6020908@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

On Fri, 9 Jan 2004, H. Peter Anvin wrote:
> Jim Carter wrote:
> > I would really like it if, when autofs decided to forcibly unmount, it
> > could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
> > Actually this is a general issue for unmount(8), not specific to autofs.
> > But one wonders whether fuser is going to run wild...
>
> How on the face of planet Earth do you expect autofs should ever take
> such a drastic action?  This could only by a human deciding to do so,
> and if so, it's not an issue for autofs, as long as human umounts are
> properly handled (they should be.)

Just yesterday I had five Linux boxes hang while rebooting, while
trying to shut down autofs4, because processes using the filesystems had
been killed but wouldn't die.  This human said, I've already decided that
these machines are idle, and so I just killed the shutdown script, rather
than researching more drastic action to get rid of the processes, or to
find out why they weren't exiting, or to do "umount -l", etc.

It's lucky that autofs is shut off before sshd, or else I would have had to
visit every machine.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
