From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/2] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Date: Sat, 5 Aug 2023 10:38:29 +0800
Message-ID: <3030f42d-1ab2-4815-0526-73136f349665@themaw.net>
References: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
 <20230804-siegen-moralisieren-dd3dc2595ee2@brauner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1691203117; x=1691289517; bh=XeYyMuf4nTof6DJeNjR1M2UY/Ud55rp04sm
        HiFwidbI=; b=VNuMFDFiIXo2a+6kdC0RTo2uZf27G3JL1EeYtLCWvUFxwnstJ73
        JKHBZKaXqyrJG/1BejltrcQZKEo19uIBGIcb5PpVpTLwhgQtrrDC9ufVtErPBq2F
        O7zjcKnzKFqyLIsuJT5Jf+Up+XGISsPXku244rWFV0G0cSWRJLrePeRdtcnm01bx
        mFl3+WYYTcNADZQct7EMDD09nd6udb28tHxT6cBoPXZQag58/KSXsGIgJjrF+cFD
        DuQjSzm33MdZw0ccemTfh8un1G6I3VuYkCfyBMd2jOoJTPLekRFlZx5DLU+vZT+7
        aZeADCudi0dd8Uhsg6PPaDFoK+Y/1i5SRog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691203117; x=1691289517; bh=XeYyMuf4nTof6DJeNjR1M2UY/Ud55rp04sm
        HiFwidbI=; b=RAP32c6Ko+JP0MRo1V0LGvxZrOB4XM5hWLW7ip3KkPGaojJEben
        5cuizde/h2CmqS4NqXDBbxyxeefbq+c1B1ssNEfXy+Z/cbXQKEuYjm/zCNYANjkk
        mWXykyFimoCPAeTAUmkF4llVYoNZ310nazOljg4Zxzb7sXdHvB60HWAhgv9S8TwP
        fh1ERXiN3DyyP4ETUkkTZ9Z6nnJOFZNaKXMrjxPE17Xuj57jd82jYROvmn7PwXHX
        X5kArb8HxhJRg1z41m5af3viN/ny1aMUaIYtzhEs8GfdMkSsMW5CE09hhN3raN9e
        2AmxHCtxy7rA3cMFF22Hu7OTZQEt2x8Vfvw==
Content-Language: en-US
In-Reply-To: <20230804-siegen-moralisieren-dd3dc2595ee2@brauner>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>, Takeshi Misawa <jeliantsurux@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Matthew Wilcox <willy@infradead.org>, Andrey Vagin <avagin@openvz.org>

On 4/8/23 19:14, Christian Brauner wrote:
> On Fri, Aug 04, 2023 at 01:33:12PM +0800, Ian Kent wrote:
>> From: Fedor Pchelkin <pchelkin@ispras.ru>
>>
>> Syzkaller reports a memory leak:
>>
>> BUG: memory leak
>> unreferenced object 0xffff88810b279e00 (size 96):
>>    comm "syz-executor399", pid 3631, jiffies 4294964921 (age 23.870s)
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 08 9e 27 0b 81 88 ff ff  ..........'.....
>>      08 9e 27 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ..'.............
>>    backtrace:
>>      [<ffffffff814cfc90>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
>>      [<ffffffff81bb75ca>] kmalloc include/linux/slab.h:576 [inline]
>>      [<ffffffff81bb75ca>] autofs_wait+0x3fa/0x9a0 fs/autofs/waitq.c:378
>>      [<ffffffff81bb88a7>] autofs_do_expire_multi+0xa7/0x3e0 fs/autofs/expire.c:593
>>      [<ffffffff81bb8c33>] autofs_expire_multi+0x53/0x80 fs/autofs/expire.c:619
>>      [<ffffffff81bb6972>] autofs_root_ioctl_unlocked+0x322/0x3b0 fs/autofs/root.c:897
>>      [<ffffffff81bb6a95>] autofs_root_ioctl+0x25/0x30 fs/autofs/root.c:910
>>      [<ffffffff81602a9c>] vfs_ioctl fs/ioctl.c:51 [inline]
>>      [<ffffffff81602a9c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
>>      [<ffffffff81602a9c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
>>      [<ffffffff81602a9c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
>>      [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>      [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>      [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> autofs_wait_queue structs should be freed if their wait_ctr becomes zero.
>> Otherwise they will be lost.
>>
>> In this case an AUTOFS_IOC_EXPIRE_MULTI ioctl is done, then a new
>> waitqueue struct is allocated in autofs_wait(), its initial wait_ctr
>> equals 2. After that wait_event_killable() is interrupted (it returns
>> -ERESTARTSYS), so that 'wq->name.name == NULL' condition may be not
>> satisfied. Actually, this condition can be satisfied when
>> autofs_wait_release() or autofs_catatonic_mode() is called and, what is
>> also important, wait_ctr is decremented in those places. Upon the exit of
>> autofs_wait(), wait_ctr is decremented to 1. Then the unmounting process
>> begins: kill_sb calls autofs_catatonic_mode(), which should have freed the
>> waitqueues, but it only decrements its usage counter to zero which is not
>> a correct behaviour.
>>
>> edit:imk
>> This description is of course not correct. The umount performed as a result
>> of an expire is a umount of a mount that has been automounted, it's not the
>> autofs mount itself. They happen independently, usually after everything
>> mounted within the autofs file system has been expired away. If everything
>> hasn't been expired away the automount daemon can still exit leaving mounts
>> in place. But expires done in both cases will result in a notification that
>> calls autofs_wait_release() with a result status. The problem case is the
>> summary execution of of the automount daemon. In this case any waiting
>> processes won't be woken up until either they are terminated or the mount
>> is umounted.
>> end edit: imk
>>
>> So in catatonic mode we should free waitqueues which counter becomes zero.
>>
>> edit: imk
>> Initially I was concerned that the calling of autofs_wait_release() and
>> autofs_catatonic_mode() was not mutually exclusive but that can't be the
>> case (obviously) because the queue entry (or entries) is removed from the
>> list when either of these two functions are called. Consequently the wait
>> entry will be freed by only one of these functions or by the woken process
>> in autofs_wait() depending on the order of the calls.
>> end edit: imk
>>
>> Reported-by: syzbot+5e53f70e69ff0c0a1c0c@syzkaller.appspotmail.com
>> Suggested-by: Takeshi Misawa <jeliantsurux@gmail.com>
>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrei Vagin <avagin@gmail.com>
>> Cc: autofs@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   fs/autofs/waitq.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
>> index 54c1f8b8b075..efdc76732fae 100644
>> --- a/fs/autofs/waitq.c
>> +++ b/fs/autofs/waitq.c
>> @@ -32,8 +32,9 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
>>   		wq->status = -ENOENT; /* Magic is gone - report failure */
>>   		kfree(wq->name.name - wq->offset);
>>   		wq->name.name = NULL;
>> -		wq->wait_ctr--;
>>   		wake_up_interruptible(&wq->queue);
>> +		if (!--wq->wait_ctr)
>> +			kfree(wq);
> The only thing that peeked my interest was:
>
> autofs_wait()
> -> if (!wq)
>     -> wq->wait_ctr = 2;
>     -> autofs_notify_daemon()
>
> Let's say autofs_write() fails with -EIO or for whatever reason and so
> we end up calling:
>
>        -> autofs_catatonic_mode()
>
> If wait_ctr can be decremented in between so that
> autofs_catatonic_mode() frees it and then autofs_wait() would cause a
> UAF when it tries to much with wq again. But afaict, this can't happen
> because and would also affect autofs_notify_daemon() then.

Interesting observation.

I'll think about it some more.


But I think a call autofs_catatonic_mode() or autofs_wait_release()

from autofs_notify_daemon() will reduce the count by one. At this

point there can't be any other calls to autofs_wait_release() for

this wait id since they come back as a result of the notification. But

perhaps there could be a call for another wait id which implies that

catatonic mode might cause a problem ... I'm not sure that can happen ...

if the pipe isn't setup then the autofs mount hasn't been done ... if

the pipe has gone away the daemon has gone away so no calls to

autofs_wait_release() ...


It is worth some more thought though ...


I guess there could be something odd where some process accesses

a path and triggers a request when the daemon is killed and then

the mount is umounted at the same time of the request but it's

hard to see how that could happen.


Ian

