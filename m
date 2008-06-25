From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Direct mount newbie question
Date: Wed, 25 Jun 2008 15:41:35 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A578E@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

Automounter 5.0.3 unpatched, vanilla, 2.6.24 Linux kernel also vanilla.

This is probably a really dumb question and the way I am doing it is
probably cause for some mirth, but if anybody have a better way, I am
all ears.

I have /home as an indirect mount point using a yp:auto.home key file.

I have an application that I have no control over nor ability to change
its behavior. It does many many searches for a file that I will call
.junk, starting at the cwd and going up the tree until it either finds /
or the file.  If the user is anywhere under the /home directory, this
search eventually tries to open /home/.junk and fails, but not until it
triggers the automounter to try to mount a non-existent directory named
.junk.  Because of the many searches, it seriously slows down execution
due to the automounting storm and consequent NFS dialogs over the
network.

A solution would be to have a permanent empty /home/.junk file present
as a last resort fail point for an application that searches for this
file and causes an automount storm since it  This seems to not be
possible because /home is a pseudo directory created by autofs as a
place to hang mounts off of (please correct me if this is an invalid
assumption).

The best compromise I could think of was to have a /home/.junk directory
that is there the moment automounter comes up and stays there, on all my
systems. Then, the application can try to open it but not trigger the
automounter, at least no more than once.

The best way I could see to do it was as such:

On the local auto.master, I added the line:
/- /etc/auto.data

...before the /home entry.  /etc/auto.data can be on the YP repository
some time in the future.

In /etc/auto.data, I have one line:
/home/.junk -mode=555,fstype=tmpfs,ro :/.junk

This seems to work just fine, except for a couple of weirdnesses:
1. When I applied a -HUP to the automounter, it created a ghosted
directory with mode of 755 instead of 555. This may be fixed by Ian's
patches regarding "abuse" of ghosting.  But, upon first access, the
directory (using ls -ld /home/.junkdirectory) then has the correct mode.
It looks like the local directory is remounted using the -bind option
and the proper mode.

2. I think I saw the directory get expired and also all /- entries in
/var/log/messages.  Then, "ls /home/.junkdirectory" came back with "ls:
/home/.junkdirectory: No such file or directory".  If this is true (that
it will not be automounted again after expiration), then this is not a
good solution.  If so, I am obviously misunderstanding direct mounts.
This may have been because of my testing where I needed to remove the
entry for /- in /etc/auto.master and forgot to send another HUP signal
to the automounter when I put it back in.  If this is true, then there
should be no problem  Is it possible that this can be expired off to the
point of not being able to be remounted?

In any event, can anyone suggest any better way to do what I want to do?

TIA.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
