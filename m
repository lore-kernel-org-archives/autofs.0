From: Venkata Ravella <Venkata.Ravella@synopsys.com>
Subject: Re: Automount/NFS issues causing executables to appear corrupted
Date: Mon, 19 Apr 2004 17:08:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
Reply-To: Venkata Ravella <Venkata.Ravella@synopsys.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S261380AbUDTAIj@vger.kernel.org>
Content-MD5: +FBRoMmHSN9ox+1AV41ZHg==
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: linux-kernel@vger.kernel.org, Ramki.Balasubramanium@synopsys.COM, ab@californiadigital.com, hpa@zytor.com, autofs@linux.kernel.org


autofs version is autofs-3.1.7-21

I also have one new update. We started seeing similar problem on
the system running the kernel 2.4.18-e.12smp which has the same
version(3.1.7-21) of autofs as well.

This may or may not be an autofs problem but, restarting autofs
fixes this problem temporarily.


>
>Please cc autofs questions to the list at autofs@linux.kernel.org.
>
>On Sun, 18 Apr 2004, Venkata Ravella wrote:
>
>> 
>> The current kernel we use is default 7.2 kernel with two modifications:
>> 1) BM patch applied to extend address space for a single process to 3.6GB
>> 2) mnt patch applied to allow upto 1024 nfs mount points
>> 
>> uname -r output:
>> 2.4.7-10mntBMsmp
>
>What autofs version?
>
>To be honest it's a bit hard to see how this is an autofs issue.
>Mind, having said that, ....
>
>Ian
