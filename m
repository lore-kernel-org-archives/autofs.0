From: Ian Kent <raven@themaw.net>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 04 Jan 2008 11:01:10 +0900
Message-ID: <1199412070.3288.24.camel@raven.themaw.net>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
	<1198241367.3488.26.camel@raven.themaw.net>
	<x49odck175r.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
	<x49fxxvzpp5.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438CB@sbs01.xiss.private>
	<1198304664.3114.49.camel@raven.themaw.net>
	<1198307519.3114.59.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D72443928@sbs01.xiss.private>
	<1198739265.3169.81.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D72443981@sbs01.xiss.private>
	<1198822909.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724BEEFA@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724BEF72@sbs01.xiss.private>
	<1199285141.3072.50.camel@raven.themaw.net>
	<alpine.LFD.0.9999.0801021742120.1247@h onker.vg ersoft.com>
	<1199324040.3175.4.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724BF032@sbs01.xiss.private>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <98E55D6E1B3CFD43BDA59EEB56DD7D724BF032@sbs01.xiss.private>
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
To: James Richardson <jrichardson@x-iss.com>
Cc: autofs@linux.kernel.org

On Thu, 2008-01-03 at 19:33 -0600, James Richardson wrote:
> Is there any way to disable all of that selection code?

No.

> 
> We are currently using Bind server side sort lists to optimize the sort
> order of the addresses returned by our DNS servers so that networks
> directly accessible to the nfs client are returned first in the RRset.

The real question is whether it is useful to use the addresses returned
in this way or to always use only the first address.

> 
> I am not looking at my test matrix at the moment, but I'm 99% sure that
> this wasn't an issue in CentOS4.2 with a 2.6.9 kernel and autofs4; but
> using autofs5 with a 2.6.21 kernel there is a noticeable "slowdown". It
> appears as "something" has changed.

No it wasn't.
There are significant changes to this code between version 4 and version
5 as the version 4 code was a constant problem and didn't work
correctly.

Ian
