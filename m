From: raven@themaw.net
Subject: Re: Program map and submount problem
Date: Sat, 24 Jan 2004 12:05:25 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0401241202080.1751@raven.themaw.net>
References: <200401232348.i0NNmJN4021507@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401232348.i0NNmJN4021507@miguelito.qualcomm.com>
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
To: mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

On Fri, 23 Jan 2004 mmarion@qualcomm.com wrote:

> On 23 Jan, To: raven@themaw.net wrote:
> 
> > The log messages make it appear that the automount daemon on
> > /usr/local/projects/some/automount/submount is trying to umount itself without
> > bothering to see if it's a busy path or not.  It seems to assume that since
> > there are no submounts (either autofs or NFS) below it, that it's not busy.
> 
> Recomipled autofs on test box with debugging enabled.  Syslog output of point
> where it umounts NFS children (under
> /usr/local/projects/some/automount/submount) and then the daemon on submount
> tries to umount, fails, and exits follows:

Thanks for the info. I'll look deeper into it over the weekend.

I'm being chuked of my computer for a while by the kids. Bummer.

> 
> I'm digging through automount.c code looking for case where this would happen,
> but my C skills are really weak.

It's not easy with fairly good C skils and a good knowledge of how the 
daemon works.

Thanks again.

Ian
