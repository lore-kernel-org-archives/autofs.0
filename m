From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS5
Date: Tue, 14 Aug 2007 16:13:42 -0400
Message-ID: <x49vebh98nd.fsf@segfault.boston.devel.redhat.com>
References: <46C2005D.1090907@cs.ou.edu>
	<x498x8daovy.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x498x8daovy.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
	message of "Tue\, 14 Aug 2007 15\:37\:37 -0400")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Jeff Moyer <jmoyer@redhat.com> writes:

> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
>
>> Hello All,
>>
>> Just hit a hiccup with autofs5.  Everything was going along fine and then had 
>> a user call and say they could not get their home on a machine.  I did some 
>> quick checking and some mounts were working and others not.  below is a bit of 
>> the debug log and some other info.  the user, gerardo is the one who called 
>> me.  entries in the debug log for him are the same as the tmac user.  in that 
>> it get his ldap info tries to mount but then says it is already mounted and 
>> then fails????
>>
>> client machine is FC6 hand compiled autofs version:
>> autofs-5.0.1-20
>> autofs-debuginfo-5.0.1-20
>> with a patch from Ian.
>
> What is the kernel version on the client?

I'm guessing that you have 2.6.22.1-13.fc6 or later installed.  These
kernels include the "nosharecache" patch for NFS.  This patch can
cause some mounts to fail with -EBUSY.  You can revert the
nosharecache patch to get the old behaviour back.

Could you let us know what nfs mount options are used for your maps,
though, as this should only bite you if you try to mount from the same
server file system with different sets of mount options.  In other
words, your first mount from the server should succeed, successive
mount attempts of the same file system with differring options will
fail.

-Jeff
