From: Greg Bradner <gregb@rhythm.com>
Subject: Re: running out of mount points
Date: Mon, 19 Jan 2004 11:07:29 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <400C2AF1.10309@rhythm.com>
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
	<4004409C.6040900@sun.com> <Pine.LNX.4.58.0401142351470.1783@raven.themaw.net>
	<40059944.4060901@rhythm.com> <400BFC65.3000700@rhythm.com>
	<400C0FD2.6000507@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <400C0FD2.6000507@sun.com>
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
To: autofs@linux.kernel.org

I was hoping there would have been something in the configuration.  
Right now I use AMD on my mailhost because it understands that it has 
the server mounted and just links to the mount without creating another 
mount point.

Wouldn't that be more desirable?


> Greg Bradner wrote:
>
>> I wanted to repost this plea. I am really in a bind and could use 
>> some help. I need to mount these users on the mail server.
>> BTW: this is with autofs 4.1.0
>>
> This has been discussed various times on this mailing list and is a 
> known limitation in 2.4 / 2.6.   In 2.4, you can patch your kernel 
> using something similar to:
>
> http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff
>
> HTH,
>
