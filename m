From: Rich Sahlender <rsahlen@voicenet.com>
Subject: multiple servers per automount
Date: Wed, 8 Oct 2003 13:24:51 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031008172451.GA1775@born2.midworld.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

This is probably a faq but I havn't seen it asked in recent months...

I have a situation where two network appliance filers with identical
file systems are used to serve read only mounts for CAD software tools.
Both Solaris and HP-UX support an automount like:

cadtool	-ro	tools1,tools2:/vol/vol1/tools/&

and will automatically switch to the other server if the initial mount
becomes unavailable.

Last time I was able to check Linux autofs did not support the failover
and complained about the syntax. Has this changed or are there plans to
support the syntax above with failover for read only mounts?

Thanks,
Rich Sahlender
