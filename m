From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Before I start carving wheels....
Date: Wed, 23 Feb 2011 09:19:47 -0500
Message-ID: <x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	(Vincent Liggio's message of "Tue, 22 Feb 2011 22:05:49 -0500 (EST)")
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
To: Vincent Liggio <vince@blueskystudios.com>
Cc: autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

Vincent Liggio <vince@blueskystudios.com> writes:

> On Tue, 22 Feb 2011, Lee Damon wrote:
>
>> Has anyone done the work to get am-utils to compile on RHEL 6?  It seems the most recent autoconf tools don't like the contents of the 6.1.5 tarball.
>>

> I'm guessing it won't work even if you get it to compile. We've been
> trying to get it to work with the F14 latest kernel, and it just won't
> function (we were able to get it to work on F12, but autofs3 refuses
> to work on the F14 kernel).

The autofs maintainer (Ian Kent) tries to keep the v4 kernel module
compatible with v3.  However, if you don't report problems, they won't
get fixed (most testing these days is with autofs version 5).

> It performs horribly with nfs mode. Think it's time to move onto
> supported technology unfortunately (autofs5 is no great shakes, we're
> going to try autofs4).

autofs4 isn't exactly supported technology either.  You'd be moving from
one dead-end to another.  I've CC'd the autofs list.  If you have
suggestions and/or specific bugs, please let us know.

Cheers,
Jeff
