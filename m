From: Gerald Teschl <gerald.teschl@univie.ac.at>
Subject: Re: Re: autofs RFE
Date: Wed, 10 Dec 2003 09:52:05 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD6DEB5.3090800@univie.ac.at>
References: <Pine.LNX.4.33.0312081134310.26524-100000@wombat.indigo.net.au>
	<3FD6C1DA.7070303@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD6C1DA.7070303@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

H. Peter Anvin wrote:

> Ian Kent wrote:
>
>>>
>>> Would it be possible to make autofs honor the "owner" option for 
>>> mount and
>>> mount a dev with the permissions of the owner if this option is 
>>> present?
>>
>>
>> I've been thinking about this for a while.
>>
>> At the moment the userspace daemon has no way of knowing who the 
>> owner is.
>> To change that would break backward compatability. So I'm not sure it's
>> such a good idea.
>>
>> How is this handled in v3 Peter?
>>
>
> Actually, it's handled just fine by mount(8); the autofs daemon 
> doesn't need to do anything special.
>
> Just pass the -owner filesystem option and mount(8) will use the 
> ownership of the device node.

Not sure if I understand you right, but just adding the owner option to 
the list of options in the
autofs config file does not work right now.

So IMHO the autofs daemon needs to change uid
(to the uid owning the device) before doing the mount call if the owner 
option is present.


Gerald
