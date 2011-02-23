From: Vincent Liggio <vince@blueskystudios.com>
Subject: Re: Before I start carving wheels....
Date: Wed, 23 Feb 2011 10:03:12 -0500
Message-ID: <4D6521B0.2050608@blueskystudios.com>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On 02/23/2011 09:19 AM, Jeff Moyer wrote:
> Vincent Liggio<vince@blueskystudios.com>  writes:
>
>> I'm guessing it won't work even if you get it to compile. We've been
>> trying to get it to work with the F14 latest kernel, and it just won't
>> function (we were able to get it to work on F12, but autofs3 refuses
>> to work on the F14 kernel).
>
> The autofs maintainer (Ian Kent) tries to keep the v4 kernel module
> compatible with v3.  However, if you don't report problems, they won't
> get fixed (most testing these days is with autofs version 5).

I reported on both kernel.org and on am-utils.org that autofs and amd do 
not work with F12's kernel in March/April of 2010 (kernel.org bug 15878 
and am-utils bug 639). No one has acknowledged or worked on the bug, as 
far as I can tell on the respective bugzillas.

We have discovered in the last couple of days that the amd compillation 
is bad on F14, as is the kernel support for autofs. Copying the amd from 
F12 (and the libgdbm library) and installing our custom compiled kernel 
from F12 (with autofs enabled) works. amd from 12 with the kernel from 
14 (2.6.35.10-74) does not work, nor does amd from 14 with the kernel 
from 12 (2.6.32.26-175). amd fails if autofs3 is not on, it does not 
recognize autofs4 as being usable.

NB: this is ONLY with amd in autofs mode. amd in nfs mode works, albeit 
sluggishly. We cannot use nfs mode because some of our tools don't like 
the whole /tmp_mnt structure.

>> It performs horribly with nfs mode. Think it's time to move onto
>> supported technology unfortunately (autofs5 is no great shakes, we're
>> going to try autofs4).
>
> autofs4 isn't exactly supported technology either.  You'd be moving from
> one dead-end to another.  I've CC'd the autofs list.  If you have
> suggestions and/or specific bugs, please let us know.

A very large installations (40,000+ servers) of linux that I know of 
refuses to use autofs5 because of issues with the mutli-threading. I 
know no more than that, but I trust their opinion and experience, and 
have heard rumblings of other groups having issues with autofs5.

Vince
