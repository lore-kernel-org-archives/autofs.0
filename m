From: "Badics, Alex" <alex.badics@balabit.com>
Subject: Re: Autofs + shared mount namespaces
Date: Thu, 14 Sep 2017 10:52:05 +0200
Message-ID: <CAJsjXgr4R988Vxe2sb237fD4mYfJYoZNzP_dHsYk-CFw3TgyGQ@mail.gmail.com>
References: <CAJsjXgryH912APrqk3rzECB=MHKdDg_ROfa6mjTETKKBrW7mmg@mail.gmail.com>
 <3b5cb023-09ad-ccad-dc61-968a1b44dd31@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balabit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4GKn9VcX4/7dR70/yRKFavhl6ER+1X2aG1EEbk4dt9w=;
        b=vnxnZuuaVZxtRpanskmBBI9WXXqnrOkMQqoaoWvTGwN/1M23ej4DKkOIPqmlGlhvok
         oBQzyDLg4rkSJJCBxW1dHr72dA4+HAYDS09sHbSn6wwutUIlu6Q9IL/vHM1+MGO9jAfz
         6yQQM61d/SUImntR9TdSe0GuCKKsaRWqFbn/PBbtI2wgbyKlem+3dyqUZtmeMVgLLO6Q
         +glZ+HnFNfqpXrjhFRasISnavX617X/6d5Lege3gG5lgQ5T6fO+uYqe3gSh4O5g1VfNP
         0VaHbonZc3etIVNu4mqO8SV9kloLdmsZT3yGg0NdX1YkKLpRxDIYCWmOjVxIn0tlDr/7
         sETQ==
In-Reply-To: <3b5cb023-09ad-ccad-dc61-968a1b44dd31@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

> On 12/09/17 21:17, Badics, Alex wrote:
>> Hi,
>>
>> We've been trying out autofs with both systemd-automount and the
>> autofs userspace daemon, and it seems like it incorrectly marks a
>> mountpoint as "expired" even though it's still in use in a different
>> mount namespace. Am I doing something wrong? Are mount namespaces
>> supported by the autofs driver?
>
> There are challenges with namespaces that I'm unable to resolve.
>
> The specific behavior your seeing is one of those problems.
>
> I'm unable to find a way to check propogated mounts.
>
> I tried recently and could only come up with a method that was
> order n squared cost with the number of mounts which was, as you
> would expect, rejected upstream.
>
> And what kernel version are you using?
We tried with the latest stable (4.13.1), the latest Arch one
(4.12.10), and the Xenial one (4.4.0)

>
>>
>> Reproduction:
>> /etc/autofs/auto.master:
>> /mnt/test   /etc/autofs/auto.test.nfs --timeout 10
>>
>> /etc/autofs/auto.test.nfs:
>> test  -rw,soft,intr server.domain:/exports/nfs
>>
>> On one tab, I start autofs:
>> # automount -f -v
>>
>> On another, I unshare a namespace, and cd into the test directory:
>> # cd /mnt
>> # unshare -m --propagation shared
>> # cd test/test
>>
>> And just wait. The mount correctly happens, but after 10 seconds, the
>> autofs daemon gets an expired message and tries to umount hte nfs
>> mount, and fails, because it's busy. It retries until I cd out of the
>> nfs directory, then it of course succeeds:
>>
>> Starting automounter version 5.1.3, master map auto.master
>> using kernel protocol version 5.02
>> mounted indirect on /mnt/test with timeout 10, freq 3 seconds
>> attempting to mount entry /mnt/test/test
>> mounted /mnt/test/test
>> 1 remaining in /mnt/test
>> 1 remaining in /mnt/test
>> 1 remaining in /mnt/test
>> expiring path /mnt/test/test
>>>> umount.nfs4: /mnt/test/test: device is busy
>>>> umount.nfs4: /mnt/test/test: device is busy
>>>> umount.nfs4: /mnt/test/test: device is busy
>> Unable to update the mtab file, /proc/mounts and /etc/mtab will differ
>> expired /mnt/test/test
>> 1 remaining in /mnt/test
>> 1 remaining in /mnt/test
>> 1 remaining in /mnt/test
>> 1 remaining in /mnt/test
>> expiring path /mnt/test/test
>> expired /mnt/test/test
>
> What is it your trying to do?
> How would you like this to behave?
We are trying to mount network shares under a container after it was
started, and umount it when the container no longer uses it. /mnt is
mounted with shared (or slave, we haven't decided on that yet)
propagation, so simple mounts and umounts work fine. The container
does no mount/umount calls whatsoever.

What I found (in my limited research) is that may_umount_tree() is not
namespace-aware, but may_umount is. I thought these should be
semantically the same (one umount a mountpoint IFF she can umount
everything under it), but I guess there are minor differences?

>
> Keep in mind that a mount namespace is little more than a view of
> the set of current mounts so there is limited mount independence
> possible.
>
> Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
