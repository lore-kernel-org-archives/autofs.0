From: "Amodiovalerio [Hypo] Verde" <valerio.verde@moby.it>
Subject: Re: autofs and smb shares
Date: Sat, 3 Apr 2004 10:27:33 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <001601c41955$830a9580$51004701@mobylines.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

>>
>> If I do an ls it just give me a "ls: testdir: Invalid slot" until I
manually
>> umount the share. ( I'm able to umount the share manually without forcing
>> and without any error )

> Is the mount point busy or not?
> If it's not then autofs should umount it after the timeout.

That's the point.

When the mount point is NOT busy, it wont umount it after timeout.

I've looked the source code ( I'm not a C expert ) and I think the problem
is in the way it checks the mount point after the timeout.

Before umount the timed out mount point, it do a lstat, but it fails if the
shared dir is unavailable.

That way it doesn't even to try to umount the directory.

Fast way to test it :

Create a shared dir somewhere
Configure autofs
Enter in the directory so that autofs will mount it
Exit from that directory
Before timeout expires, unshare the dir
When the timeout expires, it wont umount the directory, nor remount it when
it became available again. You have to manually umount it, before be able to
autofs-mount it again.

I've solved the problem ( I hope ) just forcing the umount when the fstat
fails cause of errno like EBADSLT ( that's what I got when the share is not
more available ).

Maybe it's safe to umount the dir without doing a fstat at all.


Amodiovalerio [Hypo] Verde
