From: Robert Giles <rgiles@arlut.utexas.edu>
Subject: Re: Infinite loop when trying to access nonexistent
	directory (auto.home '&' substitution)
Date: Sat, 16 Oct 2004 18:31:06 -0500 (CDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.61.0410161825450.10308@orion.arlut.utexas.edu>
References: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
 <Pine.LNX.4.58.0410161143240.8831@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410161143240.8831@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Sat, 16 Oct 2004 raven@themaw.net wrote:
> And at least 2 hunks in the patch failed, right?
> One against fs/namei.c.

Right, and the other failed portion was against a configuration text file 
(Documentation/something).

I haven't explicitly tested 2.4.25 for the same problem, but over the 
course of several months I never had a 2.4.25 machine fill up 
/var/log/syslog with these automount errors (with 2.4.27, the disk fills 
up so rapidly that folks regularly ask me why their machine doesn't have 
any space on /...   basically have to "/etc/init.d/syslog stop" on these 
hosts until I can correct the problem).

Thanks again in advance for any ideas.

Robert Giles
ARL:UT
