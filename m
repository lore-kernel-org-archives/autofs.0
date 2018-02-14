From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 20/20] autofs-5.1.4 - add an example fedfs master map
 entry to the installed master map
Date: Thu, 15 Feb 2018 07:57:55 +0800
Message-ID: <bfd9da64-cdab-c220-abe2-cdab78fdd716@themaw.net>
References: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
 <151859068445.8026.13141630121236897160.stgit@pluto.themaw.net>
 <20180214234734.GC15525@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Xp7B7Hy6ebMYN/Quv05HWQR5d4Bhx
        ApvEBkpOrAO7FE=; b=K3KH30C/S3h28c50SDw+w15AmSxYhB1UHsZA8hn+qOalv
        BT+qr1W1iTDaWNCz2VDs5vnokxAKuQli09UoQLuII0sAtiGmXVUS4rLZAhAz3tqC
        c4o8JnNxIgHFZw+kqOpueG/Fh47itOpr+y4u/nSlFon44Go15lvp/vBPPOQqry43
        37IiOV6pA8X5fB2M/n4AftMx3dujuc+++sRiPxFHT7sm7AEIZC2dWu+r//KAyRvJ
        lz1bkOTaTGYVO5hS5cGDgwF5Nvd5iUTzhih6QsU49CYYLBulf3Rw+G1WcjFH/BGP
        PjhPg1CSnnA0RAWMESgClCV+O/tf5Skma/8MYMqXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Xp7B7H
        y6ebMYN/Quv05HWQR5d4BhxApvEBkpOrAO7FE=; b=Fe7HCU6n62chmH3HBsMV9G
        Bc3jNtXKWHQG7e9e2MPsvLIYJAfvNJfSBx0H+oBQKE+ok5YQ31YSLZUovf8jK/jV
        pzwrgK8qGCX2k3WEq1a3l1vY/MpN8gg8biXAud5ecFuvVw7ovbTreB/1wGaG6DRU
        jc50QQV6K/7aTPBlvY0mpA+zIQJM6wUYmpaIEk6etWkmtfSSLPCeromQE4hrbjDX
        gtd0ZhFYrJ62gDUWE4hwKi7EeSEMkRjF0PlzZxMYFII05fdMmoarxl1CCP1c1xNI
        1ExAAzvBU3uxl6V32CHSbjhOUxtcCuNntVHS6zU27VNvbfS0pAFi/1tHMsYopEFQ
        ==
In-Reply-To: <20180214234734.GC15525@mayhem.atnf.CSIRO.AU>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vincent McIntyre <vincent.mcintyre@csiro.au>
Cc: autofs mailing list <autofs@vger.kernel.org>

On 15/02/18 07:47, Vincent McIntyre wrote:
> On Wed, Feb 14, 2018 at 02:44:44PM +0800, Ian Kent wrote:
>> Add an example of using the fedfs program map (to facilitate access
>> to fedfs domain mounts) to the installed master map.
>> ---
>>  CHANGELOG           |    1 +
>>  samples/auto.master |    6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/CHANGELOG b/CHANGELOG
>> index bbe8019e..f771a433 100644
>> --- a/CHANGELOG
>> +++ b/CHANGELOG
>> @@ -18,6 +18,7 @@ xx/xx/2018 autofs-5.1.5
>>  - add mount.fedfs.c.
>>  - add fedfs-map-nfs4.c.
>>  - add conditional inclusion of fedfs binaries.
>> +- add an example fedfs master map entry to the installed master map.
>>  
>>  19/12/2017 autofs-5.1.4
>>  - fix spec file url.
>> diff --git a/samples/auto.master b/samples/auto.master
>> index 0f2c8ab0..6c95fadf 100644
>> --- a/samples/auto.master
>> +++ b/samples/auto.master
>> @@ -17,6 +17,12 @@
>>  #
>>  +dir:/etc/auto.master.d
>>  #
>> +# If you have fedfs setup and the realted binaries, either
> 
> s/setup/set up/     (?)
> s/realted/related/

Ha, thanks Vince.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
