From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: AutoFS creates unmountable directories when ghosting
	is enabled
Date: Wed, 9 Mar 2011 11:09:54 -0300
Message-ID: <AANLkTi=HDA5KzgakkmE__Tn4AM-O=Smj3nPgkc4cB0jg@mail.gmail.com>
References: <20101210191042.GA4396@libre.l.ngdn.org>
	<1292381344.2979.6.camel@perseus>
	<AANLkTikY+xO2voYOQqFR6qUyKusLBbknNLGLda6nHVbY@mail.gmail.com>
	<1299644155.3037.15.camel@perseus>
	<1299644461.3037.16.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=0hYDnz62kaxsvpOgnGR0s8sXQxAOA58Qa5fbRj2q4pU=;
	b=ISZoU+nicTKZdtatR+xSwoY6Cf79sCnzNRG2uKAIl3LFHvjF1EbBPUB3pggpPAo2dO
	zg1eMb9iAvRtKgMt8bElFOGSuLjd4wSXKDVEXG+fRQYnYWzKwGhWntSLivz2As5Dvw3W
	RH995nhlwR6hfExAkQWIEh0bd9DPxWBW/Shi4=
In-Reply-To: <1299644461.3037.16.camel@perseus>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wed, Mar 9, 2011 at 1:21 AM, Ian Kent <raven@themaw.net> wrote:
> On Wed, 2011-03-09 at 12:15 +0800, Ian Kent wrote:
>> >
>> > Hello Ian,
>> >
>> > I bisected this problem today and discovered that it appeared after the
>> > following commit:
>> >
>> > commit 08aafab4c1d0ab6227c80f8cd1086ae78556a370
>> > Author: Ian Kent <raven@themaw.net>
>> > Date: =A0 Thu Sep 9 11:10:47 2010 +0800
>> >
>> > =A0 =A0 autofs-5.0.5 - fix direct map not updating on reread
>> >
>> > =A0 =A0 If the map type is explicitly specified for a map the map isn't
>> > =A0 =A0 properly updated when a re-read is requested. This is because
>> > =A0 =A0 the map stale flag is incorrectly cleared after after the look=
up
>> > =A0 =A0 module reads the map instead of at the completion of the update
>> > =A0 =A0 procedure. The map stale flag should only be cleared if the map
>> > =A0 =A0 read fails for some reason, otherwise it is updated when the
>> > =A0 =A0 refresh is completed.
>> >
>> > Does this ring a bell? If not, I'll see if I can debug it further tomo=
rrow.
>>
>> Not really.
>> I'm still not sure your original patch deals with the problem fully.
>>
>> Could you also have a look at and try (from kernel.org):
>> autofs-5.0.5-fix-prune-cache-valid-check.patch
>
> Although, looking again, maybe we need both patches.

Yes, I tested again with all kernel.org patches and the problem remains.

Leonardo
