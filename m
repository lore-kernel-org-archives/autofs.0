From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] autofs: sanity check status reported with AUTOFS_DEV_IOCTL_FAIL
Date: Fri, 16 Jun 2017 20:33:11 +1000
Message-ID: <8760fww7bs.fsf@concordia.ellerman.id.au>
References: <871sqwczx5.fsf@notabene.neil.brown.name> <20170615163400.e2f024125581f452d48f1aca@linux-foundation.org> <87fuf07k84.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <87fuf07k84.fsf@notabene.neil.brown.name>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>

NeilBrown <neilb@suse.com> writes:
> On Thu, Jun 15 2017, Andrew Morton wrote:
>> On Wed, 07 Jun 2017 12:08:38 +1000 NeilBrown <neilb@suse.com> wrote:
>>> --- a/fs/autofs4/dev-ioctl.c
>>> +++ b/fs/autofs4/dev-ioctl.c
>>> @@ -344,7 +344,7 @@ static int autofs_dev_ioctl_fail(struct file *fp,
>>>  	int status;
>>>  
>>>  	token = (autofs_wqt_t) param->fail.token;
>>> -	status = param->fail.status ? param->fail.status : -ENOENT;
>>> +	status = param->fail.status < 0 ? param->fail.status : -ENOENT;
>>>  	return autofs4_wait_release(sbi, token, status);
>>>  }
>>
>> Sounds serious.  Was the absence of a cc:stable deliberate?
>
> You need CAP_SYS_ADMIN to  get the ioctl even looked at.  Doesn't that
> mean the bug can only be triggered by a process that could easily do
> worse?
>
> Or do containers allow admins to give out CAP_SYS_ADMIN to untrusted
> people??  I haven't been keeping up.

Yep. They can be configured individually in fact, eg:

  $ docker run --cap-drop=ALL --cap-add=sys_admin -it debian:jessie /bin/bash
  root@aedebe8c46e0:/# capsh --print
  Current: = cap_sys_admin+eip
  Bounding set =cap_sys_admin
  Securebits: 00/0x0/1'b0
   secure-noroot: no (unlocked)
   secure-no-suid-fixup: no (unlocked)
   secure-keep-caps: no (unlocked)
  uid=0(root)
  gid=0(root)
  groups=


cheers
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
