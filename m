From: Ian Kent <raven@themaw.net>
Subject: Re: autofs changes process's current working directory
Date: Tue, 15 Dec 2009 09:18:15 +0800
Message-ID: <4B26E3D7.9070807@themaw.net>
References: <bd985a450909070436x2ddf0fa8l3b20e908f2f2e3c5@mail.gmail.com>	<4ACED0F1.9050909@themaw.net>	<c2d0b6ec0912140928v74a2c03bv6b9fd9ea5990d9cc@mail.gmail.com>	<4B268068.1030704@themaw.net>
	<4B26B73A.3030402@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B26B73A.3030402@kmaclub.com>
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
To: "michael@kmaclub.com" <michael@kmaclub.com>
Cc: autofs@linux.kernel.org

michael@kmaclub.com wrote:
> On 12/14/2009 11:14 AM, Ian Kent wrote:
>> Leonardo Chiquitto wrote:
>>>>> I'm experiencing a problem with autofs. It seems that when a process
>>>>> is inside an automounted nfs filesystem, if I restart the automount
>>>>> daemon the current working directory of the process is changed and a
>>>>> few leading directory are removed leading to a non-existent cwd.
>>>> That's right.
>>>>
>>>> It's because, with older user space and kernel, the mount is detached
>>>> from the mount tree by a "umount -l" at restart when trying to cleanup
>>>> stale mounts.
>>>>
>>>> Note that this is a non-trivial problem and took a long time to fix.
>>>>
>>>> What autofs and kernel are you using?
>>>
>>> Ian,
>>>
>>> I'm also getting this problem on 2.6.31 with autofs-5.0.4. Please, do
>>> you
>>> remember when the fix was committed? Is this related to some (new)
>>> configuration option?
>>
>> Have a look at your init script and the installed autofs configuration.
>>
>> Basically you need /dev/autofs to exist (created when the autofs4 kernel
>> module is loaded) and that's about it. But the init script may be
>> removing it because it thinks you don't want to use it.
> 
> 
> Hi Ian,
> 
> Are you aware of any work to back port these changes into ~2.6.16?  I am
> using an enterprise distribution and this issue is causing us problems.

Not sure but the patches are in the 5.0.4 tar.
There are a couple of bug fixes but nothing major.

It's present in RHEL-5.4.

Ian
