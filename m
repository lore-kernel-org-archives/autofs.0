From: Brian Long <brilong@cisco.com>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 22 Nov 2005 11:21:17 -0500
Message-ID: <1132676478.4039.57.camel@brilong-lnx>
References: <1132670358.4039.37.camel@brilong-lnx>
	<17283.15738.978933.591442@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17283.15738.978933.591442@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

On Tue, 2005-11-22 at 10:47 -0500, Jeff Moyer wrote:

> This is likely a side-effect of the cache expiry code.  Try this patch on
> for size.

I took the SRPM from autofs-4.1.3-154 (RHEL 3 U6) and applied your
patch.  I installed this RPM on a test host, rebooted the host and
ls /users/nosuchuser came back immediately.

Is this patch something that would be accepted upstream Ian?  Jeff, any
chance this patch can be put into RHEL 3 U7 and RHEL 4 U3?  I know it's
last-minute, but I really need this fixed (and supported by Red Hat).

If there is any way you can poke at my IT 82760, I would greatly
appreciate it.

/Brian/
-- 
       Brian Long                      |         |           |
       IT Data Center Systems          |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s
