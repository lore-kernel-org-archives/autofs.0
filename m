From: Paul Jakma <paul@clubi.ie>
Subject: Re: submount vs automount
Date: Mon, 28 Jun 2004 18:00:03 +0100 (IST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.60.0406281749540.13910@fogarty.jakma.org>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
	<40DC6F84.5020701@sun.com><40E03CC2.7020601@sun.com>
	<40E04693.1010507@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40E04693.1010507@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

On Mon, 28 Jun 2004, Mike Waychison wrote:

> This policy has to be determined on a machine-by-machine basis.  I 
> think we can agree to that.

Or site by site. (yeah, pam_console, eg, doesnt do directory lookups 
for config, but hey, maybe one day)

> I just chose to examine the :0 policy because doing so allows us to 
> explore the implications of such an implementation.

ok.

> For example, after considering the 'owner' bit, I realize now that
> autofs would:
>
> - still have to parse for such an option as it runs as root and would
> likely have to setuid to the user in question (so umount(8) still works).
>
> - which implies that automount would need to know who triggered the
> mount, which isn't possible without a protocol jump.

Yes, it would. I didnt realise automount did not have access to 
credentials of the process which triggered the 'lookup'.

> Going back to earlier discussion, when Jim Carter discussed the 
> 'first-acccess / mount-owner' scenario, I think there has to be a 
> compromise between security and functionality.  Prescribing 
> policies such as ':0' helps enforce some level of security access 
> to the medium,

:0 is a not good policy. The user on :0 might not be the user whose 
data is on the media autofs is to mount - which is a security breach. 
Further, are you suggesting that automount should know how to find 
out which user is on :0.0? I'd much rather leave that to pam_console 
than have automount reinvent that wheel.

> while the 'no-policy policy' is just as bad as setups described 
> above where your fd device file is o+rw.

The setups I described do not have the device as o+rw. Eg:

$ ls -l /dev/fd0
brw-rw----  1 paul floppy 2, 0 Feb 23 21:02 /dev/fd0

That's pam_console taking care of permissions when I login.

$ ls -l /dev/sg0
crw-rw----  1 root users 21, 0 Jul 12  2001 /dev/sg0
$ ls -l /dev/dri/card0
crw-rw----  1 root users 226, 0 Jun 23 02:57 /dev/dri/card0

$ groups
paul users

and those are statically configured group permission on a device and 
group membership.

Ok, the latter two are not mountable block devices, but they could be ;)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
Schapiro's Explanation:
 	The grass is always greener on the other side -- but that's
 	because they use more manure.
