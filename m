From: Greg Bradner <gregb@rhythm.com>
Subject: Re: shut down path
Date: Sat, 27 Mar 2004 11:55:47 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0403271153050.2637@lid2.rhythm.com>
References: <406435BF.4090801@rhythm.com>
	<Pine.LNX.4.58.0403270922350.28173@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403270922350.28173@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

One of the other admins found the kernel is killing processes, which ask
for memory, under heavy load.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com

On Sat, 27 Mar 2004, Ian Kent wrote:

> On Fri, 26 Mar 2004, Greg Bradner wrote:
>
> > Why or what would cause autofs to 'shut down' a path?
> > from /var/log/messages:
> > Mar 24 16:41:16 lid2 automount[992]: shut down, path = /ntap12
>
> Usually an uncaught signal.
>
> Need a bit more info about you situation.
>
> Ian
>
