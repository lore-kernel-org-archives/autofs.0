From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Wed, 23 Feb 2011 17:22:27 -0300
Message-ID: <AANLkTi=eVoOnxbGrqtWpnvjKjYqzLads=Je+RWVsvb+n@mail.gmail.com>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus>
	<1297741021.13007.12.camel@perseus>
	<20110215052857.GV27735@sunapee.qualcomm.com>
	<1297772933.13007.28.camel@perseus>
	<AANLkTi=fSs58yKLnWFLLDk-ep+wDbqNLpj0r9AZUjZ+Y@mail.gmail.com>
	<1297840085.2825.8.camel@perseus>
	<1297858695.2825.17.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=rY+C2CMyp20vv4eFX/T7hc86BUr3rlFeLTS9YI7ytNc=;
	b=Boti/ZPoVQ6CcLpgE/f2O4RJuOB+dB1jShpssIU0vSjjNYOoED511O5yY3qY+jt383
	00NWthY5dtkCDXx6wEoojNJWRZLTVeC2cQ/zhY9RgjHGTvLDH+ZFpXkI9V9WkXemP59p
	KIb4U0W8UeZNNL/QUBesC07fdrjwRC8bDGPrQ=
In-Reply-To: <1297858695.2825.17.camel@perseus>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>, Mike Marion <mmarion@qualcomm.com>

On Wed, Feb 16, 2011 at 10:18 AM, Ian Kent <raven@themaw.net> wrote:
> On Wed, 2011-02-16 at 15:08 +0800, Ian Kent wrote:
>> On Tue, 2011-02-15 at 16:11 -0200, Leonardo Chiquitto wrote:
>> > On Tue, Feb 15, 2011 at 10:28 AM, Ian Kent <raven@themaw.net> wrote:
>> > > On Mon, 2011-02-14 at 21:28 -0800, Mike Marion wrote:
>> > >> On Mon, Feb 14, 2011 at 07:37:01PM -0800, Ian Kent wrote:
>> > >>
>> > >> > That is kernel revision and autofs revision?
>> > >>
>> > >> 2.6.16.60-0.59.1 (Sles10 sp3 with an updated, but not bleeding edge=
, patch).
>> > >> autofs 5.0.5 with most of the patches up to a couple months ago. =
=A0It's hard to
>> > >> get exacts because it's a PTF from Novell (we really pushed them to=
 upgrade to
>> > >> 5.0.5) but it should be pretty much equal to the patch they just re=
leased for
>> > >> sle 11 sp1 that they're recommending as they default going forward.
>
> Now I'm confused?
>
> I thought that Mike had mention he had seen hangs, similar to Steve, and
> this backtrace was an example of that.

This is right. The backtrace I posted was sent to me as an example of a han=
g.

> But the mail thread doesn't read
> like that and oddly enough I seem to have identified a locking problem
> from looking at the code based on the backtrace.

I'm sorry that we ended up hijacking the "non-expiring mounts" thread.

Leonardo
