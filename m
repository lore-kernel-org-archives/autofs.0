From: Ian Kent <raven@themaw.net>
Subject: Re: Infinite loop when trying to access nonexistent
	directory (auto.home '&' substitution)
Date: Tue, 19 Oct 2004 23:01:41 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410192258330.1062@donald.themaw.net>
References: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
 <Pine.LNX.4.58.0410161143240.8831@donald.themaw.net>
 <Pine.LNX.4.61.0410161825450.10308@orion.arlut.utexas.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410161825450.10308@orion.arlut.utexas.edu>
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
To: Robert Giles <rgiles@arlut.utexas.edu>
Cc: autofs@linux.kernel.org

On Sat, 16 Oct 2004, Robert Giles wrote:

> On Sat, 16 Oct 2004 raven@themaw.net wrote:
> > And at least 2 hunks in the patch failed, right?
> > One against fs/namei.c.
>
> Right, and the other failed portion was against a configuration text file
> (Documentation/something).
>
> I haven't explicitly tested 2.4.25 for the same problem, but over the
> course of several months I never had a 2.4.25 machine fill up
> /var/log/syslog with these automount errors (with 2.4.27, the disk fills
> up so rapidly that folks regularly ask me why their machine doesn't have
> any space on /...   basically have to "/etc/init.d/syslog stop" on these
> hosts until I can correct the problem).

I've tested this with 2.4.27 and don't see any problem.

So it's time for some more specific info.

Please add the --debug option to the end of the line in the master map.
I want ypu to check the version info that is printed.
Maybe you could rerun the test and send the log.

Does the SNARE C2 change the signal handling?

Ian
