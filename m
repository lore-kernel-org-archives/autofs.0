From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Negative caching of failed mount attempts
Date: Fri, 17 Apr 2009 09:56:31 -0400
Message-ID: <x49bpqvmlio.fsf@segfault.boston.devel.redhat.com>
References: <c2d0b6ec0904161339j3573f25em3b6a1ac1168fa032@mail.gmail.com>
	<49E7E544.8070609@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49E7E544.8070609@themaw.net> (Ian Kent's message of "Fri, 17 Apr
	2009 10:11:16 +0800")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> Leonardo Chiquitto wrote:
>> Hello,
>> 
>> Three years ago, commit 2d753e62b8 removed kernel-side caching
>> of mount attempts that returns -ENOENT. Apparently it wasn't
>> working as it should.
>
> It stopped working when 2.6 was released due to changes in the VFS.
> These changes made it extremely hard to do in the kernel module. Efforts
> to do it in the kernel module have been abandoned at this stage.
>
>> I see that this feature is now implemented in the user land AutoFS 5
>> daemon, but it wasn't back ported to AutoFS 4. I understand that
>> version 4 is not maintained anymore, but I'd like to ask if someone
>> has a patch around that implements this feature.
>
> I guess that's what it amounts to, since all the effort is going into v5.
>
> I have a bunch of patches for v4 from Jeff Moyer that I've not got
> around to looking closely at and applying. We didn't get as far as the
> negative lookup caching patch though. In fact I don't think it had been
> written then.

Tough call on what to do here.  I don't like that we have all of these
patches in RHEL only.  At the same time, new distribution versions
should be using autofs5.  So, I'm having a hard time justifying the work
of merging all of the work we've done in the RHEL package.

Are people still looking for new features in autofs 4?  If so, why?

Cheers,
Jeff
