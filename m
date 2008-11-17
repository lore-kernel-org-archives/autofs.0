From: Steven Hirsch <snhirsch@gmail.com>
Subject: Re: Suspected problem w/ autofs and xauth
Date: Mon, 17 Nov 2008 18:10:35 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0811171807550.7727@duo>
References: <alpine.DEB.2.00.0811161227080.8008@duo> <x49prkuqs26.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <x49prkuqs26.fsf@segfault.boston.devel.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, raven@thewmaw.net

On Mon, 17 Nov 2008, Jeff Moyer wrote:

> Steven Hirsch <snhirsch@gmail.com> writes:
>
>> I've been battling with an extremely annoying issue that I believe is
>> related to autofs.  My home directory is mounted over NFS using autofs
>> 4.1.4 (as supplied with Kubuntu Hardy).  I've used this setup for
>> years over perhaps a dozen different distributions without any
>> particular problems.
>>
>> Since moving to the Hardy distro, the problem is this:  If I leave the
>> system idle at the KDE desktop for more than a few minutes, any and
>> all attempts at opening new windows fail with an error that they
>> cannot obtain X authorization.  If I simply do an 'ls' in my home
>> directory and try again, it works fine.  I believe this is being
>> caused by the automounter timing out, but I do not find any log
>> messages from the automounter under any circumstances, so it's
>> difficult to prove.  If I do an strace on the X application, it
>> appears to be unable to read ~/.Xauthority (which is there and can be
>> read after triggering a remount).
>>
>> Is it possible that autofs behavior changed in a manner such that a
>> stat of ~/.Xauthority is no longer sufficient to trigger the mounter?
>>
>> Any suggestions (or even WAGs) appreciated.  I'd love to swat this
>> annoyance.
>
> In theory, the directory shouldn't be unmounted.  Try typing just
> 'mount' to see what's mounted when the problem occurs.  What's the
> kernel version?

I have accidently discovered a workaround, which may provide a hint as to 
the failure mode:  For performance, I had been mounting my home directory 
with 'noatime' specified as an option.  On a whim, I deleted that and let 
it take the default (seems to be relatime).  Lo and behold, the problem is 
gone!

I will revert this as soon as I get an opportunity and see what is mounted 
(or not, as the case may be) when the symptoms appear.

Steve


-- 
