From: Alexander <normalex@gmail.com>
Subject: Re: Execute script on expire.
Date: Tue, 16 Sep 2008 17:44:53 -0700
Message-ID: <e788514b0809161744r3a91eec4v146c9852240f447f@mail.gmail.com>
References: <e788514b0809121300t3eba11a2j5833cc071db29b54@mail.gmail.com>
	<x49hc8l9kk8.fsf@segfault.boston.devel.redhat.com>
	<e788514b0809121341p4128b352n9dc592ef91a0b722@mail.gmail.com>
	<x49d4j99jdt.fsf@segfault.boston.devel.redhat.com>
	<e788514b0809121449v37289904y3dde16bb162e6083@mail.gmail.com>
	<x493ak0j7ng.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x493ak0j7ng.fsf@segfault.boston.devel.redhat.com>
Content-Disposition: inline
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Thank you for response.
I simply forgot to CC the list. Now it should work.

This is a simplified situation of using automatic squashfs container
generation with autofs.
---------------------------------------------------------------------------------------------------

User: john.
autofs path to make squashfs: /makesqfs
access mask: /makesqfs/<username>/<file name>

autofs path to access sqfs: /usercontainers
access mask: /usercontainers/<username>/<file name>

John wants to put one of his folders (/home/john/foldertoprocess) in a
secure storage as a squashfs container which can be accessed
automatically anytime.

he could make it by isssuing regular command
mksquashfs <source> <destination file name> -<options>
and copy resulted file to secure storage.

be he wants to use something simpler and robust.

Instead, John issues the following command:
cp /home/john/foldertoprocess /makesqfs/john/marketanalyzis

after some time he (and may be other users in the system) can access
his securely stored and read only files by following this symbolic
link
/containers/john/marketanalyzis


what happens on backend?
======================

when he copies files to
/makesqfs/john/marketanalyzis
autofs executes a script that prepares temporary folder somewhere
(/tmp/john/marketanalyzis)
and mounts it as /makesqfs/john/marketanalyzis

when copying finishes and timeout of 5 minutes of inactivity fires in autofs,
it executes a designated script and passes /makesqfs/john/marketanalyzis
as a parameter.
script makes a squashfs container marketanalyzis.sfs and puts it
somewhere in secure location, and then makes a symbolic link at
/containers/john/marketanalyzis
which points to
/usercontainers/john/marketanalyzis

after script is done, autofs successfully unmounts
/makesqfs/john/marketanalyzis

Notes:
i think script can also remount /makesqfs/john/marketanalyzis as read
only before making actual mksquashfs command.
with such approach squashfs container creation may be done on separate
computer, while mounting part can also be done from different
locations.


2008/9/16 Jeff Moyer <jmoyer@redhat.com>:
> Alexander <normalex@gmail.com> writes:
>
>> truly speaking i don't know what is semantics with offset mounts, but
>> can describe following situation.
>>
>> client access the folder /tmpstorage/filestocompress
>> it mounts as /tmp/filestocompress (where /tmp is a tmpfs/shmfs or
>> unionfs with different underlying mount points)
>> client then copies his files there and after time of inactivity
>> autofs executes script /bin/compress and after it's completion
>> unmounts all corresponding mount points.
>
> I'm not quite sure I follow.  If you could list the steps, taking
> automount out of the picture, that would be helpful.  So, what is the
> ordered list of steps to perform, using *exact* path names.  Above,
> what's confusing me is that an access to /tmpstorage/filestocompress
> would mount anything on /tmp.  Autofs simply doesn't work that way.
>
>> the /bin/compress script does following:
>> 0. it gets parameter of what path is going to be unmounted, in our
>> example it is /tmp/filestocompress
>> 1. makes compressed tar, bzip, or squashfs container from
>> /tmp/filestocompress in /users/username/filestocompress.tar
>> 2. optionaly deletes all files in /tmp/filestocompress and exits
>>
>> something like that
>
> Again, a specific example would be more helpful (with real commands and
> paths).
>
> I'm curious to know why you didn't CC the list on your response.  Is it
> okay if we continue discussions there?
>
> Thanks!
>
> Jeff
>



-- 
Sincerely,
Alexandr N.
