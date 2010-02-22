From: Ian Kent <raven@themaw.net>
Subject: Re: How to determine a path is a mountpoint.
Date: Mon, 22 Feb 2010 11:54:03 +0800
Message-ID: <4B81FFDB.8030006@themaw.net>
References: <201002152253.46863.stef@bononline.nl>
	<4B7E0C1B.4040209@themaw.net>
	<201002191511.49512.stef@bononline.nl>
	<201002211428.39077.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <201002211428.39077.stef@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On 02/21/2010 09:28 PM, Stef Bon wrote:
> On Friday 19 February 2010 15:11:49 Stef Bon wrote:
>> On Friday 19 February 2010 04:57:15 Ian Kent wrote:
>>> On 02/19/2010 07:18 AM, Stef Bon wrote:
>>>> On Wednesday 17 February 2010 15:25:08 Ian Kent wrote:
>>>> My fusemodule is an overlay fs, which mirrors another directory under
>>>> the directory under which it's mounted, and does some changes.
>>>
>>> aka unionfs type behaviour?
>>>
>>> You are in for a bundle of trouble if your trying to implement an
>>> overlay file system. If there are enough restrictions on functionality
>>> you might be able to get this working reliably but the locking alone
>>> will likely drive you nuts! You understand that once you play in kernel
>>> space you can have multiple concurrent code paths accessing and possibly
>>> changing the same data structures at the same time.
>>
>> Well it's difficult, well not for me, but for the deveopers of FUSE. It's
>> not in kernel space, but in userspace. Never heard of?
>>
>>
>> My directory looks like:
>>
>> root [ /usr/src/cblfs-200910/autofs-5.0.5 ]# /bin/ls -l
>> /mnt/mount.md5key/sbon/mount/ total 0
>> dr-xr-xr-x 2 root root 0 2010-02-19 13:42 60ef51078836b9a9c78a3398f053d562
>> dr-xr-xr-x 2 root root 0 2010-02-19 13:42 7bfb90bb66496650c21925bd56a71bdc
>> dr-xr-xr-x 2 root root 0 2010-02-19 13:42 e23e33a53d5d08ad8f0425de4edd9309
>>
>>
>> while nothing is mounted:
>>
>> root [ /usr/src/cblfs-200910/autofs-5.0.5 ]# mount | grep
>> /mnt/mount.md5key/ root [ /usr/src/cblfs-200910/autofs-5.0.5 ]#
>>
>>
>> Is this behaviour normal? Is there a configuration switch?? Obvioulsy the
>> automounter allows autofs directories to exists, while the are not
>> connected.
>>
> 
> Well I've found the sollution to path's not disappearing. Somehow when in my script the environment variables are set like follows:
> 
> USE_MISC_DEVICE="no"
> BROWSE_MODE="no"
> APPEND_OPTIONS="yes"
> LOGGING="debug"
> 
> /usr/sbin/automount --pidfile /var/run/autofs.var-run-autofs-auto.master.pid  /var/run/autofs/auto.master
> 
> the automounter is not taking these values, what suprised me a lot! This is the way the automounter reads various settings, via the environment. Values in 
> /etc/sysconfig/autofs (or /etc/sysconfig/autofs.conf depends on your distro...) are read and set this way!
> Now when I do something like:
> 
> USE_MISC_DEVICE="no"
> export BROWSE_MODE="no"
> APPEND_OPTIONS="yes"
> export LOGGING="debug"
> 
> /usr/sbin/automount --pidfile /var/run/autofs.var-run-autofs-auto.master.pid  /var/run/autofs/auto.master
> 
> I can see that I get the desired behaviour: unmounted entries (keys) are deleted!
> I've checked the "file" environ in the /proc/3689 directory, and only found the values LOGGING and BROWSE_MODE, not USE_MISC_DEVICE and 
> APPEND_OPTIONS. But there is logging and browse_mode is not used!
> 
> So, am I missing here something? Or has something changed?
> When I look to the various init rc scripts, the file /etc/sysconfig/autofs  file is sourced.

In the init script the sourcing of the configuration is redundant but
environment variables that are exported will be seen by child processes
(as per normal shell environment variable export rules) and can be used
to over-ride the settings in the autofs configuration. Note that the
internal autofs default is BROWSE_MODE="yes" and that is set to "no" by
the default installed configuration for backward compatibility.

The USE_MISC_DEVICE is the only exception. It is used only by the init
script for checking if /dev/autofs is present and if we want to use
/dev/autofs for kernel communication.

Ian
