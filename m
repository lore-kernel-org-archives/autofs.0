From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trapping eject button on CD-ROM
Date: Mon, 15 Mar 2004 10:07:13 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4055F0D1.9080603@zytor.com>
References: <20040315035641.22976.qmail@web20501.mail.yahoo.com>
	<200403151124.38057.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403151124.38057.robin.rosenberg.lists@dewire.com>
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
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: autofs@linux.kernel.org, "Kent, Ian I." <IAN.KENT@woodside.com.au>

Robin Rosenberg wrote:
> On Monday 15 March 2004 04:56, Jon Niehof wrote:
> 
>>>Maybe what you need is supermount.
>>>
>>>Google search should turn up something.
>>
>>Perfect. Thank you; that does exactly what I want for
>>my removables and autofs handles the rarely-used
>>partitions fine. Perfect all around.
> 
> 
> Agree, automoun is fine. A short timeout for CD's work fine. Set the timeout 
> to 15 seconds. Shorter is bad if you tend to use GUI's that don't hold a lock 
> on the CD, as the CD will often be unounted/remounted (=slow) inbetween the 
> clicks. and all you have to do is wait a few seconds before the disk is 
> ejected. If it doesn't come out someone is using it.
> 

Note that any time your filesystem is unmounted you throw away the cache.

	-hpa
