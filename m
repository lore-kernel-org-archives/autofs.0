From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 13:06:34 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40045DDA.1010805@zytor.com>
References: <200401131958.i0DJwlV0001078000@anw.zk3.dec.com>
	<40044F2A.9080305@zytor.com> <200401132023.49657.autofs@dylan.me.uk>
	<4004544C.7030904@zytor.com> <40045C03.7020405@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40045C03.7020405@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org, Eric Werme USG <werme@alpha.zk3.dec.com>

Mike Waychison wrote:
>>>
>>> Would binding an alias address to the interface be sufficient?
>>>
>> No, you have to force the local port to not be bound to the same
>> address.  I think this can be done with iptables rules, but I'm not
>> sure... I'm not a networking wizard.
>>
> I know you can do this using chbind from the vserver toolset and kernel
> patch.
> 
> http://www.13thfloor.at/vserver/s_release/v1.23/

There you go, then.  Either way, autofs should respect this rule once it
is installed in the kernel.
	
	-hpa
