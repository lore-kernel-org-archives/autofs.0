From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs + shared mount namespaces
Date: Thu, 14 Sep 2017 18:57:35 +0800
Message-ID: <ec4ace9b-ed17-2273-1bea-031c134909a2@themaw.net>
References: <CAJsjXgryH912APrqk3rzECB=MHKdDg_ROfa6mjTETKKBrW7mmg@mail.gmail.com>
 <3b5cb023-09ad-ccad-dc61-968a1b44dd31@themaw.net>
 <CAJsjXgr4R988Vxe2sb237fD4mYfJYoZNzP_dHsYk-CFw3TgyGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=5TEbe+eBgFgIqSpyUg
        G88tL3csc1yErSnSgkxX8lHLw=; b=YCgnf4FahJyz47ORk9Giha0VetDUsYnGxb
        VpkjT7CEKMWzZAI3NTcmpla4dxLGPfUTpqysrZ8CZFIeuFqZTHuYEJYdptBBMN/I
        Fp/+IbGzbpu/01XQk4pI52HwwD6YPYA/hHWZl2H8RW2GSi9/HRaLv6t0vbTNx5HL
        ToLgabVdbaTevGfVwBB3126toz/1JLh8Xvk15L49EGiDRRHgW5cBWjZp7JDpdaKz
        qp0ZKQ/SKmk3AGeW02JL4ZFObt9WoBdD9JTXTUj0IV4vKP29/Gxw2SWvAGxLQBsO
        hGPVDyOaxd9ymuusr1yUj2HaeJsbWJl0AtayCRNKGSlJ5fHGCgrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=5TEbe+eBgFgIqSpyUgG88tL3csc1yErSnSgkxX8lHLw=; b=INnOrijk
        i8QkYC8ZGaHaLU9CVS0rkSJrTeW6JJpC4uaWFwwRYOg2pWDgmqP850FhRCkGxqhU
        s2nt3SNKMYFSiUKs4rljmzoOK2O3yui+osWx2u+q4A0dDcLW3cy0E9F562mhojcf
        GRCVckjxNv+2SeHL012B5O6MB+4c2fvF1QORRFwHy2g6suaaiIeBaTsl4RIyFaNd
        4ula8oepjVYW9UTKUahSkpO9ZUB75jQ+W7CoTmChaCjp72kYH9UIaOZR2okThuxH
        jrSsVYcFEb9jreAGuT6fSITAdH84mp6RWHDjUf9FtmgSU6Mlx4tHaGGJ18ivvosp
        1SM4Fb1XYKSFiQ==
In-Reply-To: <CAJsjXgr4R988Vxe2sb237fD4mYfJYoZNzP_dHsYk-CFw3TgyGQ@mail.gmail.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Badics, Alex" <alex.badics@balabit.com>
Cc: autofs@vger.kernel.org

On 14/09/17 16:52, Badics, Alex wrote:
>> On 12/09/17 21:17, Badics, Alex wrote:
>>> Hi,
>>>
>>> We've been trying out autofs with both systemd-automount and the
>>> autofs userspace daemon, and it seems like it incorrectly marks a
>>> mountpoint as "expired" even though it's still in use in a different
>>> mount namespace. Am I doing something wrong? Are mount namespaces
>>> supported by the autofs driver?
>>
>> There are challenges with namespaces that I'm unable to resolve.
>>
>> The specific behavior your seeing is one of those problems.
>>
>> I'm unable to find a way to check propogated mounts.
>>
>> I tried recently and could only come up with a method that was
>> order n squared cost with the number of mounts which was, as you
>> would expect, rejected upstream.
>>
>> And what kernel version are you using?
> We tried with the latest stable (4.13.1), the latest Arch one
> (4.12.10), and the Xenial one (4.4.0)

Ok, 4.10 or later is best for this use case IMHO.

> 
>>
>>>
>>> Reproduction:
>>> /etc/autofs/auto.master:
>>> /mnt/test   /etc/autofs/auto.test.nfs --timeout 10
>>>
>>> /etc/autofs/auto.test.nfs:
>>> test  -rw,soft,intr server.domain:/exports/nfs
>>>
>>> On one tab, I start autofs:
>>> # automount -f -v
>>>
>>> On another, I unshare a namespace, and cd into the test directory:
>>> # cd /mnt
>>> # unshare -m --propagation shared
>>> # cd test/test
>>>
>>> And just wait. The mount correctly happens, but after 10 seconds, the
>>> autofs daemon gets an expired message and tries to umount hte nfs
>>> mount, and fails, because it's busy. It retries until I cd out of the
>>> nfs directory, then it of course succeeds:
>>>
>>> Starting automounter version 5.1.3, master map auto.master
>>> using kernel protocol version 5.02
>>> mounted indirect on /mnt/test with timeout 10, freq 3 seconds
>>> attempting to mount entry /mnt/test/test
>>> mounted /mnt/test/test
>>> 1 remaining in /mnt/test
>>> 1 remaining in /mnt/test
>>> 1 remaining in /mnt/test
>>> expiring path /mnt/test/test
>>>>> umount.nfs4: /mnt/test/test: device is busy
>>>>> umount.nfs4: /mnt/test/test: device is busy
>>>>> umount.nfs4: /mnt/test/test: device is busy
>>> Unable to update the mtab file, /proc/mounts and /etc/mtab will differ
>>> expired /mnt/test/test
>>> 1 remaining in /mnt/test
>>> 1 remaining in /mnt/test
>>> 1 remaining in /mnt/test
>>> 1 remaining in /mnt/test
>>> expiring path /mnt/test/test
>>> expired /mnt/test/test
>>
>> What is it your trying to do?
>> How would you like this to behave?
> We are trying to mount network shares under a container after it was
> started, and umount it when the container no longer uses it. /mnt is
> mounted with shared (or slave, we haven't decided on that yet)
> propagation, so simple mounts and umounts work fine. The container
> does no mount/umount calls whatsoever.

I recommend you consider using propagation slave, you don't want
container changes to affect things in the root namespace that should
remain present in that namespace.

The root namespace (usually "/", or at least the parent mount that
will contain the mounts you want to propagate) must be propagation
shared for mount propagation to slaves to function. If it isn't you'll
get a clone of existing mounts but no propagation of mounts triggered
by the container and no propagation of umounts expired by the automount
daemon. This is because the children of mounts are what propagates not
the mount itself.

There are two ways that should work ok using an automount with containers

The first is to run the daemon in the root namespace (assuming "/" is
propagation shared) and pass the autofs indirect mount point as a volume
to the container (I'm assuming docker and using the --volume option). In
any case you need some way to pass the autofs mount point to the container
and some way to ensure the container root file system is propagation slave
so that the container child autofs indirect mount receives propagated mounts.

There's no sensible way to use autofs direct mounts with containers AFAICS.

I've really only tried this stuff with docker so we would need to work
out what needs to be done for other systems.

The other way is to run automount daemons entirely within each container
you need automount services for. In this case you should (I think must)
not pass an autofs mounted volume from the root namespace to the container.
It needs to be fully isolated.

Similar problems to what you describe above will still occur with propagation
private namespaces but with kernel 4.10 or later they shouldn't affect 
containers or the root namespace. There might still be expire problems, not
sure about that, I thought not when I made the recent changes.

> 
> What I found (in my limited research) is that may_umount_tree() is not
> namespace-aware, but may_umount is. I thought these should be
> semantically the same (one umount a mountpoint IFF she can umount
> everything under it), but I guess there are minor differences?

That's right, autofs v5 uses may_umount_tree() for it's pre-umount
check and it is the one that I was unable to update to be namespace
aware.

Although the way may_umount() works is the same as what is used by
umount(2) it isn't adequate for checking busyness of a tree of mounts
from automount POV (eg. subtrees of mounts that would test busy by
may_umount() that aren't busy from an autofs POV need to be able to
be checked).

Not sure this is useful, I'll try and help if you have further questions, ;)

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
