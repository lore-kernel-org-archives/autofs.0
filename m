From: Ian Kent <raven@themaw.net>
Subject: RE: multiple servers per automount
Date: Fri, 10 Oct 2003 09:15:01 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310100910300.7746-100000@wombat.indigo.net.au>
References: <6AB920CC10586340BE1674976E0A991D0C6B77@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6B77@slexch2.sugarland.unocal.com>
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
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, 9 Oct 2003, Ogden, Aaron A. wrote:

>
> Yes, we are using the RH kernels as a base, the limit is supposed to be
> 1200+ but my experiments have shown it to be just shy of 800.  Or maybe
> that results is due to a bug in the autofs code.  I think the real
> solution to this problem is Richard Gooch's devfs and kernel 2.6.  It's
> anyone's guess when there will be a distribution using both of those but
> I think Fedora might be the first.
>

Looks like the limit is here to stay as 2.6 looks similar to 2.4 in that
area and udev is destined to be used as a replacement for devfs (which
never caught on). udev does not address this issue either.

Any know if/how this issue will be addressed?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
