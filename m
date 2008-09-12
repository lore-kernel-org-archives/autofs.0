From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Execute script on expire.
Date: Fri, 12 Sep 2008 16:52:46 -0400
Message-ID: <x49d4j99jdt.fsf@segfault.boston.devel.redhat.com>
References: <e788514b0809121300t3eba11a2j5833cc071db29b54@mail.gmail.com>
	<x49hc8l9kk8.fsf@segfault.boston.devel.redhat.com>
	<e788514b0809121341p4128b352n9dc592ef91a0b722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <e788514b0809121341p4128b352n9dc592ef91a0b722@mail.gmail.com>
	(Alexander's message of "Fri, 12 Sep 2008 13:41:17 -0700")
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
To: Alexander <normalex@gmail.com>
Cc: autofs@linux.kernel.org

Alexander <normalex@gmail.com> writes:

> 2008/9/12 Jeff Moyer <jmoyer@redhat.com>:
>> Alexander <normalex@gmail.com> writes:
>>
>>> Hello mailing list,
>>>
>>> was looking everywhere and could find info on whether or not autofs 4
>>> or 5 has a feature of executing designated script on expire, just
>>> before unmounting.
>>
>> The short answer is no.

> Is it somewhere in the development plans or will never be implemented by design?

I believe there was one other requestor of this feature.  The tricky
part is defining the map syntax and not breaking compatibility.  There
is also the question of semantics with offset mounts.

If someone is motivated enough to come up with a proposal for the syntax
and semantics, I'm sure Ian and I can find some time to review it.

Cheers,

Jeff
