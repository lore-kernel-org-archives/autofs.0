From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling
	into fs
Date: Mon, 05 Jul 2010 13:12:29 -0700
Message-ID: <4C323CAD.1070602@zytor.com>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de>
	<4C3235C3.7050303@zytor.com> <20100705194759.GE5240@nowhere>
	<201007052152.55954.arnd@arndb.de> <20100705195837.GF5240@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20100705195837.GF5240@nowhere>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: autofs@linux.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, John Kacur <jkacur@redhat.com>, Ian Kent <raven@themaw.net>

On 07/05/2010 12:58 PM, Frederic Weisbecker wrote:
> On Mon, Jul 05, 2010 at 09:52:55PM +0200, Arnd Bergmann wrote:
>> On Monday 05 July 2010 21:48:01 Frederic Weisbecker wrote:
>>> On Mon, Jul 05, 2010 at 12:42:59PM -0700, H. Peter Anvin wrote:
>>>> On 07/05/2010 12:24 PM, Frederic Weisbecker wrote:
>>>>>
>>>>> Peter, if you're fine with this version. May I apply it?
>>>>> Unless you have a tree for autofs.
>>>>>
>>>> Ian Kent is the maintainer of autofs4 and patches for autofs4 should go
>>>> through him (or acked by him.)
>>>>
>>>> autofs 3 is officially unmaintained; I'm more than happy to have you
>>>> push the autofs 3 bits of this patch.
>>>
>>> Sure, I can split up the patch and integrate the autofs 3 part, I'll send
>>> the standalone autofs4 version to Ian.
>>
>> I think in this case it's really more appropriate to change both autofs3
>> and autofs4 together, to avoid interdependencies. Whichever way Ian
>> prefers (ack the patch or take it) would work though.
>>
>> 	Arnd
> 
> 
> Yeah indeed. Ian?
> 

For what it's worth, feel free to add my:

Acked-by: H. Peter Anvin <hpa@zytor.com>

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
