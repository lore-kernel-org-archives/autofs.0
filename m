From: Greg Bradner <gregb@rhythm.com>
Subject: Re: [ANNOUNCE] autofs v4 beta3 (fwd)
Date: Thu, 13 Nov 2003 07:52:09 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB3A8A9.80402@rhythm.com>
References: <Pine.LNX.4.33.0311131542180.11228-100000@wombat.indigo.net.au>
	<3FB397B9.9010600@rhythm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB397B9.9010600@rhythm.com>
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
Cc: autofs@linux.kernel.org

I should also add this is for 'program' mounts.

Greg Bradner wrote:

> I have multiple mount points on a NetApp, but I don't have 'access' 
> permissions to all of them.  When autofs encountered a permission 
> denied on one of the mount points, it didn't mount any of them.  
> Shouldn't it just skip over the permission denied one and still mount 
> the others?
>
>
> Nov 11 15:13:32 lid2 automount[2454]: attempting to mount entry 
> /nfs/hosts3/rosie
> Nov 11 15:13:32 lid2 automount[18879]: >> mount: 
> rosie:/vol/vol0/reserve failed, reason given
> by server: Permission denied
> Nov 11 15:13:32 lid2 automount[18879]: mount(nfs): nfs: mount failure 
> rosie:/vol/vol0/reserve
> on /nfs/hosts3/rosie/vol/vol0/reserve
> Nov 11 15:13:32 lid2 automount[2454]: attempting to mount entry 
> /nfs/hosts3/rosie
> Nov 11 15:13:32 lid2 automount[18883]: >> mount: 
> rosie:/vol/vol0/reserve failed, reason given
> by server: Permission denied
>
>
> Ian Kent wrote:
>
>> ---------- Forwarded message ----------
>> Date: 11 Nov 2003 20:51:57 +0800
>> From: Ian Kent <raven@themaw.net>
>> To: autofs@linux.kernel.org
>> Subject: [ANNOUNCE] autofs v4 beta3
>>
>>
>> Status
>> ------
>>
>> I'm hoping that this will be the last beta of 4.1.0.
>>
>> I expect to release 4.1.0 final and corresponding kernel module kit
>> within
>> a week or so.
>>
>> The only bug reports I have had relate to multi-mount problems and this
>> beta includes updates for them as far as they can be fixed at this
>> stage. This leaves one outstanding problem with multi-mount maps. The
>> senario is that the daemon cannot remount a manualy umounted multi-mount
>> entry until after the following expire event. This is due kernel module
>> and daemon not knowing the umount has occured and consequently not
>> cleaning up afterward. This causes the kernel module to return a longer
>> path than it should which cannot be matched in the map. I hope to be
>> able
>> to fix this a some time in the future. In the mean time it is necessary
>> to
>> let the daemon do its thing and all should be OK.
>>
>> A reported problem with the documentation regarding the mailing list
>> subscription instructions is also not yet corrected. Sorry, I'll get it
>> done by the time of the final release.
>>
>> Packages
>> --------
>>
>> As usual the packages can be found at:
>>
>> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4
>>
>> They are:
>>
>> autofs-4.1.0-beta3.tar.[bz2|gz]
>> autofs4-2.4-module-20031109.tar.[bz2|gz]
>>
>> Additionally there is an autofs-4.1.0-beta3.src.rpm. This has been
>> included because the rpmbuild -tb command will not work properly on
>> the tar with this release. Please don't try as the spec file in the tar
>> is
>> out of date. Use the src rpm instead.
>>
>>  
>>
>

-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
