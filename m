From: "Cyril B." <cbay@excellency.fr>
Subject: Re: Regular deadlocks
Date: Wed, 29 Jun 2016 14:45:38 +0200
Message-ID: <4e07d49f-83ab-4054-8cbd-5c5b1675251a@excellency.fr>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
 <1466906389.739.25.camel@themaw.net>
 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
 <1466987208.3191.6.camel@themaw.net>
 <17c66f92-bda8-1eb9-621c-47e39406acc2@excellency.fr>
 <1467073622.3767.17.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=alwaysdata.net; s=ad;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=2f7a0pwuF7U3FIt8H4KQJ6pE7AW/qeOfudtqabZgDSg=;
	b=IGXLCVAtkHqJXj0LpFdPZonyexQGiXnfLWBe7qEEmoseWKV0S67YSUF/59SHzjx4lmx4xFe/IvF07ejglNaJ6n4YcYsOoZCphacHtYz6kp0yH+RbWUbLDm0DNV43o7praYugG60mXVRprw3AJQVCw+lHPSl3HTrSgRX7MSAPel4=;
In-Reply-To: <1467073622.3767.17.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 06/28/2016 02:27 AM, Ian Kent wrote:
> At this point a full debug log would probably answer most of my questions.

I have a full debug log for you. I don't know what the policy is for 
sending attachments on the mailing list, so I'll send the log to you only.

The "deadlock" happened at 22:00, /nfs/http12 was unmounted shortly before:

Jun 28 21:55:21 ssh1 automount[3848595]: umount_subtree_mounts: 
unmounting dir = /nfs/http12

Here's a 'ps aux|grep mount' from this morning, before I cleaned it up:

root      153793  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      153798  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      153803  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      153808  0.0  0.0      0     0 ?        Z    Jun28   0:00 
[mount] <defunct>
root      153819  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      153860  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      153861  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      154529  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      155381  0.0  0.0 271852  1868 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      156565  0.0  0.0 272880  1900 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      176662  0.0  0.0   3944   392 ?        S    Jun28   0:00 
/bin/sh -c /bin/umount /home/bikes
root      176663  0.0  0.0   8124   480 ?        S    Jun28   0:00 
/bin/umount /home/bikes
root      176671  0.0  0.0 274936  1964 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      195792  0.0  0.0 275964  1996 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      195817  0.0  0.0 275964  1996 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      228410  0.0  0.0 276992  2028 ?        S    Jun28   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      232950  0.0  0.0 279048  2092 ?        S    00:00   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      232969  0.0  0.0 279048  2092 ?        S    00:00   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      236404  0.0  0.0 280076  2124 ?        S    00:05   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      262934  0.0  0.0 281104  2156 ?        S    00:39   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      340095  0.0  0.0 283160  2220 ?        S    02:55   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      344231  0.0  0.0 283160  2220 ?        S    03:05   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      361273  0.0  0.0 284188  2252 ?        S    03:55   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      384154  0.0  0.0 287272  2348 ?        S    05:00   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      384165  0.0  0.0 287272  2348 ?        S    05:00   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      384170  0.0  0.0 287272  2348 ?        S    05:00   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      407146  0.0  0.0 288300  2380 ?        S    06:01   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      595311  0.0  0.0 289328  2412 ?        S    09:34   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root      597797  0.0  0.0 290356  2444 ?        S    09:40   0:00 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     3848595  0.0  0.0 291384  5756 ?        Ssl  Jun28   0:21 
/usr/sbin/automount --pid-file /var/run/autofs.pid

The umount '/home/bikes' was not done by autofs, it was done by a script.

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
