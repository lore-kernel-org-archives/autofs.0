From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: Re: [PATCH 0/2] Series for the non-expiring mounts problem
Date: Thu, 28 Apr 2011 19:52:03 -0700
Message-ID: <4DBA27D3.5030503@gmail.com>
References: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
	<AANLkTimKbS8A6OW-B-BGiAccAh_71YO8CF92zP0K9TE2@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
	:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=4iLWkaQkstjBTV1oIifoT8rpXPE0z5Y0BMhe3YnB83Q=;
	b=XkATAzP7dP0hhYfkhiLqS9V4Ey9oXPt/ocNv6lcbGX5Rpq7QxOixT4t9PY/M7StSh2
	izoVl934Q9xlqQ+1rGHTuAUCgF2fz5ktNr69QbvwyoH9n+IsX1bOEBGamUZYgMf7/Pbu
	oL/Zhq5CTusBv+F6NHdwbM/VKIH3UdZanBZOc=
In-Reply-To: <AANLkTimKbS8A6OW-B-BGiAccAh_71YO8CF92zP0K9TE2@mail.gmail.com>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Have the patches been released yet?

On 3/30/2011 9:13 AM, Leonardo Chiquitto wrote:
> On Wed, Mar 30, 2011 at 2:49 AM, Ian Kent<raven@themaw.net>  wrote:
>> These two patches should fix the problem you reported where a USR1
>> signal fails to trigger an expire. They should also fix the unnecessary
>> map reload problem.
>>
>> Please test these for me.
> Ian, thanks for the patches. I just tested them here and confirm that the
> problem is resolved. I tested direct and indirect mounts letting them expire
> after the default timeout and forcing the expiration with SIGUSR1.
>
> I also confirmed that the "unmountable directories" problem reported in
> http://linux.kernel.org/pipermail/autofs/2011-March/006509.html is fixed
> as well (the patch I suggested back then is *not* needed).
>
> Thanks,
> Leonardo
>
>> ---
>>
>> Ian Kent (2):
>>       autofs-5.0.5 - fix stale map read
>>       autofs-5.0.5 - fix next task list update
>>
>>
>>   CHANGELOG        |    2 ++
>>   daemon/lookup.c  |    1 +
>>   daemon/state.c   |    9 +++++----
>>   include/master.h |    1 +
>>   lib/master.c     |   37 +++++++++++++++++++++++++------------
>>   5 files changed, 34 insertions(+), 16 deletions(-)
>>
>> --
>> Ian
