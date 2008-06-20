From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 14:24:31 +0100
Message-ID: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Unix Support <unix-support@ucs.cam.ac.uk>, Ian Kent <raven@themaw.net>

Hi,

The autofs 5.0.2 package that comes with opensuse 10.3 has a nasty  
denial of service attack in the automount daemon.  I can only assume  
that the code comes from the actual autofs source rather than being  
introduced by opensuse but I could be wrong (I haven't checked).

The bug is that automount searches /proc/*/cmdline for a substring  
that matches "automount" and refuses to run if it finds such a thing.

So any user that just does:

cat > automount.c <<EOD
int main(void)
{
	sleep(10000);
	return 0;
}
EOD
gcc -o automount.c
export PATH=.;$PATH
automount

And now no-one can run the real automount including root!

Even if this was not a DoS waiting to happen, why do you have this  
check in the code?  There is no reason whatsoever to try and restrict  
people from running multiple instances of the automount process...

We in fact run one automount instance for each logged in user on our  
Linux distribution for Cambridge University. - We now have to play  
silly buggers with running automount in such a way as to replace its  
argv[0] with a different string so we can run multiple instances.

But that still leaves the DoS attack that any user can run a program  
as above and no-one else will be able to log in any more as the  
automount process will find the literal string "automount" from the  
user's executable...

So we would really like the complete abomination that is autofs/daemon/ 
automount.c::is_automount_running() thrown away or at least made  
optional with a command line option if you insist on having it, pretty  
please with sugar on top?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
