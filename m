From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re: autofs RFE
Date: Wed, 10 Dec 2003 16:51:56 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD7BFAC.4090601@zytor.com>
References: <Pine.LNX.4.33.0312110849540.9869-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0312110849540.9869-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Gerald Teschl <gerald.teschl@univie.ac.at>

Ian Kent wrote:
> On Wed, 10 Dec 2003, H. Peter Anvin wrote:
> 
> 
>>Ian Kent wrote:
>>
>>>Looking at the mount source it appears the 'owner' option is fstab only.
>>>
>>
>>Well, then, then that's probably the place where it should be fixed.
>>
> I'll follow up on it.
> I have the rapid mounts fail issue to raise as well.
> 

By the way, autofs is quite the stress test for mount(8).  It has found
a huge number of bugs over the years.

	-hpa
