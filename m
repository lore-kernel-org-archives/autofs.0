From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re: autofs RFE
Date: Tue, 09 Dec 2003 22:48:58 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD6C1DA.7070303@zytor.com>
References: <Pine.LNX.4.33.0312081134310.26524-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0312081134310.26524-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Gerald Teschl <gerald@esi.ac.at>

Ian Kent wrote:
>>
>>Would it be possible to make autofs honor the "owner" option for mount and
>>mount a dev with the permissions of the owner if this option is present?
> 
> I've been thinking about this for a while.
> 
> At the moment the userspace daemon has no way of knowing who the owner is.
> To change that would break backward compatability. So I'm not sure it's
> such a good idea.
> 
> How is this handled in v3 Peter?
> 

Actually, it's handled just fine by mount(8); the autofs daemon doesn't 
need to do anything special.

Just pass the -owner filesystem option and mount(8) will use the 
ownership of the device node.

	-hpa
