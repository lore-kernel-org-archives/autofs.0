From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Negative caching of failed mount attempts
Date: Fri, 17 Apr 2009 11:42:48 -0300
Message-ID: <c2d0b6ec0904170742n5a1b8af9h9ee9bf6cfccae71d@mail.gmail.com>
References: <c2d0b6ec0904161339j3573f25em3b6a1ac1168fa032@mail.gmail.com>
	<49E7E544.8070609@themaw.net>
	<x49bpqvmlio.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49bpqvmlio.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

>> I have a bunch of patches for v4 from Jeff Moyer that I've not got
>> around to looking closely at and applying. We didn't get as far as the
>> negative lookup caching patch though. In fact I don't think it had been
>> written then.
>
> Tough call on what to do here. =A0I don't like that we have all of these
> patches in RHEL only. =A0At the same time, new distribution versions
> should be using autofs5. =A0So, I'm having a hard time justifying the work
> of merging all of the work we've done in the RHEL package.

I was impressed by the amount of patches too. You are doing a
great job maintaining it.

> Are people still looking for new features in autofs 4? =A0If so, why?

In this specific case it's not really a new feature, because -- even if
with bugs -- it was there before.
