From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 11:57:38 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF07B2.70801@zytor.com>
References: <3FFC96FE.9050002@zytor.com>
	<Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
	<20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
	<3FFF03EA.4060603@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FFF03EA.4060603@sun.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, viro@parcelfarce.linux.theplanet.co.uk, "Ogden, Aaron A." <aogden@unocal.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Ian Kent <raven@themaw.net>

Mike Waychison wrote:
>>
>> Special vfsmount mounted somewhere; has no superblock associated with it;
>> attempt to step on it triggers event; normal result of that event is to
>> get a normal mount on top of it, at which point usual chaining logics
>> will make sure that we don't see the trap until it's uncovered by removal
>> of covering filesystem.  Trap (and everything mounted on it, etc.) can
>> be removed by normal lazy umount.
>>
>> Basically, it's a single-point analog of autofs done entirely in VFS.
>> The job of automounter is to maintain the traps and react to events.
>>
> Is there any clear advantage to doing this in the VFS other than saving
> a superblock and a dentry/inode pair or two?
> 
> I remember talking to you about this, and I seem to recall that these
> mount traps would probably communicate using a struct file, so a
> trap-user would somehow receive events about when the trap was set
> off.   Will this communication model continue to work within a cloned
> namespace?  What happens if the trap-client closes the file?
> 

The biggest issue is to ensure that the appropriate atomicity guarantees
can be maintained.  In particular, it must be possible to umount the
underlying filesystem and all mount traps on top of it atomically.
Anything less will result in race conditions.

	-hpa
