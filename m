From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Patching Autofs on SLES9
	(autofs-4.1.3-included-maps.patch)
Date: Fri, 18 Jun 2010 13:20:00 -0300
Message-ID: <AANLkTimHtsxBHJIPgJh1SNbCIL8mpMyyuGgfOSacHfSp@mail.gmail.com>
References: <AcsMaytc7B8+ciJHQp6E6oe4Nl+Pjg==>
	<577798A82D8C2746B9461A64C5F4562802383A50@GEDACV2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:received:in-reply-to
	:references:date:message-id:subject:from:to:cc:content-type;
	bh=hrYDaWrKsoQyCUTU29AK86gpxNqhDDFHwrdGqxUdGow=;
	b=gU98wK0jCqcQQ8fBmjkkBxnC7UaTHcvPRNwCVRkasrqp7MNz7UoITtTrW+WTDxb4ob
	CYKTHqbHE8BUNGh2fTPa8TqhFmqeOeCWCUP0Gsi/Av1RR+QgdZJbX1NcNSoIFK3KTft0
	MPcFe8tqIFdVbhatmAuElROx7r+F8WkyjC1SU=
In-Reply-To: <577798A82D8C2746B9461A64C5F4562802383A50@GEDACV2>
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
To: Oliver Weinmann <oliver.weinmann@vega.de>
Cc: autofs@linux.kernel.org

On Tue, Jun 15, 2010 at 6:14 AM, Oliver Weinmann
<oliver.weinmann@vega.de> wrote:
> Dear All,
>
> We are widely using SLES9 in our environment. I noticed that the autofs that
> comes with sles9 is not capable of treating the +auto.map in the autofs
> files. We were asking novell support to fix this and after a really long
> time (5 months) they came back to us saying that this is not possible to
> implement without a service pack. It is very unlikely to be released for
> SLES9 since it is too old. I'm not so much into autofs, but I just can't
> believe this. I downloaded the autofs5 sources and compiled them fine. I
> just can't run them since the kernel 2.6.5.7-322 doesn't seem to support
> autofs5. Now I wonder If I can get an up to date autofs4 package running
> under SLES9. The patch that seems to fix this is called:
>
> autofs-4.1.3-included-maps.patch
>
> Any help would be appreciated.

Hello Oliver,

AutoFS 5 won't work on SLES 9 because it requires Kernel changes that
were not back ported to 2.6.5. The first version of SLES to support AutoFS 5
is SLES 10-SP2.

If you really can't upgrade to SLES 10-SP3 or SLES 11-SP1, your best
bet is to get autofs-4.1.4 source RPM from SLES 10-SP3 and rebuild it on
SLES 9. The problem you reported is most likely already fixed on that version.

Hope it helps,
Leonardo
