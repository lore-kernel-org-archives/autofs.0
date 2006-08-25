From: Ian Kent <raven@themaw.net>
Subject: Re: autofs: Automounts fail to automount after a few days
 of	uptime
Date: Fri, 25 Aug 2006 20:00:10 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608251958370.30744@raven.themaw.net>
References: <44ED7F61.1040402@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44ED7F61.1040402@control.lth.se>
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
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: autofs@linux.kernel.org, Christian Weeks <christian.weeks@oracle.com>, 379780@bugs.debian.org

On Thu, 24 Aug 2006, Anders Blomdell wrote:

> I see similar behaviour on a FC4 system running 2.6.13-1.1526_FC4smp, in this 
> case the problem seems to be (gleaned from strace of /usr/sbin/automount) when 
> stating "/home/dir/subd":

Yes. We've seen this quite a lot over time.
I'd be interested to see if this problem goes away wit a fully updated 
kernel.

Ian
