From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: mtab corruption
Date: Wed, 03 Jan 2007 17:03:21 +0100
Message-ID: <459BD3C9.9090201@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

I frequently end up with a broken mtab. This results in a message like:
mount(nfs): warning: /home/stueken is already mounted

I'm using a SuSE-10.1 x86_64-smp system with a 2.6.16.21-0.25-smp kernel.
After I read about new patches to solve some mtab locking problems
I upgraded from autofs-4.1.4-23 to autofs-4.1.4-37, but the mtab
corruption still occurs.

Seems the problem became even worse since a mount request sometimes
takes about 5 seconds (due to some LDAP configuration problems) while
a bunch of other mount requests are coming in.
In addition this is an SMP system.

Should I consider to update my kernel, too?

Unfortunately I could not convince my sysads to do so, as they are
afraid of even more problems with newer kernels...

I noticed the upcoming autofs5. Should I wait for it?

thanks for advice,

- Dieter. 
