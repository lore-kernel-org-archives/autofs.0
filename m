From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Limit on return string from program map
Date: Fri, 17 Dec 2004 11:09:22 -0500
Message-ID: <16835.1202.105657.451392@segfault.boston.redhat.com>
References: <21502.1103178424@kao2.melbourne.sgi.com>
	<Pine.LNX.4.58.0412171422280.22350@wombat.indigo.net.au>
	<16834.63746.614567.523947@segfault.boston.redhat.com>
	<1103298008l.6599l.1l@mercury>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1103298008l.6599l.1l@mercury>
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
Content-Type: text/plain; charset="us-ascii"
To: Thomas Jahns <Thomas.Jahns@gmx.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Limit on return string from program map; Thomas Jahns <Thomas.Jahns@gmx.net> adds:

Thomas.Jahns> On 12/17/04 16:19:30, Jeff Moyer wrote:
>>>> the string that automount expects from a program map.  My virtual CD
>>>> server has lots of CD images mounted over loopback, each with its own
>>>> export entry, so the return string from auto.net is quite long.
>>
raven> The buffer size for map entries is 4096.

Thomas.Jahns> not sure it's related: wasn't there also a very small limit
Thomas.Jahns> on the number of loop-devices?

MODULE_PARM(max_loop, "i");
MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");

-Jeff
