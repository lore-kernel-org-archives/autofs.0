From: Ian Kent <raven@themaw.net>
Subject: Re: /net with program map problem on x86_64
Date: Mon, 2 Feb 2004 01:16:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0402020112490.266-100000@donald.themaw.net>
References: <200403060204.i2624NgQ000399@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403060204.i2624NgQ000399@miguelito.qualcomm.com>
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

On Fri, 5 Mar 2004 mmarion@qualcomm.com wrote:

> Here's a new one I've run into.  Finally got a full auto-yast install setup
> for Suse SLES8 on a dual opteron system that incorporates all our company
> configurations automatically as well.
>
> I'm running the beta 4.1.1 code (don't know if it's released to wide audience
> yet) and it's been running perfectly fine on x86 hosts for a month or more.

Would be except for the 64 bit compile problem as Micheals problem is
clearly in the kernel module.

Kernel module version?

>
> We have massive direct maps that were originally for an all sun environment
> that we use program maps to parse/mount with.  The direct maps are working
> fine, as are the homedir mounts (auto.home yp map)... but my /net program
> mapped mount is broken now.  The program file still returns exactly what I'd
> expect, but for some reason, the automount daemon can't create the necessary
> directories in the /net tree?!?  Not sure what would cause this or where it
> would be tripped.
>
> syslog shows:
> Mar  5 17:48:21 rs-blade automount[4277]: mount(nfs): mkdir_path  failed:
> Operation not permitted
>
> and a strace of the daemon shows:
> [pid  4932] mkdir("/net", 0555)         = -1 EEXIST (File exists)
> [pid  4932] stat("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> [pid  4932] mkdir("/net/mig", 0555)     = 0
> [pid  4932] mkdir("/net/mig/local", 0555) = -1 EPERM (Operation not permitted)
>
> it then does it again later:
> [pid  4998] mkdir("/net", 0555)         = -1 EEXIST (File exists)
> [pid  4998] stat("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> [pid  4998] mkdir("/net/mig", 0555)     = 0
> [pid  4998] mkdir("/net/mig/local", 0555) = -1 EPERM (Operation not permitted)

This looks very similar to the problem Micheal reported.

Can you provide a example of the map so I can duplicate it.

Ian
