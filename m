From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] fs/autofs: Use time_before, time_before_eq, etc.
Date: Wed, 26 Dec 2007 12:45:32 -0800
Message-ID: <4772BD6C.1010502@zytor.com>
References: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk> <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753161AbXLZUqK@vger.kernel.org>
In-Reply-To: <2c0942db0712261158q34cddebeifceef6ceda683320@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Julia Lawall <julia@diku.dk>, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Ray Lee wrote:
> On Dec 26, 2007 7:21 AM, Julia Lawall <julia@diku.dk> wrote:
>> -               if (jiffies - ent->last_usage < timeout)
>> +               if (time_before(jiffies, ent->last_usage + timeout))
> 
> I don't think this is a safe change? subtraction is always safe (if
> you think about it as 'distance'), addition isn't always safe unless
> you know the range. The time_before macro will expand that out to
> (effectively):
> 
>   if ( (long)(ent->last_usage + timeout) - (long)(jiffies) < 0 )
> 
> which seems to introduce an overflow condition in the first term.
> 
> Dunno, I may be wrong (happens often), but at the very least what
> you've transformed it into is no longer obviously correct, and so it's
> not a great change.

Indeed.  The bottom form will have overflow issues at time 
jiffies_wraparound/2, whereas the top form will have overflow issues 
only near jiffies_wraparound/1.

	-hpa
